/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:built_value/built_value.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:vsa/features/map/dtos.dart';
import 'package:vsa/utility/action_exception.dart';

part 'state.g.dart';

abstract class MapState implements Built<MapState, MapStateBuilder> {
  factory MapState([void updates(MapStateBuilder b)]) = _$MapState;
  
  factory MapState.initial() => _$MapState._(
    connectionState: MqttConnectionState.disconnected,
    isBusy: false,
  );

  MapState._();

  @nullable
  GpsPointDto get userGpsPoint;

  MqttConnectionState get connectionState;

  bool get isBusy;
  @nullable
  ActionException get exception;
}