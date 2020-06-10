/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vsa/features/map/ui/map_page.dart';
import 'package:vsa/features/settings/actions.dart';
import 'package:vsa/state.dart';

List<Middleware<AppState>> getMiddleware(GlobalKey<NavigatorState> navigatorKey) => [
      LocalSettings().getMiddlewareBindings(),
      Routing(navigatorKey).getMiddlewareBindings(),
    ].expand((x) => x).toList();

@immutable
class LocalSettings {
  List<Middleware<AppState>> getMiddlewareBindings() => [
        TypedMiddleware<AppState, LoadSettings>(_handleLoadSettings),
        TypedMiddleware<AppState, UpdateSettings>(_handleUpdateSettings),
      ];

  void _handleLoadSettings(Store<AppState> store, LoadSettings action, NextDispatcher next) {
    Future<void> _loadSettings(Store<AppState> store, LoadSettings action) async {
      final sharedPreferences = await SharedPreferences.getInstance();

      final listToLoad = [
        UpdateVehicleId,
        UpdateVehicleName,
        UpdateVehicleType,
        UpdateDimension,
        UpdateBrokerAddress,
        UpdateBrokerPort,
        UpdateBrokerUsername,
        UpdateBrokerPassword,
        SwitchLevelA,
        SwitchLevelB,
        SwitchLevelC,
        SwitchLevelD,
        SwitchBasicVehicle,
        SwitchBasicEvents,
        UpdateLevelAPropertiesPublishTopic,
        UpdateLevelAStatusPublishTopic,
        UpdateLevelAIntersectionSubscribeTopic,
        UpdatePropertiesPublishTopic,
        UpdateStatusPublishTopic,
        UpdatePropertiesRequestPublishTopic,
        UpdatePropertiesRequestSubscribeTopic,
        UpdateStatusRequestPublishTopic,
        UpdateStatusRequestSubscribeTopic,
        UpdateEventsRequestPublishTopic,
        UpdateEventsRequestSubscribeTopic,
      ];

      listToLoad.forEach((Type actionType) {
        final key = _getKeyFromActionType(actionType);
        if (!sharedPreferences.getKeys().contains(key)) {
          return;
        }

        final value = sharedPreferences.get(key) as Object;
        final updateAction = _getActionFromActionType(actionType, value);

        store.dispatch(updateAction);
      });

      store.dispatch(LoadSettingsSuccessful());
    }
    
    _loadSettings(store, action);
    next(action);
  }

  void _handleUpdateSettings(Store<AppState> store, UpdateSettings action, NextDispatcher next) {
    Future<void> _updateSettings(Store<AppState> store, UpdateSettings action) async {
      final sharedPreferences = await SharedPreferences.getInstance();

      try {
        final key = _getKeyFromActionType(action.actionType);

        switch (action.value.runtimeType) {
          case bool:
            await sharedPreferences.setBool(key, action.value);
            break;
          case double:
            await sharedPreferences.setDouble(key, action.value);
            break;
          case int:
            await sharedPreferences.setInt(key, action.value);
            break;
          case String:
            await sharedPreferences.setString(key, action.value);
            break;
        }

        final updateAction = _getActionFromActionType(action.actionType, action.value);
        store.dispatch(updateAction);
      } on Exception catch (exception) {
        print(exception);
      }
    }
    
    _updateSettings(store, action);
    next(action);
  }

  String _getKeyFromActionType(Type actionType) {
    switch (actionType) {
      case UpdateVehicleId:
        return "vehicleId";
      case UpdateVehicleName:
        return "vehicleName";
      case UpdateVehicleType:
        return "vehicleType";
      case UpdateDimension:
        return "dimension";
      case UpdateBrokerAddress:
        return "brokerAddress";
      case UpdateBrokerPort:
        return "brokerPort";
      case UpdateBrokerUsername:
        return "brokerUsername";
      case UpdateBrokerPassword:
        return "brokerPassword";
      case SwitchLevelA:
        return "levelA";
      case SwitchLevelB:
        return "levelB";
      case SwitchLevelC:
        return "levelC";
      case SwitchLevelD:
        return "levelD";
      case SwitchBasicVehicle:
        return "switchBasicVehicle";
      case SwitchBasicEvents:
        return "switchBasicEvents";
      case UpdateLevelAPropertiesPublishTopic:
        return "levelAPropertiesPublishTopic";
      case UpdateLevelAStatusPublishTopic:
        return "levelAStatusPublishTopic";
      case UpdateLevelAIntersectionSubscribeTopic:
        return "levelAIntersectionSubscribeTopic";
      case UpdatePropertiesPublishTopic:
        return "propertiesPublishTopic";
      case UpdateStatusPublishTopic:
        return "statusPublishTopic";
      case UpdatePropertiesRequestPublishTopic:
        return "propertiesRequestPublishTopic";
      case UpdatePropertiesRequestSubscribeTopic:
        return "propertiesRequestSubscribeTopic";
      case UpdateStatusRequestPublishTopic:
        return "statusRequestPublishTopic";
      case UpdateStatusRequestSubscribeTopic:
        return "statusRequestSubscribeTopic";
      case UpdateEventsRequestPublishTopic:
        return "eventsRequestPublishTopic";
      case UpdateEventsRequestSubscribeTopic:
        return "eventsRequestSubscribeTopic";
    }

    return null;
  }

  dynamic _getActionFromActionType(Type actionType, Object value) {
    switch (actionType) {
      case UpdateVehicleId:
        return UpdateVehicleId(value);
      case UpdateVehicleName:
        return UpdateVehicleName(value);
      case UpdateVehicleType:
        return UpdateVehicleType(value);
      case UpdateDimension:
        return UpdateDimension(value);
      case UpdateBrokerAddress:
        return UpdateBrokerAddress(value);
      case UpdateBrokerPort:
        return UpdateBrokerPort(value);
      case UpdateBrokerUsername:
        return UpdateBrokerUsername(value);
      case UpdateBrokerPassword:
        return UpdateBrokerPassword(value);
      case SwitchLevelA:
        return SwitchLevelA(value);
      case SwitchLevelB:
        return SwitchLevelB(value);
      case SwitchLevelC:
        return SwitchLevelC(value);
      case SwitchLevelD:
        return SwitchLevelD(value);
      case SwitchBasicVehicle:
        return SwitchBasicVehicle(value);
      case SwitchBasicEvents:
        return SwitchBasicEvents(value);
      case UpdateLevelAPropertiesPublishTopic:
        return UpdateLevelAPropertiesPublishTopic(value);
      case UpdateLevelAStatusPublishTopic:
        return UpdateLevelAStatusPublishTopic(value);
      case UpdateLevelAIntersectionSubscribeTopic:
        return UpdateLevelAIntersectionSubscribeTopic(value);
      case UpdatePropertiesPublishTopic:
        return UpdatePropertiesPublishTopic(value);
      case UpdateStatusPublishTopic:
        return UpdateStatusPublishTopic(value);
      case UpdatePropertiesRequestPublishTopic:
        return UpdatePropertiesRequestPublishTopic(value);
      case UpdatePropertiesRequestSubscribeTopic:
        return UpdatePropertiesRequestSubscribeTopic(value);
      case UpdateStatusRequestPublishTopic:
        return UpdateStatusRequestPublishTopic(value);
      case UpdateStatusRequestSubscribeTopic:
        return UpdateStatusRequestSubscribeTopic(value);
      case UpdateEventsRequestPublishTopic:
        return UpdateEventsRequestPublishTopic(value);
      case UpdateEventsRequestSubscribeTopic:
        return UpdateEventsRequestSubscribeTopic(value);
    }

    assert(false);
  }
}

@immutable
class Routing {
  const Routing(this.navigatorKey);

  final GlobalKey<NavigatorState> navigatorKey;

  List<Middleware<AppState>> getMiddlewareBindings() => [
        TypedMiddleware<AppState, LoadSettingsSuccessful>(_handleLoadSettingsSucessful),
      ];

  NavigatorState get _navigatorState => navigatorKey.currentState;

  void _handleLoadSettingsSucessful(Store<AppState> store, LoadSettingsSuccessful action, NextDispatcher next) {
    final route = MaterialPageRoute(builder: (_) => MapPage());
    _navigatorState.pushReplacement(route);
  }
}