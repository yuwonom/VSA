/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:vsa/composition.dart';
import 'package:vsa/features/map/geolocator.dart';
import 'package:vsa/features/map/mqtt_api.dart';
import 'package:vsa/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  final geolocator = Geolocator.instance;
  final mqttApi = MqttApi.instance;

  final applicationInformation = createApplicationInformation(geolocator, mqttApi);
  globals.applicationInformation = applicationInformation;

  runApp(applicationInformation.applicationWidget);
}