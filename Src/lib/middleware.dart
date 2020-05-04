/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:vsa/features/map/geolocator.dart';
import 'package:vsa/features/map/middleware.dart' as map;
import 'package:vsa/features/map/mqtt_api.dart';
import 'package:vsa/features/settings/middleware.dart' as settings;
import 'package:vsa/state.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> getMiddleware(
  Geolocator geolocator,
  MqttApi mqttApi,
  GlobalKey<NavigatorState> navigatorKey,
) => [
    map.getMiddleware(geolocator, mqttApi),
    settings.getMiddleware(navigatorKey),
  ].expand((x) => x).toList();