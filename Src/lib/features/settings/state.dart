/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:built_value/built_value.dart';
import 'package:vsa/features/settings/dtos.dart';
import 'package:vsa/utility/action_exception.dart';

part 'state.g.dart';

abstract class SettingsState implements Built<SettingsState, SettingsStateBuilder> {
  factory SettingsState([void updates(SettingsStateBuilder b)]) = _$SettingsState;
  
  factory SettingsState.initial() => _$SettingsState._(
    broker: (BrokerDtoBuilder()
        ..address = "203.101.225.244"
        ..port = "3306"
        ..clientId = "VSA1"
        ..username = "qut"
        ..password = "qut")
      .build(),
    isActiveLevelA: false,
    isActiveLevelB: false,
    isActiveLevelC: false,
    isActiveLevelD: false,
    isActiveBasicVehicle: true,
    isActiveBasicTraffic: true,
    levelAPropertiesPublishTopic: "VSA/basicData/VRU/cycle",
    levelAStatusPublishTopic: "VSA/vehProp/cycle",
    levelAIntersectionSubscribeTopic: "VSA/requests/all/cycle",
    propertiesPublishTopic: "VSA/vehProp",
    statusPublishTopic: "VSA/vehSim",
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

  bool get isActiveLevelA;
  bool get isActiveLevelB;
  bool get isActiveLevelC;
  bool get isActiveLevelD;
  bool get isActiveBasicVehicle;
  bool get isActiveBasicTraffic;

  String get levelAPropertiesPublishTopic;
  String get levelAStatusPublishTopic;
  String get levelAIntersectionSubscribeTopic;

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