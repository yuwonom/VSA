/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:redux/redux.dart';
import 'package:vsa/features/settings/actions.dart';
import 'package:vsa/features/settings/state.dart';

final Reducer<SettingsState> settingsStateReducer = combineReducers([
    TypedReducer<SettingsState, UpdateBrokerAddress>(_updateBrokerAddressReducer),
    TypedReducer<SettingsState, UpdateBrokerPort>(_updateBrokerPortReducer),
    TypedReducer<SettingsState, UpdateBrokerUsername>(_updateBrokerUsernameReducer),
    TypedReducer<SettingsState, UpdateBrokerPassword>(_updateBrokerPasswordReducer),
    TypedReducer<SettingsState, SwitchLevelA>(_switchLevelAReducer),
    TypedReducer<SettingsState, SwitchLevelB>(_switchLevelBReducer),
    TypedReducer<SettingsState, SwitchLevelC>(_switchLevelCReducer),
    TypedReducer<SettingsState, SwitchLevelD>(_switchLevelDReducer),
    TypedReducer<SettingsState, SwitchBasicVehicle>(_switchBasicVehicleReducer),
    TypedReducer<SettingsState, SwitchBasicTraffic>(_switchBasicTrafficReducer),
    TypedReducer<SettingsState, UpdateLevelAPropertiesPublishTopic>(_updateLevelAPropertiesPublishTopicReducer),
    TypedReducer<SettingsState, UpdateLevelAStatusPublishTopic>(_updateLevelAStatusPublishTopicReducer),
    TypedReducer<SettingsState, UpdateLevelAIntersectionSubscribeTopic>(_updateLevelAIntersectionSubscribeTopicReducer),
    TypedReducer<SettingsState, UpdatePropertiesPublishTopic>(_updatePropertiesPublishTopicReducer),
    TypedReducer<SettingsState, UpdateStatusPublishTopic>(_updateStatusPublishTopicReducer),
    TypedReducer<SettingsState, UpdatePropertiesRequestPublishTopic>(_updatePropertiesRequestPublishTopicReducer),
    TypedReducer<SettingsState, UpdatePropertiesRequestSubscribeTopic>(_updatePropertiesRequestSubscribeTopicReducer),
    TypedReducer<SettingsState, UpdateStatusRequestPublishTopic>(_updateStatusRequestPublishTopicReducer),
    TypedReducer<SettingsState, UpdateStatusRequestSubscribeTopic>(_updateStatusRequestSubscribeTopicReducer),
    TypedReducer<SettingsState, UpdateTrafficRequestPublishTopic>(_updateTrafficRequestPublishTopicReducer),
    TypedReducer<SettingsState, UpdateTrafficRequestSubscribeTopic>(_updateTrafficRequestSubscribeTopicReducer),
  ]);

SettingsState _updateBrokerAddressReducer(SettingsState state, UpdateBrokerAddress action) => state.rebuild((b) => b
  ..broker.address = action.value);

SettingsState _updateBrokerPortReducer(SettingsState state, UpdateBrokerPort action) => state.rebuild((b) => b
  ..broker.port = action.value);

SettingsState _updateBrokerUsernameReducer(SettingsState state, UpdateBrokerUsername action) => state.rebuild((b) => b
  ..broker.username = action.value);
  
SettingsState _updateBrokerPasswordReducer(SettingsState state, UpdateBrokerPassword action) => state.rebuild((b) => b
  ..broker.password = action.value);

SettingsState _switchLevelAReducer(SettingsState state, SwitchLevelA action) => state.rebuild((b) => b
  ..isActiveLevelA = action.value);

SettingsState _switchLevelBReducer(SettingsState state, SwitchLevelB action) => state.rebuild((b) => b
  ..isActiveLevelB = action.value);

SettingsState _switchLevelCReducer(SettingsState state, SwitchLevelC action) => state.rebuild((b) => b
  ..isActiveLevelC = action.value);

SettingsState _switchLevelDReducer(SettingsState state, SwitchLevelD action) => state.rebuild((b) => b
  ..isActiveLevelD = action.value);

SettingsState _switchBasicVehicleReducer(SettingsState state, SwitchBasicVehicle action) => state.rebuild((b) => b
  ..isActiveBasicVehicle = action.value);

SettingsState _switchBasicTrafficReducer(SettingsState state, SwitchBasicTraffic action) => state.rebuild((b) => b
  ..isActiveBasicTraffic = action.value);

SettingsState _updateLevelAPropertiesPublishTopicReducer(SettingsState state, UpdateLevelAPropertiesPublishTopic action) => state.rebuild((b) => b
  ..levelAPropertiesPublishTopic = action.value);

SettingsState _updateLevelAStatusPublishTopicReducer(SettingsState state, UpdateLevelAStatusPublishTopic action) => state.rebuild((b) => b
  ..levelAStatusPublishTopic = action.value);

SettingsState _updateLevelAIntersectionSubscribeTopicReducer(SettingsState state, UpdateLevelAIntersectionSubscribeTopic action) => state.rebuild((b) => b
  ..levelAIntersectionSubscribeTopic = action.value);

SettingsState _updatePropertiesPublishTopicReducer(SettingsState state, UpdatePropertiesPublishTopic action) => state.rebuild((b) => b
  ..propertiesPublishTopic = action.value);

SettingsState _updateStatusPublishTopicReducer(SettingsState state, UpdateStatusPublishTopic action) => state.rebuild((b) => b
  ..statusPublishTopic = action.value);

SettingsState _updatePropertiesRequestPublishTopicReducer(SettingsState state, UpdatePropertiesRequestPublishTopic action) => state.rebuild((b) => b
  ..propertiesRequestPublishTopic = action.value);

SettingsState _updatePropertiesRequestSubscribeTopicReducer(SettingsState state, UpdatePropertiesRequestSubscribeTopic action) => state.rebuild((b) => b
  ..propertiesRequestSubscribeTopic = action.value);

SettingsState _updateStatusRequestPublishTopicReducer(SettingsState state, UpdateStatusRequestPublishTopic action) => state.rebuild((b) => b
  ..statusRequestPublishTopic = action.value);

SettingsState _updateStatusRequestSubscribeTopicReducer(SettingsState state, UpdateStatusRequestSubscribeTopic action) => state.rebuild((b) => b
  ..statusRequestSubscribeTopic = action.value);

SettingsState _updateTrafficRequestPublishTopicReducer(SettingsState state, UpdateTrafficRequestPublishTopic action) => state.rebuild((b) => b
  ..trafficRequestPublishTopic = action.value);

SettingsState _updateTrafficRequestSubscribeTopicReducer(SettingsState state, UpdateTrafficRequestSubscribeTopic action) => state.rebuild((b) => b
  ..trafficRequestSubscribeTopic = action.value);