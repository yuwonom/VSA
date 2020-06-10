/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:vsa/features/map/dtos.dart';
import 'package:vsa/features/settings/dtos.dart';
import 'package:vsa/features/settings/state.dart';

class SettingsViewModel {
  final SettingsState _state;
  final VehicleDto _userVehicle;

  const SettingsViewModel(this._state, this._userVehicle)
    : assert(_state != null && _userVehicle != null);

  String get vehicleId => _userVehicle.id;
  String get vehicleName => _userVehicle.name;
  VehicleTypeDto get vehicleType => _userVehicle.type;
  String get dimensionString => _userVehicle.dimension.toString();

  BrokerDto get broker => _state.broker;

  String get address => broker.address;
  String get port => broker.port;
  String get username => broker.username;
  String get password => broker.password;

  TopicLevelDto get topicLevel => _state.topicLevel;
  bool get isActiveLevelA => topicLevel == TopicLevelDto.levelA;
  bool get isActiveLevelB => topicLevel == TopicLevelDto.levelB;
  bool get isActiveLevelC => topicLevel == TopicLevelDto.levelC;

  bool get isActiveBasicVehicle => _state.isActiveBasicVehicle;
  bool get isActiveBasicEvents => _state.isActiveBasicEvents;

  String get levelAPropertiesPublishTopic => _state.levelAPropertiesPublishTopic;
  String get levelAStatusPublishTopic => _state.levelAStatusPublishTopic;
  String get levelAIntersectionSubscribeTopic => _state.levelAIntersectionSubscribeTopic;

  String get propertiesPublishTopic => _state.propertiesPublishTopic;
  String get statusPublishTopic => _state.statusPublishTopic;
  String get propertiesRequestPublishTopic => _state.propertiesRequestPublishTopic;
  String get propertiesRequestSubscribeTopic => _state.propertiesRequestSubscribeTopic;
  String get statusRequestPublishTopic => _state.statusRequestPublishTopic;
  String get statusRequestSubscribeTopic => _state.statusRequestSubscribeTopic;

  String get eventsRequestPublishTopic => _state.eventsRequestPublishTopic;
  String get eventsRequestSubscribeTopic => _state.eventsRequestSubscribeTopic;
}