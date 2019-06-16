/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'dtos.g.dart';

abstract class GpsPointDto implements Built<GpsPointDto, GpsPointDtoBuilder> {
  factory GpsPointDto([void updates(GpsPointDtoBuilder b)]) = _$GpsPointDto;
  GpsPointDto._();

  LatLng get point;
  double get altitude;
  double get accuracy;
  DateTime get dateTime;

  static Serializer<GpsPointDto> get serializer => _$gpsPointDtoSerializer;
}