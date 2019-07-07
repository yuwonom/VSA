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
        ..clientId = "VSA1"
        ..username = "qut"
        ..password = "qut")
      .build(),
    propertiesPublishTopic: "VSA/vehSim",
    statusPublishTopic: "VSA/vehProp",
    propertiesRequestPublishTopic: "VSA/request/vehProp/reqs",
    propertiesRequestSubscribeTopic: "VSA/request/vehProp/return",
    statusRequestPublishTopic: "VSA/request/vehSim/reqs",
    statusRequestSubscribeTopic: "VSA/request/vehSim/return",
    trafficRequestPublishTopic: "VSA/traffic/nearby/reqs",
    trafficRequestSubscribeTopic: "VSA/traffic/nearby/return",
    isBusy: false,
  );

  SettingsState._();

  BrokerDto get broker;

  String get propertiesPublishTopic;
  String get statusPublishTopic;
  String get propertiesRequestPublishTopic;
  String get propertiesRequestSubscribeTopic;
  String get statusRequestPublishTopic;
  String get statusRequestSubscribeTopic;
  String get trafficRequestPublishTopic;
  String get trafficRequestSubscribeTopic;

  bool get isBusy;
  @nullable
  ActionException get exception;
}