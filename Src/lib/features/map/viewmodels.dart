/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:vsa/features/map/state.dart';

class MapViewModel {
  static const LatLng BRISBANE_LATLNG = const LatLng(-27.4698, 153.0251);
  
  final MapState _state;

  const MapViewModel(this._state) : assert(_state != null);

  LatLng get userPoint => _state.userGpsPoint?.point ?? BRISBANE_LATLNG;
  MqttConnectionState get connectionState => _state.connectionState;

  bool get hasUserPoint => userPoint != null;

  String get server => "203.101.227.137";
  String get clientId => "autocar1";
  String get username => "qut";
  String get password => "qut";
}