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

List<Middleware<AppState>> getMiddleware(Geolocator geolocator, MqttApi mqttApi) => [
      LocalGpsIntegration(geolocator).getMiddlewareBindings(),
      MqttIntegration(mqttApi).getMiddlewareBindings(),
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

    print("${settingsState.statusRequestSubscribeTopic}/$clientId");
    
    final vehicle = store.state.map.userVehicle;
    final topic = "${settingsState.propertiesPublishTopic}/$clientId";
    final message = "${vehicle.id}, ${vehicle.name}, ${vehicle.dimension.toString()}";
    store.dispatch(PublishMessageToMqttBroker(topic, message));
    store.dispatch(RecordUserGpsPoint(vehicle.point));

    _nearbyRequestTimer = Timer.periodic(Duration(milliseconds: 100), (_) {
      final topic = "${settingsState.statusRequestPublishTopic}/$clientId";
      final message = "${vehicle.id}, 500";
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
    void _handlePublishMessage(MqttMessage message) {
      final publishMessage = message as MqttPublishMessage;
      if (message == null) {
        return;
      }

      final topic = publishMessage.variableHeader.topicName;
      final data = MqttPublishPayload.bytesToStringAsString(publishMessage.payload.message);
      
      // TODO: Hook to appropriate event
      print(topic + ": " + data);

      final settingsState = store.state.settings;
      if (topic.startsWith(settingsState.propertiesRequestSubscribeTopic)) {
        final vehicles = (jsonDecode(data) as List)
            .map((veh) => VehicleDto.fromJson(veh))
            .toList();
        final map = BuiltMap<String, VehicleDto>(Map<String, VehicleDto>
            .fromIterable(vehicles, key: (vehicle) => vehicle.id, value: (vehicle) => vehicle));

        store.dispatch(UpdateOtherVehiclesProperties(BuiltMap<String, VehicleDto>(map)));
      } else if (topic.startsWith(settingsState.statusRequestSubscribeTopic)) {
        final vehicles = (jsonDecode(data) as List)
            .map((veh) => VehicleDto.fromJson(veh))
            .toList();
        final map = BuiltMap<String, VehicleDto>(Map<String, VehicleDto>
            .fromIterable(vehicles, key: (vehicle) => vehicle.id, value: (vehicle) => vehicle));

        store.dispatch(UpdateOtherVehiclesStatus(BuiltMap<String, VehicleDto>(map)));
      } else if (topic.startsWith(settingsState.trafficRequestSubscribeTopic)) {

      }
    }

    _mqttListener = api.getDataStream().listen(_handlePublishMessage);
    next(action);
  }

  void _handleRecordUserGpsPoint(Store<AppState> store, RecordUserGpsPoint action, NextDispatcher next) {
    final clientId = store.state.settings.broker.clientId;
    final topic = "${store.state.settings.statusPublishTopic}/$clientId";
    final message = "${store.state.map.userVehicle.id}, " + 
      "${action.point.longitude}, " +
      "${action.point.latitude}, " +
      "${action.point.speed}, " +
      "${action.point.accuracy}, " +
      "${action.point.heading}";

    store.dispatch(PublishMessageToMqttBroker(topic, message));
    next(action);
  }
}