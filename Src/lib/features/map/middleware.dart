/// Authored by `@yuwonom (Michael Yuwono)`

import 'dart:async';
import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/widgets.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:redux/redux.dart';
import 'package:vsa/features/map/actions.dart';
import 'package:vsa/features/map/dtos.dart';
import 'package:vsa/features/settings/state.dart';
import 'package:vsa/state.dart';
import 'package:vsa/utility/action_exception.dart';
import 'package:vsa/utility/geolocator.dart';
import 'package:vsa/utility/gps_helper.dart';
import 'package:vsa/utility/mqtt_api.dart';
import 'package:vsa/utility/text_to_speech.dart';

List<Middleware<AppState>> getMiddleware(Geolocator geolocator, MqttApi mqttApi, TextToSpeech tts) => [
      LocalGpsIntegration(geolocator).getMiddlewareBindings(),
      MqttIntegration(mqttApi).getMiddlewareBindings(),
      CollisionCheck().getMiddlewareBindings(),
      VoiceWarning(tts).getMiddlewareBindings(),
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
        TypedMiddleware<AppState, UpdateCurrentIntersectionId>(_handleSetCurrentIntersectionId),
      ];

  StreamSubscription<MqttMessage> _mqttListener;
  Timer _nearbyRequestTimer;

  void _handleConnectToMqttBroker(Store<AppState> store, ConnectToMqttBroker action, NextDispatcher next) {
    Future<Null> _connectToMqttBroker(Store<AppState> store, ConnectToMqttBroker action) async {
      try {
        await Future.delayed(const Duration(seconds: 1)); // Artificial delay
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
    void _publishProperties(SettingsState settings, VehicleDto user) {
      // Basic messages
      if (settings.isActiveBasicVehicle) {
        final topic = "${settings.propertiesPublishTopic}/${user.id}";
        final message = MqttApi.propertiesMessage(user.id, user.name, user.type, user.dimension);
        store.dispatch(PublishMessageToMqttBroker(topic, message));
      }

      // Level A messages
      if (settings.isActiveLevelA && user.type == VehicleTypeDto.cycle) {
        final topic = "${settings.levelAPropertiesPublishTopic}";
        final message = MqttApi.propertiesMessage(user.id, user.name, user.type, user.dimension);
        store.dispatch(PublishMessageToMqttBroker(topic, message));
      }
      
      // Intersection messages
      store.dispatch(PublishMessageToMqttBroker("${settings.intersectionsRequestPublishTopic}/${user.id}", ""));
      
      store.dispatch(RecordUserGpsPoint(user.point));
    }
    
    void _subscribeTopics(SettingsState settings, VehicleDto user) {
      final topics = <String>[
        "${settings.propertiesRequestSubscribeTopic}/${user.id}",
      ];
      
      // Basic messages
      if (settings.isActiveBasicVehicle) {
        topics.add("${settings.statusRequestSubscribeTopic}/${user.id}");
      }

      // Level A messages
      if (settings.isActiveBasicTraffic) {
        topics.add("${settings.trafficRequestSubscribeTopic}/${user.id}");
      }

      // Intersection messages
      topics.add("${settings.intersectionsRequestSubscribeTopic}/${user.id}");

      if (topics.isNotEmpty) {
        api.subscribe(topics);
      }
    }

    void _startPeriodicRequests(SettingsState settings, Timer timer, Duration interval, VehicleDto user) {
      _nearbyRequestTimer = Timer.periodic(interval, (_) {
        String topic;
        String message;

        if (settings.isActiveBasicVehicle) {
          topic = "${settings.statusRequestPublishTopic}/${user.id}";
          message = MqttApi.statusRequestMessage(user.id, 500);
          store.dispatch(PublishMessageToMqttBroker(topic, message));
        }
      });
    }
    
    final mapState = store.state.map;
    final user = mapState.userVehicle;
    final settingsState = store.state.settings;
    const requestInterval = const Duration(milliseconds: 100);

    _subscribeTopics(settingsState, user);
    _publishProperties(settingsState, user);
    _startPeriodicRequests(settingsState, _nearbyRequestTimer, requestInterval, user);
    
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
        .where((veh) => veh.id != store.state.map.userVehicle.id)
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
        final vehicleId = store.state.map.userVehicle.id;
        final baseTopic = store.state.settings.propertiesRequestPublishTopic;
        final topic = "$baseTopic/$vehicleId";
        final message = MqttApi.propertiesRequestMessage(newVehicleIds);
        store.dispatch(PublishMessageToMqttBroker(topic, message));
      }
    }

    void _handleTrafficRequestCallback(String data) {
      // TODO: Handle traffic request callback
    }

    void _handleLevelAIntersectionCallback(String data) {
      _handleStatusRequestCallback(data);
    }

    void _handleIntersectionsRequestCallback(String data) {
      final intersectionsJson = jsonDecode(data) as List;
      final intersections = intersectionsJson
        .map((json) => IntersectionDto.fromJson(json))
        .toList();
      store.dispatch(LoadIntersections(intersections.build()));
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
      } else if (topic.startsWith(settingsState.levelAIntersectionSubscribeTopic)) {
        _handleLevelAIntersectionCallback(data);
      } else if (topic.startsWith(settingsState.intersectionsRequestSubscribeTopic)) {
        _handleIntersectionsRequestCallback(data);
      }
    }

    _mqttListener = api.getDataStream().listen(_handleRequestCallback);
    next(action);
  }

  void _handleRecordUserGpsPoint(Store<AppState> store, RecordUserGpsPoint action, NextDispatcher next) {
    final mapState = store.state.map;
    final user = mapState.userVehicle;
    final intersectionId = mapState.currentIntersectionId;
    final settingsState = store.state.settings;

    String topic;
    final message = MqttApi.statusMessage(user.id, action.point);

    if (settingsState.isActiveBasicVehicle) {
      topic = "${settingsState.statusPublishTopic}/${user.id}";
      store.dispatch(PublishMessageToMqttBroker(topic, message));
    }
    if (settingsState.isActiveLevelA && user.type == VehicleTypeDto.cycle && intersectionId != null) {
      topic = "${settingsState.levelAStatusPublishTopic}/$intersectionId";
      store.dispatch(PublishMessageToMqttBroker(topic, message));
    }

    next(action);
  }

  void _handleSetCurrentIntersectionId(Store<AppState> store, UpdateCurrentIntersectionId action, NextDispatcher next) {
    void _syncIntersectionSubscription(String topic, String oldId, String newId) {
      if (oldId != null && oldId != newId) {
        api.unsubscribe(["$topic/$oldId"]);
      }
      if (newId != null) {
        api.subscribe(["$topic/$newId"]);
      }
    }

    final mapState = store.state.map;
    final settingsState = store.state.settings;

    if (mapState.connectionState != MqttConnectionState.connected) {
      next(action);
      return;
    }

    if (settingsState.isActiveLevelA && mapState.userVehicle.type == VehicleTypeDto.car) {
      _syncIntersectionSubscription(
        settingsState.levelAIntersectionSubscribeTopic,
        mapState.currentIntersectionId,
        action.id);
    }

    next(action);
  }
}

@immutable
class CollisionCheck {
  const CollisionCheck();

  List<Middleware<AppState>> getMiddlewareBindings() => [
        TypedMiddleware<AppState, UpdateUserGpsPoint>(_handleCheckVehicleCollision),
        TypedMiddleware<AppState, UpdateOtherVehiclesProperties>(_handleCheckVehicleCollision),
        TypedMiddleware<AppState, UpdateOtherVehiclesStatus>(_handleCheckVehicleCollision),
        TypedMiddleware<AppState, UpdateUserGpsPoint>(_handleCheckIntersectionsCollision),
      ];
  
  void _handleCheckVehicleCollision(Store<AppState> store, dynamic action, NextDispatcher next) {
    next(action);

    if (store.state.map.otherVehicles.length == 0) {
      final safeLevel = SecurityLevelDto.withLevel(1);
      store.dispatch(UpdateSecurityLevel(safeLevel));
      return;
    }
    
    final userVehicle = store.state.map.userVehicle;
    final userPoint = userVehicle.point;
    
    final closestOtherVehicle = store.state.map.otherVehicles.values
      .reduce((VehicleDto node, VehicleDto next) => 
        GpsHelper.distance(node.point, userPoint) <= GpsHelper.distance(next.point, userPoint) ? node : next);
    final distance = GpsHelper.distance(closestOtherVehicle.point, userPoint);

    const SAFE_DISTANCE = 10.0;
    var securityLevel = SecurityLevelDto.unknown;
    if (distance <= userVehicle.dimension.average + closestOtherVehicle.dimension.average) {
      securityLevel = SecurityLevelDto.withLevel(5);
    } else if (distance <= userVehicle.dimension.average + closestOtherVehicle.point.accuracy) {
      securityLevel = SecurityLevelDto.withLevel(4);
    } else if (distance <= userPoint.accuracy + closestOtherVehicle.point.accuracy) {
      securityLevel = SecurityLevelDto.withLevel(3);
    } else if (distance <= userPoint.accuracy + closestOtherVehicle.point.accuracy + SAFE_DISTANCE) {
      securityLevel = SecurityLevelDto.withLevel(2);
    } else {
      securityLevel = SecurityLevelDto.withLevel(1);
    }

    store
      ..dispatch(UpdateSecurityLevel(securityLevel))
      ..dispatch(UpdateClosestOtherVehicleId(closestOtherVehicle.id));
  }

  void _handleCheckIntersectionsCollision(Store<AppState> store, UpdateUserGpsPoint action, NextDispatcher next) {
    final intersections = store.state.map.intersections;
    final collidedIntersections = intersections
      .where((IntersectionDto intersection) => GpsHelper
        .isCollided(
          action.point,
          GpsPointDto.fromLatLng(intersection.latLng),
          intersection.radius))
      .toList();

    final id = collidedIntersections.length > 0 
      ? collidedIntersections.first.id : null;

    store.dispatch(UpdateCurrentIntersectionId(id));
    next(action);
  }
}

@immutable
class VoiceWarning {
  const VoiceWarning(this.tts) : assert(tts != null);

  final TextToSpeech tts;

  List<Middleware<AppState>> getMiddlewareBindings() => [
        TypedMiddleware<AppState, ConnectToMqttBroker>(_handleConnectionStateChange),
        TypedMiddleware<AppState, ConnectToMqttBrokerSuccessful>(_handleConnectionStateChange),
        TypedMiddleware<AppState, ConnectToMqttBrokerFailed>(_handleConnectionStateChange),
        TypedMiddleware<AppState, DisconnectFromMqttBroker>(_handleConnectionStateChange),
        TypedMiddleware<AppState, UpdateSecurityLevel>(_handleUpdateSecurityLevel),
      ];
  
  void _handleConnectionStateChange(Store<AppState> store, dynamic action, NextDispatcher next) async { 
    next(action);

    switch (store.state.map.connectionState) {
      case MqttConnectionState.connected:
        return tts.speak("Connected");
      case MqttConnectionState.disconnected:
        return tts.speak("Disconnected");
      case MqttConnectionState.faulted:
        return tts.speak("Failed to connect");
      default:
        return;
    }
  }

  void _handleUpdateSecurityLevel(Store<AppState> store, UpdateSecurityLevel action, NextDispatcher next) {
    final currentLevel = store.state.map.securityLevel;
    if (currentLevel == action.level) {
      return;
    }

    if (currentLevel < SecurityLevelDto.dangerous && action.level > SecurityLevelDto.controlled) {
      tts.speak("Warning! Possible collision detected");
    }

    next(action);
  }
}