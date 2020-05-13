/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vsa/composition.dart';
import 'package:vsa/globals.dart' as globals;
import 'package:vsa/utility/geolocator.dart';
import 'package:vsa/utility/mqtt_api.dart';
import 'package:vsa/utility/text_to_speech.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  final geolocator = Geolocator.instance;
  final mqttApi = MqttApi.instance;
  final tts = TextToSpeech.instance;

  final applicationInformation = createApplicationInformation(geolocator, mqttApi, tts);
  globals.applicationInformation = applicationInformation;

  runApp(applicationInformation.applicationWidget);
}