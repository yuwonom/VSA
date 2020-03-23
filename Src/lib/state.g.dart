// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AppState extends AppState {
  @override
  final MapState map;
  @override
  final SettingsState settings;

  factory _$AppState([void Function(AppStateBuilder) updates]) =>
      (new AppStateBuilder()..update(updates)).build();

  _$AppState._({this.map, this.settings}) : super._() {
    if (map == null) {
      throw new BuiltValueNullFieldError('AppState', 'map');
    }
    if (settings == null) {
      throw new BuiltValueNullFieldError('AppState', 'settings');
    }
  }

  @override
  AppState rebuild(void Function(AppStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AppStateBuilder toBuilder() => new AppStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppState && map == other.map && settings == other.settings;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, map.hashCode), settings.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppState')
          ..add('map', map)
          ..add('settings', settings))
        .toString();
  }
}

class AppStateBuilder implements Builder<AppState, AppStateBuilder> {
  _$AppState _$v;

  MapStateBuilder _map;
  MapStateBuilder get map => _$this._map ??= new MapStateBuilder();
  set map(MapStateBuilder map) => _$this._map = map;

  SettingsStateBuilder _settings;
  SettingsStateBuilder get settings =>
      _$this._settings ??= new SettingsStateBuilder();
  set settings(SettingsStateBuilder settings) => _$this._settings = settings;

  AppStateBuilder();

  AppStateBuilder get _$this {
    if (_$v != null) {
      _map = _$v.map?.toBuilder();
      _settings = _$v.settings?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$AppState;
  }

  @override
  void update(void Function(AppStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AppState build() {
    _$AppState _$result;
    try {
      _$result =
          _$v ?? new _$AppState._(map: map.build(), settings: settings.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'map';
        map.build();
        _$failedField = 'settings';
        settings.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'AppState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
