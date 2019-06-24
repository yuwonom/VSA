/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:mqtt_client/mqtt_client.dart';
import 'package:redux/redux.dart';
import 'package:vsa/features/map/actions.dart';
import 'package:vsa/features/map/state.dart';

final Reducer<MapState> mapStateReducer = combineReducers([
    TypedReducer<MapState, UpdateUserGpsPoint>(_updateUserGpsPointReducer),
    TypedReducer<MapState, ConnectToMqttBroker>(_connectToMqttBrokerReducer),
    TypedReducer<MapState, ConnectToMqttBrokerSuccessful>(_connectToMqttBrokerSuccessfulReducer),
    TypedReducer<MapState, ConnectToMqttBrokerFailed>(_connectToMqttBrokerFailedReducer),
    TypedReducer<MapState, DisconnectFromMqttBroker>(_disconnectFromMqttBrokerReducer),
  ]);

MapState _updateUserGpsPointReducer(MapState state, UpdateUserGpsPoint action) => state.rebuild((b) => b
  ..userVehicle.point.replace(action.point));

MapState _connectToMqttBrokerReducer(MapState state, ConnectToMqttBroker action) => state.rebuild((b) => b
  ..isBusy = true
  ..exception = null
  ..connectionState = MqttConnectionState.connecting);

MapState _connectToMqttBrokerSuccessfulReducer(MapState state, ConnectToMqttBrokerSuccessful action) => state.rebuild((b) => b
  ..isBusy = false
  ..connectionState = MqttConnectionState.connected
  ..startTime = DateTime.now());

MapState _connectToMqttBrokerFailedReducer(MapState state, ConnectToMqttBrokerFailed action) => state.rebuild((b) => b
  ..isBusy = false
  ..exception = action.exception
  ..connectionState = MqttConnectionState.faulted);

MapState _disconnectFromMqttBrokerReducer(MapState state, DisconnectFromMqttBroker action) => state.rebuild((b) => b
  ..connectionState = MqttConnectionState.disconnected
  ..startTime = null);