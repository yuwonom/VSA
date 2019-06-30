/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:built_value/built_value.dart';
import 'package:vsa/features/settings/dtos.dart';
import 'package:vsa/utility/action_exception.dart';

part 'state.g.dart';

abstract class SettingsState implements Built<SettingsState, SettingsStateBuilder> {
  factory SettingsState([void updates(SettingsStateBuilder b)]) = _$SettingsState;
  
  factory SettingsState.initial() => _$SettingsState._(
    broker: (BrokerDtoBuilder()
        ..address = "203.101.227.137"
        ..port = "3306"
        ..clientId = "autocar1"
        ..username = "qut"
        ..password = "qut")
      .build(),
    isBusy: false,
  );

  SettingsState._();

  BrokerDto get broker;

  bool get isBusy;
  @nullable
  ActionException get exception;
}