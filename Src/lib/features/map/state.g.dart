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
  final BuiltList<GpsPointDto> recordedPoints;
  @override
  final BuiltMap<String, VehicleDto> otherVehicles;
  @override
  final BuiltList<IntersectionDto> intersections;
  @override
  final int currentIntersectionId;
  @override
  final bool isBusy;
  @override
  final ActionException exception;

  factory _$MapState([void Function(MapStateBuilder) updates]) =>
      (new MapStateBuilder()..update(updates)).build();

  _$MapState._(
      {this.userVehicle,
      this.connectionState,
      this.securityLevel,
      this.startTime,
      this.recordedPoints,
      this.otherVehicles,
      this.intersections,
      this.currentIntersectionId,
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
    if (otherVehicles == null) {
      throw new BuiltValueNullFieldError('MapState', 'otherVehicles');
    }
    if (intersections == null) {
      throw new BuiltValueNullFieldError('MapState', 'intersections');
    }
    if (isBusy == null) {
      throw new BuiltValueNullFieldError('MapState', 'isBusy');
    }
  }

  @override
  MapState rebuild(void Function(MapStateBuilder) updates) =>
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
        otherVehicles == other.otherVehicles &&
        intersections == other.intersections &&
        currentIntersectionId == other.currentIntersectionId &&
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
                        $jc(
                            $jc(
                                $jc(
                                    $jc($jc(0, userVehicle.hashCode),
                                        connectionState.hashCode),
                                    securityLevel.hashCode),
                                startTime.hashCode),
                            recordedPoints.hashCode),
                        otherVehicles.hashCode),
                    intersections.hashCode),
                currentIntersectionId.hashCode),
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
          ..add('otherVehicles', otherVehicles)
          ..add('intersections', intersections)
          ..add('currentIntersectionId', currentIntersectionId)
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

  ListBuilder<GpsPointDto> _recordedPoints;
  ListBuilder<GpsPointDto> get recordedPoints =>
      _$this._recordedPoints ??= new ListBuilder<GpsPointDto>();
  set recordedPoints(ListBuilder<GpsPointDto> recordedPoints) =>
      _$this._recordedPoints = recordedPoints;

  MapBuilder<String, VehicleDto> _otherVehicles;
  MapBuilder<String, VehicleDto> get otherVehicles =>
      _$this._otherVehicles ??= new MapBuilder<String, VehicleDto>();
  set otherVehicles(MapBuilder<String, VehicleDto> otherVehicles) =>
      _$this._otherVehicles = otherVehicles;

  ListBuilder<IntersectionDto> _intersections;
  ListBuilder<IntersectionDto> get intersections =>
      _$this._intersections ??= new ListBuilder<IntersectionDto>();
  set intersections(ListBuilder<IntersectionDto> intersections) =>
      _$this._intersections = intersections;

  int _currentIntersectionId;
  int get currentIntersectionId => _$this._currentIntersectionId;
  set currentIntersectionId(int currentIntersectionId) =>
      _$this._currentIntersectionId = currentIntersectionId;

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
      _recordedPoints = _$v.recordedPoints?.toBuilder();
      _otherVehicles = _$v.otherVehicles?.toBuilder();
      _intersections = _$v.intersections?.toBuilder();
      _currentIntersectionId = _$v.currentIntersectionId;
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
  void update(void Function(MapStateBuilder) updates) {
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
              recordedPoints: recordedPoints.build(),
              otherVehicles: otherVehicles.build(),
              intersections: intersections.build(),
              currentIntersectionId: currentIntersectionId,
              isBusy: isBusy,
              exception: exception);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'userVehicle';
        userVehicle.build();

        _$failedField = 'recordedPoints';
        recordedPoints.build();
        _$failedField = 'otherVehicles';
        otherVehicles.build();
        _$failedField = 'intersections';
        intersections.build();
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
