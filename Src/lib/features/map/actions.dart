/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:meta/meta.dart';
import 'package:vsa/features/map/dtos.dart';

@immutable
class ListenToGeolocator {
  @override
  String toString() => "ListenToGeolocator";
}

@immutable
class UpdateUserGpsPoint {
  UpdateUserGpsPoint(this.point) : assert (point != null);

  final GpsPointDto point;
  
  @override
  String toString() => "UpdateUserGpsPoint $point";
}