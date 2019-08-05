/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:mqtt_client/mqtt_client.dart';
import 'package:redux/redux.dart';
import 'package:vsa/features/map/actions.dart';
import 'package:vsa/features/map/dtos.dart';
import 'package:vsa/features/map/state.dart';
import 'package:vsa/features/settings/actions.dart';

final Reducer<MapState> mapStateReducer = combineReducers([
    TypedReducer<MapState, UpdateUserGpsPoint>(_updateUserGpsPointReducer),
    TypedReducer<MapState, RecordUserGpsPoint>(_recordUserGpsPointReducer),
    TypedReducer<MapState, UpdateBrokerClientId>(_updateBrokerClientIdReducer),
    TypedReducer<MapState, ConnectToMqttBroker>(_connectToMqttBrokerReducer),
    TypedReducer<MapState, ConnectToMqttBrokerSuccessful>(_connectToMqttBrokerSuccessfulReducer),
    TypedReducer<MapState, ConnectToMqttBrokerFailed>(_connectToMqttBrokerFailedReducer),
    TypedReducer<MapState, DisconnectFromMqttBroker>(_disconnectFromMqttBrokerReducer),
    TypedReducer<MapState, UpdateSecurityLevel>(_updateSecurityLevelReducer),
    TypedReducer<MapState, UpdateOtherVehiclesStatus>(_updateOtherVehiclesStatusReducer),
    TypedReducer<MapState, UpdateOtherVehiclesProperties>(_updateOtherVehiclesPropertiesReducer),
    TypedReducer<MapState, UpdateVehicleType>(_updateVehicleTypeReducer),
    TypedReducer<MapState, UpdateDimension>(_updateDimensionReducer),
  ]);

MapState _updateUserGpsPointReducer(MapState state, UpdateUserGpsPoint action) => state.rebuild((b) => b
  ..userVehicle.point.replace(action.point));

MapState _recordUserGpsPointReducer(MapState state, RecordUserGpsPoint action) => state.rebuild((b) => b
  ..recordedPoints.add(action.point));

MapState _updateBrokerClientIdReducer(MapState state, UpdateBrokerClientId action) => state.rebuild((b) => b
  ..userVehicle.id = action.value);

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
  ..startTime = null
  ..recordedPoints.clear()
  ..otherVehicles.clear());

MapState _updateSecurityLevelReducer(MapState state, UpdateSecurityLevel action) => state.rebuild((b) => b
  ..securityLevel = action.level);

MapState _updateOtherVehiclesStatusReducer(MapState state, UpdateOtherVehiclesStatus action) {
  final newOtherVehicles = action.map
    ..toMap()
    .forEach((String key, VehicleDto value) {
      if (!state.otherVehicles.toMap().containsKey(key)) {
        return;
      }

      value.rebuild((b) => b
        ..name = state.otherVehicles[key].name
        ..dimension.replace(state.otherVehicles[key].dimension));
    });
  
  return state.rebuild((b) => b..otherVehicles.replace(newOtherVehicles));
}

MapState _updateOtherVehiclesPropertiesReducer(MapState state, UpdateOtherVehiclesProperties action) {
  final newOtherVehicles = state.otherVehicles
    ..toMap()
    .forEach((String key, VehicleDto value) {
      if (!action.map.toMap().containsKey(key)) {
        return;
      }

      value.rebuild((b) => b
        ..name = action.map[key].name
        ..dimension.replace(action.map[key].dimension));
    });
  
  return state.rebuild((b) => b..otherVehicles.replace(newOtherVehicles));
}

MapState _updateVehicleTypeReducer(MapState state, UpdateVehicleType action) => state.rebuild((b) => b
  ..userVehicle.type = VehicleTypeDto.valueOf(action.value));

MapState _updateDimensionReducer(MapState state, UpdateDimension action) => state.rebuild((b) => b
  ..userVehicle.dimension.replace(VehicleDimensionDto.fromString(action.value)));