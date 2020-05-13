/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:vsa/features/map/middleware.dart' as map;
import 'package:vsa/features/settings/middleware.dart' as settings;
import 'package:vsa/state.dart';
import 'package:vsa/utility/geolocator.dart';
import 'package:vsa/utility/mqtt_api.dart';
import 'package:vsa/utility/text_to_speech.dart';

List<Middleware<AppState>> getMiddleware(
  Geolocator geolocator,
  MqttApi mqttApi,
  TextToSpeech tts,
  GlobalKey<NavigatorState> navigatorKey,
) => [
    map.getMiddleware(geolocator, mqttApi, tts),
    settings.getMiddleware(navigatorKey),
  ].expand((x) => x).toList();