/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:vsa/features/map/dtos.dart';
import 'package:vsa/utility/action_exception.dart';

part 'state.g.dart';

abstract class MapState implements Built<MapState, MapStateBuilder> {
  factory MapState([void updates(MapStateBuilder b)]) = _$MapState;
  
  factory MapState.initial() => _$MapState._(
    userVehicle: VehicleDto.initial(),
    connectionState: MqttConnectionState.disconnected,
    securityLevel: SecurityLevelDto.unknown,
    recordedPoints: BuiltList<GpsPointDto>(),
    otherVehicles: BuiltMap<String, VehicleDto>(),
    intersections: BuiltList<IntersectionDto>(),
    isBusy: false,
  );

  MapState._();

  VehicleDto get userVehicle;
  MqttConnectionState get connectionState;
  SecurityLevelDto get securityLevel;

  @nullable
  DateTime get startTime;
  BuiltList<GpsPointDto> get recordedPoints;

  BuiltMap<String, VehicleDto> get otherVehicles;
  BuiltList<IntersectionDto> get intersections;

  bool get isBusy;
  @nullable
  ActionException get exception;
}