/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'dtos.g.dart';

abstract class GpsPointDto implements Built<GpsPointDto, GpsPointDtoBuilder> {
  factory GpsPointDto([void updates(GpsPointDtoBuilder b)]) = _$GpsPointDto;
  
  factory GpsPointDto.fromLatLng(LatLng latLng) => _$GpsPointDto._(
    latitude: latLng.latitude,
    longitude: latLng.longitude,
    altitude: 0,
    accuracy: 0,
    dateTime: DateTime.now(),
    speed: 0,
    heading: 0,
  );

  GpsPointDto._();

  double get latitude;
  double get longitude;
  double get altitude;
  double get accuracy;
  DateTime get dateTime;
  double get speed;
  double get heading;

  static Serializer<GpsPointDto> get serializer => _$gpsPointDtoSerializer;

  LatLng toLatLng() => LatLng(latitude, longitude);
}

abstract class VehicleDto implements Built<VehicleDto, VehicleDtoBuilder> {
  factory VehicleDto([void updates(VehicleDtoBuilder b)]) = _$VehicleDto;

  factory VehicleDto.fromJson(Map<String, Object> data) => _$VehicleDto._(
    id: data["id"] ?? "",
    name: data["name"] ?? "",
    dimension: data.containsKey("dimensions")
      ? VehicleDimensionDto.fromString(data["dimensions"])
      : VehicleDimensionDto.none(),
    type: data.containsKey("type")
      ? VehicleTypeDto.valueOf(data["type"])
      : VehicleTypeDto.car,
    point: (GpsPointDtoBuilder()
        ..latitude = double.parse(data["lat"] ?? 0.toString())
        ..longitude = double.parse(data["lng"] ?? 0.toString())
        ..altitude = double.parse(data["alt"] ?? 0.toString())
        ..accuracy = double.parse(data["acc"] ?? 0.toString())
        ..speed = double.parse(data["vel"] ?? 0.toString())
        ..heading = double.parse(data["ang"] ?? 0.toString())
        ..dateTime = DateTime.now())
      .build(),
  );

  factory VehicleDto.initial() => _$VehicleDto._(
    id: "VSA1",
    name: "VSA Autocar",
    dimension: VehicleDimensionDto.none(),
    type: VehicleTypeDto.car,
  );

  VehicleDto._();

  String get id;
  String get name;
  VehicleDimensionDto get dimension;
  VehicleTypeDto get type;
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

  factory VehicleDimensionDto.fromString(String value) {
    double parseSide(int index) => double.parse(value.split(",")[index].trim());

    return _$VehicleDimensionDto._(
      left: parseSide(0),
      top: parseSide(1),
      right: parseSide(2),
      bottom: parseSide(3),
    );
  }

  factory VehicleDimensionDto.none() => _$VehicleDimensionDto._(left: 0.0, top: 0.0, right: 0.0, bottom: 0.0);

  VehicleDimensionDto._();

  double get left;
  double get top;
  double get right;
  double get bottom;
  double get average => (left + top + right + bottom) / 4;

  static Serializer<VehicleDimensionDto> get serializer => _$vehicleDimensionDtoSerializer;

  @override
  String toString() => "$left, $top, $right, $bottom";
}

class VehicleTypeDto extends EnumClass {
  static const VehicleTypeDto car = _$car;
  static const VehicleTypeDto cycle = _$cycle;
  static const VehicleTypeDto motorbike = _$motorbike;
  static const VehicleTypeDto scooter = _$scooter;
  static const VehicleTypeDto pedestrian = _$pedestrian;

  const VehicleTypeDto._(String name) : super(name);

  static Serializer<VehicleTypeDto> get serializer => _$vehicleTypeDtoSerializer;

  static BuiltSet<VehicleTypeDto> get values => _$vehicleTypeDtoValues;
  static VehicleTypeDto valueOf(String name) => _$vehicleTypeDtoValueOf(name);
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

abstract class IntersectionDto implements Built<IntersectionDto, IntersectionDtoBuilder> {
  factory IntersectionDto([void updates(IntersectionDtoBuilder b)]) = _$IntersectionDto;

  factory IntersectionDto.fromLine(String line) {
    final args = line.split(',');
    final id = args[0];
    final latLng = LatLng(double.parse(args[1]), double.parse(args[2]));
    final radius = double.parse(args[3]);
    return _$IntersectionDto._(
      id: id,
      latLng: latLng,
      radius: radius,
    );
  }

  IntersectionDto._();

  String get id;
  LatLng get latLng;
  double get radius;

  static Serializer<IntersectionDto> get serializer => _$intersectionDtoSerializer;
}