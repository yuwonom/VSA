/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:vsa/features/map/dtos.dart';
import 'package:vsa/features/settings/dtos.dart';
import 'package:vsa/features/settings/state.dart';

class SettingsViewModel {
  final SettingsState _state;
  final VehicleDto _userVehicle;

  const SettingsViewModel(this._state, this._userVehicle)
    : assert(_state != null && _userVehicle != null);

  VehicleTypeDto get vehicleType => _userVehicle.type;
  String get dimensionString => _userVehicle.dimension.toString();

  BrokerDto get broker => _state.broker;

  String get address => broker.address;
  String get port => broker.port;
  String get username => broker.username;
  String get password => broker.password;
  String get clientId => broker.clientId;

  String get propertiesPublishTopic => _state.propertiesPublishTopic;
  String get statusPublishTopic => _state.statusPublishTopic;
  String get propertiesRequestPublishTopic => _state.propertiesRequestPublishTopic;
  String get propertiesRequestSubscribeTopic => _state.propertiesRequestSubscribeTopic;
  String get statusRequestPublishTopic => _state.statusRequestPublishTopic;
  String get statusRequestSubscribeTopic => _state.statusRequestSubscribeTopic;
  String get trafficRequestPublishTopic => _state.trafficRequestPublishTopic;
  String get trafficRequestSubscribeTopic => _state.trafficRequestSubscribeTopic;
}