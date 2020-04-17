/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:built_value/built_value.dart';
import 'package:vsa/features/map/state.dart';
import 'package:vsa/features/settings/state.dart';

part 'state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  factory AppState([void updates(AppStateBuilder b)]) = _$AppState;

  factory AppState.initial() => _$AppState._(
    map: MapState.initial(),
    settings: SettingsState.initial(),
  );

  AppState._();

  MapState get map;
  SettingsState get settings;
}