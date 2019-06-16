/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vsa/features/map/state.dart';

class MapViewModel {
  static const LatLng BRISBANE_LATLNG = const LatLng(-27.4698, 153.0251);
  
  final MapState _state;

  const MapViewModel(this._state) : assert(_state != null);

  LatLng get userPoint => _state.userGpsPoint?.point ?? BRISBANE_LATLNG;

  bool get hasUserPoint => userPoint != null;
}