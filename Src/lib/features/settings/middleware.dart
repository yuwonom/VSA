/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vsa/features/settings/actions.dart';
import 'package:vsa/state.dart';

List<Middleware<AppState>> getMiddleware() => [
      LocalSettings().getMiddlewareBindings(),
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
        UpdateBrokerAddress,
        UpdateBrokerPort,
        UpdateBrokerUsername,
        UpdateBrokerPassword,
        UpdateBrokerClientId,
        UpdatePropertiesPublishTopic,
        UpdateStatusPublishTopic,
        UpdatePropertiesRequestPublishTopic,
        UpdatePropertiesRequestSubscribeTopic,
        UpdateStatusRequestPublishTopic,
        UpdateStatusRequestSubscribeTopic,
        UpdateTrafficRequestPublishTopic,
        UpdateTrafficRequestSubscribeTopic,
      ];

      listToLoad.forEach((Type actionType) {
        final key = _getKeyFromActionType(actionType);
        if (!sharedPreferences.getKeys().contains(key)) {
          return;
        }

        final value = sharedPreferences.getString(key);
        final updateAction = _getActionFromActionType(actionType, value);

        store.dispatch(updateAction);
      });
    }
    
    _loadSettings(store, action);
    next(action);
  }

  void _handleUpdateSettings(Store<AppState> store, UpdateSettings action, NextDispatcher next) {
    Future<void> _updateSettings(Store<AppState> store, UpdateSettings action) async {
      final sharedPreferences = await SharedPreferences.getInstance();

      try {
        final key = _getKeyFromActionType(action.actionType);
        await sharedPreferences.setString(key, action.value);

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
      case UpdateBrokerAddress:
        return "brokerAddress";
      case UpdateBrokerPort:
        return "brokerPort";
      case UpdateBrokerUsername:
        return "brokerUsername";
      case UpdateBrokerPassword:
        return "brokerPassword";
      case UpdateBrokerClientId:
        return "brokerClientId";
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
      case UpdateTrafficRequestPublishTopic:
        return "trafficRequestPublishTopic";
      case UpdateTrafficRequestSubscribeTopic:
        return "trafficRequestSubscribeTopic";
    }

    return null;
  }

  dynamic _getActionFromActionType(Type actionType, String value) {
    switch (actionType) {
      case UpdateBrokerAddress:
        return UpdateBrokerAddress(value);
      case UpdateBrokerPort:
        return UpdateBrokerPort(value);
      case UpdateBrokerUsername:
        return UpdateBrokerUsername(value);
      case UpdateBrokerPassword:
        return UpdateBrokerPassword(value);
      case UpdateBrokerClientId:
        return UpdateBrokerClientId(value);
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
      case UpdateTrafficRequestPublishTopic:
        return UpdateTrafficRequestPublishTopic(value);
      case UpdateTrafficRequestSubscribeTopic:
        return UpdateTrafficRequestSubscribeTopic(value);
    }

    assert(false);
  }
}