import 'package:vsa/features/settings/dtos.dart';
import 'package:vsa/features/settings/state.dart';

class SettingsViewModel {
  final SettingsState _state;

  const SettingsViewModel(this._state) : assert(_state != null);

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