/// Authored by `@yuwonom (Michael Yuwono)`

import 'dart:async';
import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/widgets.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:redux/redux.dart';
import 'package:vsa/features/map/actions.dart';
import 'package:vsa/features/map/dtos.dart';
import 'package:vsa/features/map/geolocator.dart';
import 'package:vsa/features/map/mqtt_api.dart';
import 'package:vsa/state.dart';
import 'package:vsa/utility/action_exception.dart';
import 'package:vsa/utility/gps_helper.dart';

List<Middleware<AppState>> getMiddleware(Geolocator geolocator, MqttApi mqttApi) => [
      LocalGpsIntegration(geolocator).getMiddlewareBindings(),
      MqttIntegration(mqttApi).getMiddlewareBindings(),
      CollisionCheck().getMiddlewareBindings(),
    ].expand((x) => x).toList();

@immutable
class LocalGpsIntegration {
  LocalGpsIntegration(this.geolocator) : assert(geolocator != null);
  
  final Geolocator geolocator;
  
  List<Middleware<AppState>> getMiddlewareBindings() => [
        TypedMiddleware<AppState, UpdateUserGpsPoint>(_handleUpdateUserGpsPoint),
      ];

  void _handleUpdateUserGpsPoint(Store<AppState> store, UpdateUserGpsPoint action, NextDispatcher next) {
    if (store.state.map.connectionState == MqttConnectionState.connected) {
      store.dispatch(RecordUserGpsPoint(action.point));
    }
    next(action);
  }
}

class MqttIntegration {
  MqttIntegration(this.api) : assert(api != null);
  
  final MqttApi api;

  List<Middleware<AppState>> getMiddlewareBindings() => [
        TypedMiddleware<AppState, ConnectToMqttBroker>(_handleConnectToMqttBroker),
        TypedMiddleware<AppState, ConnectToMqttBrokerSuccessful>(_handleConnectToMqttBrokerSuccessful),
        TypedMiddleware<AppState, DisconnectFromMqttBroker>(_handleDisconnectFromMqttBroker),
        TypedMiddleware<AppState, PublishMessageToMqttBroker>(_handlePublishMessageToMqttBroker),
        TypedMiddleware<AppState, ListenToMqttBroker>(_listenToMqttBroker),
        TypedMiddleware<AppState, RecordUserGpsPoint>(_handleRecordUserGpsPoint),
      ];

  StreamSubscription<MqttMessage> _mqttListener;
  Timer _nearbyRequestTimer;

  void _handleConnectToMqttBroker(Store<AppState> store, ConnectToMqttBroker action, NextDispatcher next) {
    Future<Null> _connectToMqttBroker(Store<AppState> store, ConnectToMqttBroker action) async {
      try {
        final result = await api.connect(action.server, action.clientId, action.username, action.password);
        if (result) {
          store.dispatch(ConnectToMqttBrokerSuccessful());
        } else {
          final exception = Exception("Failed connecting to broker.");
          store.dispatch(ConnectToMqttBrokerFailed(ActionException(exception, action)));
        }
      } on Exception catch (exception) {
        store.dispatch(ConnectToMqttBrokerFailed(ActionException(exception, action)));
      }
    }

    _connectToMqttBroker(store, action);
    next(action);
  }

  void _handleConnectToMqttBrokerSuccessful(Store<AppState> store, ConnectToMqttBrokerSuccessful action, NextDispatcher next) {
    final settingsState = store.state.settings;
    final clientId = store.state.settings.broker.clientId;
    api.subscribe([
      "${settingsState.propertiesRequestSubscribeTopic}/$clientId",
      "${settingsState.statusRequestSubscribeTopic}/$clientId",
      "${settingsState.trafficRequestSubscribeTopic}/$clientId",
    ]);
    
    final vehicle = store.state.map.userVehicle;
    final topic = "${settingsState.propertiesPublishTopic}/$clientId";
    final message = MqttApi.propertiesMessage(vehicle.id, vehicle.name, vehicle.type, vehicle.dimension);
    store.dispatch(PublishMessageToMqttBroker(topic, message));
    store.dispatch(RecordUserGpsPoint(vehicle.point));

    const requestInterval = const Duration(milliseconds: 100);
    _nearbyRequestTimer = Timer.periodic(requestInterval, (_) {
      final topic = "${settingsState.statusRequestPublishTopic}/$clientId";
      final message = MqttApi.statusRequestMessage(vehicle.id, 500);
      store.dispatch(PublishMessageToMqttBroker(topic, message));
    });
    
    store.dispatch(ListenToMqttBroker());
    next(action);
  }

  void _handleDisconnectFromMqttBroker(Store<AppState> store, DisconnectFromMqttBroker action, NextDispatcher next) {
    _mqttListener?.cancel();
    _nearbyRequestTimer?.cancel();
    
    api.disconnect();
    next(action);
  }

  void _handlePublishMessageToMqttBroker(Store<AppState> store, PublishMessageToMqttBroker action, NextDispatcher next) {
    void _publishMessageToMqttBroker(Store<AppState> store, PublishMessageToMqttBroker action) {
      try {
        api.publish(action.topic, action.message);
        store.dispatch(PublishMessageToMqttBrokerSuccessful());
      } on Exception catch (exception) {
        store.dispatch(PublishMessageToMqttBrokerFailed(ActionException(exception, action)));
      }
    }

    _publishMessageToMqttBroker(store, action);
    next(action);
  }

  void _listenToMqttBroker(Store<AppState> store, ListenToMqttBroker action, NextDispatcher next) {
    void _handlePropertiesRequestCallback(String data) {
      final vehicles = (jsonDecode(data) as List)
            .map((veh) => VehicleDto.fromJson(veh))
            .toList();
      final map = BuiltMap<String, VehicleDto>(Map<String, VehicleDto>
          .fromIterable(vehicles, key: (vehicle) => vehicle.id, value: (vehicle) => vehicle));

      store.dispatch(UpdateOtherVehiclesProperties(BuiltMap<String, VehicleDto>(map)));
    }

    void _handleStatusRequestCallback(String data) {
      final vehicles = (jsonDecode(data) as List)
            .map((veh) => VehicleDto.fromJson(veh))
            .toList();
      final map = BuiltMap<String, VehicleDto>(Map<String, VehicleDto>
          .fromIterable(vehicles, key: (vehicle) => vehicle.id, value: (vehicle) => vehicle));

      final newVehicleIds = vehicles
        .where((VehicleDto veh) => !store.state.map.otherVehicles.containsKey(veh.id))
        .map((VehicleDto veh) => veh.id)
        .toList();

      store.dispatch(UpdateOtherVehiclesStatus(BuiltMap<String, VehicleDto>(map)));

      // Get properties if there are new vehicles
      if (newVehicleIds.isNotEmpty) {
        final settingsState = store.state.settings;
        final topic = "${settingsState.propertiesRequestPublishTopic}/${settingsState.broker.clientId}";
        final message = MqttApi.propertiesRequestMessage(newVehicleIds);
        store.dispatch(PublishMessageToMqttBroker(topic, message));
      }
    }

    void _handleTrafficRequestCallback(String data) {
      // TODO: Handle traffic request callback
    }

    void _handleRequestCallback(MqttMessage message) {
      final publishMessage = message as MqttPublishMessage;
      if (message == null) {
        return;
      }

      final topic = publishMessage.variableHeader.topicName;
      final data = MqttPublishPayload.bytesToStringAsString(publishMessage.payload.message);

      final settingsState = store.state.settings;
      if (topic.startsWith(settingsState.propertiesRequestSubscribeTopic)) {
        _handlePropertiesRequestCallback(data);
      } else if (topic.startsWith(settingsState.statusRequestSubscribeTopic)) {
        _handleStatusRequestCallback(data);
      } else if (topic.startsWith(settingsState.trafficRequestSubscribeTopic)) {
        _handleTrafficRequestCallback(data);
      }
    }

    _mqttListener = api.getDataStream().listen(_handleRequestCallback);
    next(action);
  }

  void _handleRecordUserGpsPoint(Store<AppState> store, RecordUserGpsPoint action, NextDispatcher next) {
    final clientId = store.state.settings.broker.clientId;
    final topic = "${store.state.settings.statusPublishTopic}/$clientId";
    final message = MqttApi.statusMessage(store.state.map.userVehicle.id, action.point);
    store.dispatch(PublishMessageToMqttBroker(topic, message));
    next(action);
  }
}

@immutable
class CollisionCheck {
  const CollisionCheck();

  List<Middleware<AppState>> getMiddlewareBindings() => [
        TypedMiddleware<AppState, UpdateUserGpsPoint>(_handleCheckCollision),
        TypedMiddleware<AppState, UpdateOtherVehiclesProperties>(_handleCheckCollision),
        TypedMiddleware<AppState, UpdateOtherVehiclesStatus>(_handleCheckCollision),
      ];
  
  void _handleCheckCollision(Store<AppState> store, dynamic action, NextDispatcher next) {
    next(action);

    if (store.state.map.otherVehicles.length == 0) {
      final safeLevel = SecurityLevelDto.withLevel(1);
      store.dispatch(UpdateSecurityLevel(safeLevel));
      return;
    }
    
    final userVehicle = store.state.map.userVehicle;
    final userPoint = userVehicle.point;
    
    final closestNode = store.state.map.otherVehicles.values
      .reduce((VehicleDto node, VehicleDto next) => 
        GpsHelper.distance(node.point, userPoint) <= GpsHelper.distance(next.point, userPoint) ? node : next);
    final distance = GpsHelper.distance(closestNode.point, userPoint);

    const SAFE_DISTANCE = 10.0;
    var securityLevel = SecurityLevelDto.unknown;
    if (distance <= userVehicle.dimension.average + closestNode.dimension.average) {
      securityLevel = SecurityLevelDto.withLevel(5);
    } else if (distance <= userVehicle.dimension.average + closestNode.point.accuracy) {
      securityLevel = SecurityLevelDto.withLevel(4);
    } else if (distance <= userPoint.accuracy + closestNode.point.accuracy) {
      securityLevel = SecurityLevelDto.withLevel(3);
    } else if (distance <= userPoint.accuracy + closestNode.point.accuracy + SAFE_DISTANCE) {
      securityLevel = SecurityLevelDto.withLevel(2);
    } else {
      securityLevel = SecurityLevelDto.withLevel(1);
    }

    store.dispatch(UpdateSecurityLevel(securityLevel));
  }
}