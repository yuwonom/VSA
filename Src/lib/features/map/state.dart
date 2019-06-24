/// Authored by `@yuwonom (Michael Yuwono)`

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
    recordedPoints: List<GpsPointDto>(),
    isBusy: false,
  );

  MapState._();

  VehicleDto get userVehicle;
  MqttConnectionState get connectionState;
  SecurityLevelDto get securityLevel;

  @nullable
  DateTime get startTime;
  List<GpsPointDto> get recordedPoints;

  bool get isBusy;
  @nullable
  ActionException get exception;
}