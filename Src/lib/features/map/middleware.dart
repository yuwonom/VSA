/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:flutter/widgets.dart';
import 'package:redux/redux.dart';
import 'package:vsa/features/map/actions.dart';
import 'package:vsa/features/map/geolocator.dart';
import 'package:vsa/state.dart';

List<Middleware<AppState>> getMiddleware(Geolocator geolocator) => [
      LocalGpsIntegration(geolocator).getMiddlewareBindings(),
    ].expand((x) => x).toList();

@immutable
class LocalGpsIntegration {
  LocalGpsIntegration(this.geolocator) : assert(geolocator != null);
  
  final Geolocator geolocator;
  
  List<Middleware<AppState>> getMiddlewareBindings() => [
        TypedMiddleware<AppState, ListenToGeolocator>(_listenToGeolocator),
      ];

  void _listenToGeolocator(Store<AppState> store, ListenToGeolocator action, NextDispatcher next) {
    geolocator.getPositionStream().listen((point) => store.dispatch(UpdateUserGpsPoint(point)));
    next(action);
  }
}