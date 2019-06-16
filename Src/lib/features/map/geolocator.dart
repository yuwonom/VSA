/// Authored by `@yuwonom (Michael Yuwono)`

import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:vsa/features/map/dtos.dart';

class Geolocator {
  static StreamController<GpsPointDto> _controller;

  Stream<GpsPointDto> getPositionStream() {
    const int interval = 1000;
    const double distanceFilter = 1;

    _controller?.close();
    _controller = StreamController<GpsPointDto>();

    final location = Location();
    location.changeSettings(
      accuracy: LocationAccuracy.HIGH,
      interval: interval,
      distanceFilter: distanceFilter,
    );

    location.requestPermission().then((granted) {
      if (granted) {
        location.onLocationChanged().listen((LocationData data) => _addGpsPoint(data));
      }
    });
    
    return _controller.stream;
  }

  void _addGpsPoint(LocationData data) => _controller.add(GpsPointDto((b) => b
    ..point = LatLng(data.latitude, data.longitude)
    ..altitude = data.altitude
    ..accuracy = data.accuracy
    ..dateTime = DateTime.now().toUtc()));
}