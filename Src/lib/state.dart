import 'package:built_value/built_value.dart';

part 'state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  factory AppState([void updates(AppStateBuilder b)]) = _$AppState;

  factory AppState.initial() => new _$AppState._();

  AppState._();
}