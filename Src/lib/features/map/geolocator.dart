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

  StreamController<GpsPointDto> _controller;
  Location _location;
  StreamSubscription<LocationData> _locationDataStream;
 
  Geolocator._() {
    const int interval = 1000;
    const double distanceFilter = 1;

    _location = Location()
      ..changeSettings(
        accuracy: LocationAccuracy.high,
        interval: interval,
        distanceFilter: distanceFilter,
      );

    _requestLocation()
      .then((_) => _location.onLocationChanged
        .listen((LocationData data) => _addGpsPoint(data)));

    resetController();
  }

  Future<void> _requestLocation() async {
    var enabled = await _location.serviceEnabled();
    if (!enabled) {
      enabled = await _location.requestService();
      if (!enabled) {
        return;
      }
    }

    var status = await _location.hasPermission();
    if (status == PermissionStatus.denied) {
      status = await _location.requestPermission();
      if (status != PermissionStatus.granted) {
        return;
      }
    }
  }

  Stream<GpsPointDto> getEvents() => _controller.stream;

  void resetController() {
    _controller?.close();
    _controller = StreamController<GpsPointDto>();
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