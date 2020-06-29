/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:redux/redux.dart';
import 'package:vsa/features/settings/actions.dart';
import 'package:vsa/features/settings/state.dart';

final Reducer<SettingsState> settingsStateReducer = combineReducers([
    TypedReducer<SettingsState, UpdateBrokerAddress>(_updateBrokerAddressReducer),
    TypedReducer<SettingsState, UpdateBrokerPort>(_updateBrokerPortReducer),
    TypedReducer<SettingsState, UpdateBrokerUsername>(_updateBrokerUsernameReducer),
    TypedReducer<SettingsState, UpdateBrokerPassword>(_updateBrokerPasswordReducer),
    TypedReducer<SettingsState, UpdateTopicLevel>(_setTopicLevelReducer),
    TypedReducer<SettingsState, SwitchBasicVehicle>(_switchBasicVehicleReducer),
    TypedReducer<SettingsState, SwitchBasicEvents>(_switchBasicEventsReducer),
    TypedReducer<SettingsState, UpdateLevelAPropertiesPublishTopic>(_updateLevelAPropertiesPublishTopicReducer),
    TypedReducer<SettingsState, UpdateLevelAStatusPublishTopic>(_updateLevelAStatusPublishTopicReducer),
    TypedReducer<SettingsState, UpdateLevelAIntersectionSubscribeTopic>(_updateLevelAIntersectionSubscribeTopicReducer),
    TypedReducer<SettingsState, UpdateLevelBPropertiesPublishTopic>(_updateLevelBPropertiesPublishTopicReducer),
    TypedReducer<SettingsState, UpdateLevelBStatusPublishTopic>(_updateLevelBStatusPublishTopicReducer),
    TypedReducer<SettingsState, UpdateLevelBIntersectionSubscribeTopic>(_updateLevelBIntersectionSubscribeTopicReducer),
    TypedReducer<SettingsState, UpdateLevelBEventsSubscribeTopic>(_updateLevelBEventsSubscribeTopicReducer),
    TypedReducer<SettingsState, UpdatePropertiesPublishTopic>(_updatePropertiesPublishTopicReducer),
    TypedReducer<SettingsState, UpdateStatusPublishTopic>(_updateStatusPublishTopicReducer),
    TypedReducer<SettingsState, UpdatePropertiesRequestPublishTopic>(_updatePropertiesRequestPublishTopicReducer),
    TypedReducer<SettingsState, UpdatePropertiesRequestSubscribeTopic>(_updatePropertiesRequestSubscribeTopicReducer),
    TypedReducer<SettingsState, UpdateStatusRequestPublishTopic>(_updateStatusRequestPublishTopicReducer),
    TypedReducer<SettingsState, UpdateStatusRequestSubscribeTopic>(_updateStatusRequestSubscribeTopicReducer),
    TypedReducer<SettingsState, UpdateEventsRequestPublishTopic>(_updateEventsRequestPublishTopicReducer),
    TypedReducer<SettingsState, UpdateEventsRequestSubscribeTopic>(_updateEventsRequestSubscribeTopicReducer),
  ]);

SettingsState _updateBrokerAddressReducer(SettingsState state, UpdateBrokerAddress action) => state.rebuild((b) => b
  ..broker.address = action.value);

SettingsState _updateBrokerPortReducer(SettingsState state, UpdateBrokerPort action) => state.rebuild((b) => b
  ..broker.port = action.value);

SettingsState _updateBrokerUsernameReducer(SettingsState state, UpdateBrokerUsername action) => state.rebuild((b) => b
  ..broker.username = action.value);
  
SettingsState _updateBrokerPasswordReducer(SettingsState state, UpdateBrokerPassword action) => state.rebuild((b) => b
  ..broker.password = action.value);

SettingsState _setTopicLevelReducer(SettingsState state, UpdateTopicLevel action) => state.rebuild((b) => b
  ..topicLevel = action.dto);

SettingsState _switchBasicVehicleReducer(SettingsState state, SwitchBasicVehicle action) => state.rebuild((b) => b
  ..isActiveBasicVehicle = action.value);

SettingsState _switchBasicEventsReducer(SettingsState state, SwitchBasicEvents action) => state.rebuild((b) => b
  ..isActiveBasicEvents = action.value);

SettingsState _updateLevelAPropertiesPublishTopicReducer(SettingsState state, UpdateLevelAPropertiesPublishTopic action) => state.rebuild((b) => b
  ..levelAPropertiesPublishTopic = action.value);

SettingsState _updateLevelAStatusPublishTopicReducer(SettingsState state, UpdateLevelAStatusPublishTopic action) => state.rebuild((b) => b
  ..levelAStatusPublishTopic = action.value);

SettingsState _updateLevelAIntersectionSubscribeTopicReducer(SettingsState state, UpdateLevelAIntersectionSubscribeTopic action) => state.rebuild((b) => b
  ..levelAIntersectionSubscribeTopic = action.value);

SettingsState _updateLevelBPropertiesPublishTopicReducer(SettingsState state, UpdateLevelBPropertiesPublishTopic action) => state.rebuild((b) => b
  ..levelBPropertiesPublishTopic = action.value);

SettingsState _updateLevelBStatusPublishTopicReducer(SettingsState state, UpdateLevelBStatusPublishTopic action) => state.rebuild((b) => b
  ..levelBStatusPublishTopic = action.value);

SettingsState _updateLevelBIntersectionSubscribeTopicReducer(SettingsState state, UpdateLevelBIntersectionSubscribeTopic action) => state.rebuild((b) => b
  ..levelBIntersectionSubscribeTopic = action.value);

SettingsState _updateLevelBEventsSubscribeTopicReducer(SettingsState state, UpdateLevelBEventsSubscribeTopic action) => state.rebuild((b) => b
  ..levelBEventsSubscribeTopic = action.value);

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

SettingsState _updateEventsRequestPublishTopicReducer(SettingsState state, UpdateEventsRequestPublishTopic action) => state.rebuild((b) => b
  ..eventsRequestPublishTopic = action.value);

SettingsState _updateEventsRequestSubscribeTopicReducer(SettingsState state, UpdateEventsRequestSubscribeTopic action) => state.rebuild((b) => b
  ..eventsRequestSubscribeTopic = action.value);