// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MapState extends MapState {
  @override
  final VehicleDto userVehicle;
  @override
  final MqttConnectionState connectionState;
  @override
  final SecurityLevelDto securityLevel;
  @override
  final DateTime startTime;
  @override
  final List<GpsPointDto> recordedPoints;
  @override
  final bool isBusy;
  @override
  final ActionException exception;

  factory _$MapState([void updates(MapStateBuilder b)]) =>
      (new MapStateBuilder()..update(updates)).build();

  _$MapState._(
      {this.userVehicle,
      this.connectionState,
      this.securityLevel,
      this.startTime,
      this.recordedPoints,
      this.isBusy,
      this.exception})
      : super._() {
    if (userVehicle == null) {
      throw new BuiltValueNullFieldError('MapState', 'userVehicle');
    }
    if (connectionState == null) {
      throw new BuiltValueNullFieldError('MapState', 'connectionState');
    }
    if (securityLevel == null) {
      throw new BuiltValueNullFieldError('MapState', 'securityLevel');
    }
    if (recordedPoints == null) {
      throw new BuiltValueNullFieldError('MapState', 'recordedPoints');
    }
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
        userVehicle == other.userVehicle &&
        connectionState == other.connectionState &&
        securityLevel == other.securityLevel &&
        startTime == other.startTime &&
        recordedPoints == other.recordedPoints &&
        isBusy == other.isBusy &&
        exception == other.exception;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc(0, userVehicle.hashCode),
                            connectionState.hashCode),
                        securityLevel.hashCode),
                    startTime.hashCode),
                recordedPoints.hashCode),
            isBusy.hashCode),
        exception.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('MapState')
          ..add('userVehicle', userVehicle)
          ..add('connectionState', connectionState)
          ..add('securityLevel', securityLevel)
          ..add('startTime', startTime)
          ..add('recordedPoints', recordedPoints)
          ..add('isBusy', isBusy)
          ..add('exception', exception))
        .toString();
  }
}

class MapStateBuilder implements Builder<MapState, MapStateBuilder> {
  _$MapState _$v;

  VehicleDtoBuilder _userVehicle;
  VehicleDtoBuilder get userVehicle =>
      _$this._userVehicle ??= new VehicleDtoBuilder();
  set userVehicle(VehicleDtoBuilder userVehicle) =>
      _$this._userVehicle = userVehicle;

  MqttConnectionState _connectionState;
  MqttConnectionState get connectionState => _$this._connectionState;
  set connectionState(MqttConnectionState connectionState) =>
      _$this._connectionState = connectionState;

  SecurityLevelDto _securityLevel;
  SecurityLevelDto get securityLevel => _$this._securityLevel;
  set securityLevel(SecurityLevelDto securityLevel) =>
      _$this._securityLevel = securityLevel;

  DateTime _startTime;
  DateTime get startTime => _$this._startTime;
  set startTime(DateTime startTime) => _$this._startTime = startTime;

  List<GpsPointDto> _recordedPoints;
  List<GpsPointDto> get recordedPoints => _$this._recordedPoints;
  set recordedPoints(List<GpsPointDto> recordedPoints) =>
      _$this._recordedPoints = recordedPoints;

  bool _isBusy;
  bool get isBusy => _$this._isBusy;
  set isBusy(bool isBusy) => _$this._isBusy = isBusy;

  ActionException _exception;
  ActionException get exception => _$this._exception;
  set exception(ActionException exception) => _$this._exception = exception;

  MapStateBuilder();

  MapStateBuilder get _$this {
    if (_$v != null) {
      _userVehicle = _$v.userVehicle?.toBuilder();
      _connectionState = _$v.connectionState;
      _securityLevel = _$v.securityLevel;
      _startTime = _$v.startTime;
      _recordedPoints = _$v.recordedPoints;
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
              userVehicle: userVehicle.build(),
              connectionState: connectionState,
              securityLevel: securityLevel,
              startTime: startTime,
              recordedPoints: recordedPoints,
              isBusy: isBusy,
              exception: exception);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'userVehicle';
        userVehicle.build();
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
