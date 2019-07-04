/// Authored by `@yuwonom (Michael Yuwono)`

import 'dart:async';

import 'package:location/location.dart';
import 'package:vsa/features/map/dtos.dart';

class Geolocator {  
  static Geolocator _instance;
  static Geolocator get instance {
    if (_instance == null) {
      _instance = Geolocator._();
    }
    return _instance;
  }

  static StreamController<GpsPointDto> _controller;

  const Geolocator._();

  Stream<GpsPointDto> get events {
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
    ..latitude = data.latitude
    ..longitude = data.longitude
    ..altitude = data.altitude
    ..accuracy = data.accuracy
    ..dateTime = DateTime.now().toUtc()
    ..speed = data.speed * 3.6 // Converts from m/s to km/h
    ..heading = data.heading));
}