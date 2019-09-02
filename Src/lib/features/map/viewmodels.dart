/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:built_collection/built_collection.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:vsa/features/map/dtos.dart';
import 'package:vsa/features/map/state.dart';
import 'package:vsa/features/settings/dtos.dart';
import 'package:vsa/features/settings/state.dart';
import 'package:vsa/utility/gps_helper.dart';

class MapViewModel {
  static const LatLng BRISBANE_LATLNG = const LatLng(-27.4698, 153.0251);
  
  static const int USER_VEHICLE_ZINDEX = 6;
  static const int OTHER_VEHICLE_ZINDEX = 5;
  static const int USER_ACCURACY_ZINDEX = 4;
  static const int OTHER_ACCURACY_ZINDEX = 3;
  static const int TRAFFIC_ZINDEX = 2;
  static const int INTERSECTION_ZINDEX = 1;

  final MapState _mapState;
  final SettingsState _settingsState;

  const MapViewModel(this._mapState, this._settingsState)
    : assert(_mapState != null && _settingsState != null);

  VehicleDto get userVehicle => _mapState.userVehicle;

  LatLng get userPoint => hasUserPoint
    ? LatLng(_mapState.userVehicle.point.latitude, _mapState.userVehicle.point.longitude)
    : BRISBANE_LATLNG;

  MqttConnectionState get connectionState => _mapState.connectionState;

  SecurityLevelDto get securityLevel => _mapState.securityLevel;

  bool get hasUserPoint => _mapState.userVehicle.point != null;

  BuiltMap<String, VehicleDto> get otherVehicles => _mapState.otherVehicles;
  
  bool get hasOtherVehicles => otherVehicles.isNotEmpty;

  BuiltList<IntersectionDto> get intersections => _mapState.intersections;
  
  bool get hasIntersections => intersections.isNotEmpty;

  BrokerDto get broker => _settingsState.broker;

  String get address => broker.address;
  String get port => broker.port;
  String get username => broker.username;
  String get password => broker.password;
  String get clientId => broker.clientId;
}

class DetailsViewModel {
  final MapState _state;

  const DetailsViewModel(this._state) : assert(_state != null);

  bool get connectedToBroker => _state.connectionState == MqttConnectionState.connected;
  
  DateTime get startTime => _state.startTime;

  String get securityLevelText => connectedToBroker ? _state.securityLevel.toString() : "-";

  String get currentSpeedText => _state.userVehicle.point?.speed?.toStringAsFixed(2) ?? "0.0";

  String get averageSpeedText {
    if (!connectedToBroker) {
      return "-";
    }

    return _state.recordedPoints.isNotEmpty
      ? GpsHelper.averageSpeed(_state.recordedPoints.asList()).toStringAsFixed(2)
      : "0.0";
  }

  String get distanceText {
    if (!connectedToBroker) {
      return "-";
    }

    return _state.recordedPoints.isNotEmpty
      ? GpsHelper.totalDistance(_state.recordedPoints.asList()).toStringAsFixed(2)
      : "0.0";
  }

  String get accuracyText => _state.userVehicle.point?.accuracy?.toStringAsFixed(2) ?? "0";
}