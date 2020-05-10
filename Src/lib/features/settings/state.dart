/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:built_value/built_value.dart';
import 'package:vsa/features/settings/dtos.dart';
import 'package:vsa/utility/action_exception.dart';

part 'state.g.dart';

abstract class SettingsState implements Built<SettingsState, SettingsStateBuilder> {
  factory SettingsState([void updates(SettingsStateBuilder bf)]) = _$SettingsState;
  
  factory SettingsState.initial() => _$SettingsState._(
    broker: (BrokerDtoBuilder()
        ..address = "203.101.226.126"
        ..port = "1883"
        ..username = "qut"
        ..password = "qut")
      .build(),
    isActiveLevelA: true,
    isActiveLevelB: false,
    isActiveLevelC: false,
    isActiveLevelD: false,
    isActiveBasicVehicle: false,
    isActiveBasicTraffic: false,
    levelAPropertiesPublishTopic: "VSA/vehProp/cycle",
    levelAStatusPublishTopic: "VSA/basicData/VRU/cycle",
    levelAIntersectionSubscribeTopic: "VSA/requests/all/cycle",
    propertiesPublishTopic: "VSA/vehProp",
    statusPublishTopic: "VSA/vehSim",
    propertiesRequestPublishTopic: "VSA/request/vehProp/reqs",
    propertiesRequestSubscribeTopic: "VSA/request/vehProp/return",
    statusRequestPublishTopic: "VSA/request/vehSim/reqs",
    statusRequestSubscribeTopic: "VSA/request/vehSim/return",
    trafficRequestPublishTopic: "VSA/traffic/nearby/reqs",
    trafficRequestSubscribeTopic: "VSA/traffic/nearby/return",
    intersectionsRequestPublishTopic: "VSA/request/intersections/reqs",
    intersectionsRequestSubscribeTopic: "VSA/request/intersections/return",
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

  String get intersectionsRequestPublishTopic;
  String get intersectionsRequestSubscribeTopic;

  bool get isBusy;
  @nullable
  ActionException get exception;
}