/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:vsa/composition.dart';
import 'package:vsa/features/map/geolocator.dart';
import 'package:vsa/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  final apis = globals.Apis();
  final geolocator = Geolocator();

  final applicationInformation = createApplicationInformation(apis, geolocator);

  globals.applicationInformation = applicationInformation;

  runApp(applicationInformation.applicationWidget);
}