/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:built_collection/built_collection.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:redux/redux.dart';
import 'package:vsa/features/map/actions.dart';
import 'package:vsa/features/map/dtos.dart';
import 'package:vsa/features/map/state.dart';
import 'package:vsa/features/settings/actions.dart';

final Reducer<MapState> mapStateReducer = combineReducers([
    TypedReducer<MapState, UpdateUserGpsPoint>(_updateUserGpsPointReducer),
    TypedReducer<MapState, RecordUserGpsPoint>(_recordUserGpsPointReducer),
    TypedReducer<MapState, ConnectToMqttBroker>(_connectToMqttBrokerReducer),
    TypedReducer<MapState, ConnectToMqttBrokerSuccessful>(_connectToMqttBrokerSuccessfulReducer),
    TypedReducer<MapState, ConnectToMqttBrokerFailed>(_connectToMqttBrokerFailedReducer),
    TypedReducer<MapState, DisconnectFromMqttBroker>(_disconnectFromMqttBrokerReducer),
    TypedReducer<MapState, UpdateSecurityLevel>(_updateSecurityLevelReducer),
    TypedReducer<MapState, UpdateOtherVehiclesStatus>(_updateOtherVehiclesStatusReducer),
    TypedReducer<MapState, UpdateOtherVehiclesProperties>(_updateOtherVehiclesPropertiesReducer),
    TypedReducer<MapState, LoadIntersections>(_loadIntersectionsReducer),
    TypedReducer<MapState, UpdateClosestOtherVehicleId>(_updateClosestOtherVehicleIdReducer),
    TypedReducer<MapState, UpdateCurrentIntersectionId>(_updateCurrentIntersectionIdReducer),
    TypedReducer<MapState, UpdateVehicleId>(_updateVehicleIdReducer),
    TypedReducer<MapState, UpdateVehicleName>(_updateVehicleNameReducer),
    TypedReducer<MapState, UpdateVehicleType>(_updateVehicleTypeReducer),
    TypedReducer<MapState, UpdateDimension>(_updateDimensionReducer),
  ]);

MapState _updateUserGpsPointReducer(MapState state, UpdateUserGpsPoint action) => state.rebuild((b) => b
  ..userVehicle.point.replace(action.point));

MapState _recordUserGpsPointReducer(MapState state, RecordUserGpsPoint action) => state.rebuild((b) => b
  ..recordedPoints.add(action.point));

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
  ..otherVehicles.clear()
  ..intersections.clear());

MapState _updateSecurityLevelReducer(MapState state, UpdateSecurityLevel action) => state.rebuild((b) => b
  ..securityLevel = action.level);

MapState _updateOtherVehiclesStatusReducer(MapState state, UpdateOtherVehiclesStatus action) {
  final newOtherVehiclesEntries = action.map.entries
    .map((MapEntry<String, VehicleDto> entry) {
      if (!state.otherVehicles.containsKey(entry.key)) {
        return entry;
      }

      final newValue = entry.value.rebuild((b) => b
        ..name = state.otherVehicles[entry.key].name
        ..type = state.otherVehicles[entry.key].type
        ..dimension.replace(state.otherVehicles[entry.key].dimension));
        
      return MapEntry<String, VehicleDto>(entry.key, newValue);
    });

  final newOtherVehiclesBuiltMap = BuiltMap<String, VehicleDto>(Map<String, VehicleDto>.fromEntries(newOtherVehiclesEntries));
  
  return state.rebuild((b) => b..otherVehicles.replace(newOtherVehiclesBuiltMap));
}

MapState _updateOtherVehiclesPropertiesReducer(MapState state, UpdateOtherVehiclesProperties action) {
  final newOtherVehiclesEntries = state.otherVehicles.entries
    .map((MapEntry<String, VehicleDto> entry) {
      if (!action.map.containsKey(entry.key)) {
        return null;
      }

      final newValue = entry.value.rebuild((b) => b
        ..name = action.map[entry.key].name
        ..type = action.map[entry.key].type
        ..dimension.replace(action.map[entry.key].dimension));

      return MapEntry<String, VehicleDto>(entry.key, newValue);
    })
    .where((MapEntry<String, VehicleDto> entry) => entry != null);

  final newOtherVehiclesBuiltMap = BuiltMap<String, VehicleDto>(Map<String, VehicleDto>.fromEntries(newOtherVehiclesEntries));
  
  return state.rebuild((b) => b..otherVehicles.replace(newOtherVehiclesBuiltMap));
}

MapState _loadIntersectionsReducer(MapState state, LoadIntersections action) => state.rebuild((b) => b
  ..intersections.replace(action.intersections));

MapState _updateClosestOtherVehicleIdReducer(MapState state, UpdateClosestOtherVehicleId action) => state.rebuild((b) => b
  ..closestOtherVehicleId = action.id);

MapState _updateCurrentIntersectionIdReducer(MapState state, UpdateCurrentIntersectionId action) => state.rebuild((b) => b
  ..currentIntersectionId = action.id);

MapState _updateVehicleIdReducer(MapState state, UpdateVehicleId action) => state.rebuild((b) => b
  ..userVehicle.id = action.value);

MapState _updateVehicleNameReducer(MapState state, UpdateVehicleName action) => state.rebuild((b) => b
  ..userVehicle.name = action.value);

MapState _updateVehicleTypeReducer(MapState state, UpdateVehicleType action) => state.rebuild((b) => b
  ..userVehicle.type = VehicleTypeDto.valueOf(action.value));

MapState _updateDimensionReducer(MapState state, UpdateDimension action) => state.rebuild((b) => b
  ..userVehicle.dimension.replace(VehicleDimensionDto.fromString(action.value)));