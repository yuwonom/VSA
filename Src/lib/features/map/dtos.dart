/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dtos.g.dart';

abstract class GpsPointDto implements Built<GpsPointDto, GpsPointDtoBuilder> {
  factory GpsPointDto([void updates(GpsPointDtoBuilder b)]) = _$GpsPointDto;

  GpsPointDto._();

  double get latitude;
  double get longitude;
  double get altitude;
  double get accuracy;
  DateTime get dateTime;
  double get speed;
  double get heading;

  static Serializer<GpsPointDto> get serializer => _$gpsPointDtoSerializer;
}

abstract class VehicleDto implements Built<VehicleDto, VehicleDtoBuilder> {
  factory VehicleDto([void updates(VehicleDtoBuilder b)]) = _$VehicleDto;

  factory VehicleDto.initial() => _$VehicleDto._(
    id: "",
    dimension: VehicleDimensionDto.none(),
  );

  VehicleDto._();

  String get id;
  VehicleDimensionDto get dimension;
  @nullable
  GpsPointDto get point;

  static Serializer<VehicleDto> get serializer => _$vehicleDtoSerializer;
}

abstract class VehicleDimensionDto implements Built<VehicleDimensionDto, VehicleDimensionDtoBuilder> {
  factory VehicleDimensionDto([void updates(VehicleDimensionDtoBuilder b)]) = _$VehicleDimensionDto;

  factory VehicleDimensionDto.fromLTRB(double left, double top, double right, double bottom) => _$VehicleDimensionDto._(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
    );

  factory VehicleDimensionDto.none() => _$VehicleDimensionDto._(left: 0.0, top: 0.0, right: 0.0, bottom: 0.0);

  VehicleDimensionDto._();

  double get left;
  double get top;
  double get right;
  double get bottom;

  static Serializer<VehicleDimensionDto> get serializer => _$vehicleDimensionDtoSerializer;
}

class SecurityLevelDto extends EnumClass {
  static const SecurityLevelDto unknown = _$unknown;
  static const SecurityLevelDto secured = _$secured;
  static const SecurityLevelDto controlled = _$controlled;
  static const SecurityLevelDto cautious = _$cautious;
  static const SecurityLevelDto dangerous = _$dangerous;
  static const SecurityLevelDto critical = _$critical;

  const SecurityLevelDto._(String name) : super(name);

  static Serializer<SecurityLevelDto> get serializer => _$securityLevelDtoSerializer;

  static BuiltSet<SecurityLevelDto> get values => _$securityLevelDtoValues;
  static SecurityLevelDto valueOf(String name) => _$securityLevelDtoValueOf(name);

  static SecurityLevelDto withLevel(int level) {
    switch (level) {
      case 1:
        return _$secured;
      case 2:
        return _$controlled;
      case 3:
        return _$cautious;
      case 4:
        return _$dangerous;
      case 5:
        return _$critical;
      default:
        return _$unknown;
    }
  }
}