/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:redux/redux.dart';
import 'package:vsa/features/settings/actions.dart';
import 'package:vsa/features/settings/state.dart';

final Reducer<SettingsState> settingsStateReducer = combineReducers([
    TypedReducer<SettingsState, UpdateBrokerAddress>(_updateBrokerAddressReducer),
    TypedReducer<SettingsState, UpdateBrokerPort>(_updateBrokerPortReducer),
    TypedReducer<SettingsState, UpdateBrokerUsername>(_updateBrokerUsernameReducer),
    TypedReducer<SettingsState, UpdateBrokerPassword>(_updateBrokerPasswordReducer),
    TypedReducer<SettingsState, UpdateBrokerClientId>(_updateBrokerClientIdReducer),
  ]);

SettingsState _updateBrokerAddressReducer(SettingsState state, UpdateBrokerAddress action) => state.rebuild((b) => b
  ..broker.address = action.value);

SettingsState _updateBrokerPortReducer(SettingsState state, UpdateBrokerPort action) => state.rebuild((b) => b
  ..broker.port = action.value);

SettingsState _updateBrokerUsernameReducer(SettingsState state, UpdateBrokerUsername action) => state.rebuild((b) => b
  ..broker.username = action.value);
  
SettingsState _updateBrokerPasswordReducer(SettingsState state, UpdateBrokerPassword action) => state.rebuild((b) => b
  ..broker.password = action.value);
  
SettingsState _updateBrokerClientIdReducer(SettingsState state, UpdateBrokerClientId action) => state.rebuild((b) => b
  ..broker.clientId = action.value);