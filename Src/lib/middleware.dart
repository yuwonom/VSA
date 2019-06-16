/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:vsa/features/map/geolocator.dart';
import 'package:vsa/features/map/middleware.dart' as map;
import 'package:vsa/globals.dart';
import 'package:vsa/state.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> getMiddleware(
  Apis apis,
  Geolocator geolocator,
  GlobalKey<NavigatorState> navigatorKey,
) => [
    map.getMiddleware(geolocator),
  ].expand((x) => x).toList();