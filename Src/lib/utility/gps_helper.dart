/// Authored by `@yuwonom (Michael Yuwono)`

import 'dart:math' as math;

import 'package:vsa/features/map/dtos.dart';

class GpsHelper {
  static double averageSpeed(List<GpsPointDto> points) {
    final totalSpeed = points.fold(0.0, (double total, GpsPointDto next) => total + next.speed);
    return totalSpeed / points.length;
  }

  static double totalDistance(List<GpsPointDto> points) {
    double totalDistance = 0;

    for (int index = 0; index < points.length - 1; index++) {
      totalDistance += distance(points[index], points[index + 1]);
    }

    return totalDistance / 1000; // convert to kms
  }

  /// Calculate distance in metres from two gps points.
  /// Formula referenced from https://en.wikipedia.org/wiki/Haversine_formula
  static double distance(GpsPointDto point1, GpsPointDto point2) {
    const double radius = 6378.137; // radius of earth in KM
    
    final latitudeDiff = (point1.latitude * math.pi / 180.0) - (point2.latitude * math.pi / 180.0);
    final longitudeDiff = (point1.longitude * math.pi / 180.0) - (point2.longitude * math.pi / 180.0);    
    
    final a = math.pow(math.sin(latitudeDiff / 2), 2) + math.cos(point1.latitude * math.pi / 180) * math.cos(point2.latitude * math.pi / 180) * math.pow(math.sin(longitudeDiff / 2), 2);
    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    final d = radius * c;
    
    return d * 1000; // convert to meters
  }

  static bool isCollided(GpsPointDto point1, GpsPointDto point2, double radius) {
    final distance = GpsHelper.distance(point1, point2);
    return distance <= radius;
  }
}