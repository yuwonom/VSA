/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:vsa/features/map/dtos.dart';
import 'package:vsa/features/settings/dtos.dart';
import 'package:vsa/features/settings/state.dart';

class SettingsViewModel {
  final SettingsState _state;
  final VehicleTypeDto _vehicleType;
  final VehicleDimensionDto _vehicleDimension;

  const SettingsViewModel(this._state, this._vehicleType, this._vehicleDimension)
    : assert(_state != null && _vehicleType != null && _vehicleDimension != null);

  VehicleTypeDto get vehicleType => _vehicleType;
  String get dimensionString => _vehicleDimension.toString();

  BrokerDto get broker => _state.broker;

  String get address => broker.address;
  String get port => broker.port;
  String get username => broker.username;
  String get password => broker.password;
  String get clientId => broker.clientId;

  bool get isActiveLevelA => _state.isActiveLevelA;
  bool get isActiveLevelB => _state.isActiveLevelB;
  bool get isActiveLevelC => _state.isActiveLevelC;
  bool get isActiveLevelD => _state.isActiveLevelD;
  bool get isActiveBasicVehicle => _state.isActiveBasicVehicle;
  bool get isActiveBasicTraffic => _state.isActiveBasicTraffic;

  String get levelAPropertiesPublishTopic => _state.levelAPropertiesPublishTopic;
  String get levelAStatusPublishTopic => _state.levelAStatusPublishTopic;
  String get levelAIntersectionSubscribeTopic => _state.levelAIntersectionSubscribeTopic;

  String get propertiesPublishTopic => _state.propertiesPublishTopic;
  String get statusPublishTopic => _state.statusPublishTopic;
  String get propertiesRequestPublishTopic => _state.propertiesRequestPublishTopic;
  String get propertiesRequestSubscribeTopic => _state.propertiesRequestSubscribeTopic;
  String get statusRequestPublishTopic => _state.statusRequestPublishTopic;
  String get statusRequestSubscribeTopic => _state.statusRequestSubscribeTopic;

  String get trafficRequestPublishTopic => _state.trafficRequestPublishTopic;
  String get trafficRequestSubscribeTopic => _state.trafficRequestSubscribeTopic;
}