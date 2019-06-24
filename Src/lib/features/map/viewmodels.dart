/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:vsa/features/map/dtos.dart';
import 'package:vsa/features/map/state.dart';

class MapViewModel {
  static const LatLng BRISBANE_LATLNG = const LatLng(-27.4698, 153.0251);
  
  final MapState _state;

  const MapViewModel(this._state) : assert(_state != null);

  LatLng get userPoint => hasUserPoint
    ? LatLng(_state.userVehicle.point.latitude, _state.userVehicle.point.longitude)
    : BRISBANE_LATLNG;
  MqttConnectionState get connectionState => _state.connectionState;

  bool get hasUserPoint => _state.userVehicle.point != null;

  String get server => "203.101.227.137";
  String get clientId => "autocar1";
  String get username => "qut";
  String get password => "qut";
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

    if (_state.recordedPoints.isEmpty) {
      return "0.0";
    } else {
      final totalSpeed = _state.recordedPoints
        .map((GpsPointDto point) => point.speed)
        .reduce((double speed1, double speed2) => speed1 + speed2);
      final averageSpeed = totalSpeed / _state.recordedPoints.length;
      return averageSpeed.toStringAsFixed(2);
    }
  }
}