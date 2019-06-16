// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MapState extends MapState {
  @override
  final GpsPointDto userGpsPoint;
  @override
  final bool isBusy;
  @override
  final ActionException exception;

  factory _$MapState([void updates(MapStateBuilder b)]) =>
      (new MapStateBuilder()..update(updates)).build();

  _$MapState._({this.userGpsPoint, this.isBusy, this.exception}) : super._() {
    if (isBusy == null) {
      throw new BuiltValueNullFieldError('MapState', 'isBusy');
    }
  }

  @override
  MapState rebuild(void updates(MapStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  MapStateBuilder toBuilder() => new MapStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MapState &&
        userGpsPoint == other.userGpsPoint &&
        isBusy == other.isBusy &&
        exception == other.exception;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, userGpsPoint.hashCode), isBusy.hashCode),
        exception.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('MapState')
          ..add('userGpsPoint', userGpsPoint)
          ..add('isBusy', isBusy)
          ..add('exception', exception))
        .toString();
  }
}

class MapStateBuilder implements Builder<MapState, MapStateBuilder> {
  _$MapState _$v;

  GpsPointDtoBuilder _userGpsPoint;
  GpsPointDtoBuilder get userGpsPoint =>
      _$this._userGpsPoint ??= new GpsPointDtoBuilder();
  set userGpsPoint(GpsPointDtoBuilder userGpsPoint) =>
      _$this._userGpsPoint = userGpsPoint;

  bool _isBusy;
  bool get isBusy => _$this._isBusy;
  set isBusy(bool isBusy) => _$this._isBusy = isBusy;

  ActionException _exception;
  ActionException get exception => _$this._exception;
  set exception(ActionException exception) => _$this._exception = exception;

  MapStateBuilder();

  MapStateBuilder get _$this {
    if (_$v != null) {
      _userGpsPoint = _$v.userGpsPoint?.toBuilder();
      _isBusy = _$v.isBusy;
      _exception = _$v.exception;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MapState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$MapState;
  }

  @override
  void update(void updates(MapStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$MapState build() {
    _$MapState _$result;
    try {
      _$result = _$v ??
          new _$MapState._(
              userGpsPoint: _userGpsPoint?.build(),
              isBusy: isBusy,
              exception: exception);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'userGpsPoint';
        _userGpsPoint?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'MapState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
