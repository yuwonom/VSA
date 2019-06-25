/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:vsa/features/map/state.dart';
import 'package:vsa/utility/gps_helper.dart';

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

    return _state.recordedPoints.isNotEmpty
      ? GpsHelper.averageSpeed(_state.recordedPoints).toStringAsFixed(2)
      : "0.0";
  }

  String get distanceText {
    if (!connectedToBroker) {
      return "-";
    }

    return _state.recordedPoints.isNotEmpty
      ? GpsHelper.totalDistance(_state.recordedPoints).toStringAsFixed(2)
      : "0.0";
  }

  String get accuracyText => _state.userVehicle.point?.accuracy?.toStringAsFixed(2) ?? "0";
}