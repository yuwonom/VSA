import 'package:vsa/globals.dart';
import 'package:vsa/state.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> getMiddleware(
  Apis apis,
  GlobalKey<NavigatorState> navigatorKey,
) => [];