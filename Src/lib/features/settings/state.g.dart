// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SettingsState extends SettingsState {
  @override
  final BrokerDto broker;
  @override
  final bool isActiveLevelA;
  @override
  final bool isActiveLevelB;
  @override
  final bool isActiveLevelC;
  @override
  final bool isActiveLevelD;
  @override
  final bool isActiveBasicVehicle;
  @override
  final bool isActiveBasicTraffic;
  @override
  final String levelAPropertiesPublishTopic;
  @override
  final String levelAStatusPublishTopic;
  @override
  final String levelAIntersectionSubscribeTopic;
  @override
  final String propertiesPublishTopic;
  @override
  final String statusPublishTopic;
  @override
  final String propertiesRequestPublishTopic;
  @override
  final String propertiesRequestSubscribeTopic;
  @override
  final String statusRequestPublishTopic;
  @override
  final String statusRequestSubscribeTopic;
  @override
  final String trafficRequestPublishTopic;
  @override
  final String trafficRequestSubscribeTopic;
  @override
  final String intersectionsRequestPublishTopic;
  @override
  final String intersectionsRequestSubscribeTopic;
  @override
  final String disconnectTopic;
  @override
  final bool isBusy;
  @override
  final ActionException exception;

  factory _$SettingsState([void Function(SettingsStateBuilder) updates]) =>
      (new SettingsStateBuilder()..update(updates)).build();

  _$SettingsState._(
      {this.broker,
      this.isActiveLevelA,
      this.isActiveLevelB,
      this.isActiveLevelC,
      this.isActiveLevelD,
      this.isActiveBasicVehicle,
      this.isActiveBasicTraffic,
      this.levelAPropertiesPublishTopic,
      this.levelAStatusPublishTopic,
      this.levelAIntersectionSubscribeTopic,
      this.propertiesPublishTopic,
      this.statusPublishTopic,
      this.propertiesRequestPublishTopic,
      this.propertiesRequestSubscribeTopic,
      this.statusRequestPublishTopic,
      this.statusRequestSubscribeTopic,
      this.trafficRequestPublishTopic,
      this.trafficRequestSubscribeTopic,
      this.intersectionsRequestPublishTopic,
      this.intersectionsRequestSubscribeTopic,
      this.disconnectTopic,
      this.isBusy,
      this.exception})
      : super._() {
    if (broker == null) {
      throw new BuiltValueNullFieldError('SettingsState', 'broker');
    }
    if (isActiveLevelA == null) {
      throw new BuiltValueNullFieldError('SettingsState', 'isActiveLevelA');
    }
    if (isActiveLevelB == null) {
      throw new BuiltValueNullFieldError('SettingsState', 'isActiveLevelB');
    }
    if (isActiveLevelC == null) {
      throw new BuiltValueNullFieldError('SettingsState', 'isActiveLevelC');
    }
    if (isActiveLevelD == null) {
      throw new BuiltValueNullFieldError('SettingsState', 'isActiveLevelD');
    }
    if (isActiveBasicVehicle == null) {
      throw new BuiltValueNullFieldError(
          'SettingsState', 'isActiveBasicVehicle');
    }
    if (isActiveBasicTraffic == null) {
      throw new BuiltValueNullFieldError(
          'SettingsState', 'isActiveBasicTraffic');
    }
    if (levelAPropertiesPublishTopic == null) {
      throw new BuiltValueNullFieldError(
          'SettingsState', 'levelAPropertiesPublishTopic');
    }
    if (levelAStatusPublishTopic == null) {
      throw new BuiltValueNullFieldError(
          'SettingsState', 'levelAStatusPublishTopic');
    }
    if (levelAIntersectionSubscribeTopic == null) {
      throw new BuiltValueNullFieldError(
          'SettingsState', 'levelAIntersectionSubscribeTopic');
    }
    if (propertiesPublishTopic == null) {
      throw new BuiltValueNullFieldError(
          'SettingsState', 'propertiesPublishTopic');
    }
    if (statusPublishTopic == null) {
      throw new BuiltValueNullFieldError('SettingsState', 'statusPublishTopic');
    }
    if (propertiesRequestPublishTopic == null) {
      throw new BuiltValueNullFieldError(
          'SettingsState', 'propertiesRequestPublishTopic');
    }
    if (propertiesRequestSubscribeTopic == null) {
      throw new BuiltValueNullFieldError(
          'SettingsState', 'propertiesRequestSubscribeTopic');
    }
    if (statusRequestPublishTopic == null) {
      throw new BuiltValueNullFieldError(
          'SettingsState', 'statusRequestPublishTopic');
    }
    if (statusRequestSubscribeTopic == null) {
      throw new BuiltValueNullFieldError(
          'SettingsState', 'statusRequestSubscribeTopic');
    }
    if (trafficRequestPublishTopic == null) {
      throw new BuiltValueNullFieldError(
          'SettingsState', 'trafficRequestPublishTopic');
    }
    if (trafficRequestSubscribeTopic == null) {
      throw new BuiltValueNullFieldError(
          'SettingsState', 'trafficRequestSubscribeTopic');
    }
    if (intersectionsRequestPublishTopic == null) {
      throw new BuiltValueNullFieldError(
          'SettingsState', 'intersectionsRequestPublishTopic');
    }
    if (intersectionsRequestSubscribeTopic == null) {
      throw new BuiltValueNullFieldError(
          'SettingsState', 'intersectionsRequestSubscribeTopic');
    }
    if (disconnectTopic == null) {
      throw new BuiltValueNullFieldError('SettingsState', 'disconnectTopic');
    }
    if (isBusy == null) {
      throw new BuiltValueNullFieldError('SettingsState', 'isBusy');
    }
  }

  @override
  SettingsState rebuild(void Function(SettingsStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SettingsStateBuilder toBuilder() => new SettingsStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SettingsState &&
        broker == other.broker &&
        isActiveLevelA == other.isActiveLevelA &&
        isActiveLevelB == other.isActiveLevelB &&
        isActiveLevelC == other.isActiveLevelC &&
        isActiveLevelD == other.isActiveLevelD &&
        isActiveBasicVehicle == other.isActiveBasicVehicle &&
        isActiveBasicTraffic == other.isActiveBasicTraffic &&
        levelAPropertiesPublishTopic == other.levelAPropertiesPublishTopic &&
        levelAStatusPublishTopic == other.levelAStatusPublishTopic &&
        levelAIntersectionSubscribeTopic ==
            other.levelAIntersectionSubscribeTopic &&
        propertiesPublishTopic == other.propertiesPublishTopic &&
        statusPublishTopic == other.statusPublishTopic &&
        propertiesRequestPublishTopic == other.propertiesRequestPublishTopic &&
        propertiesRequestSubscribeTopic ==
            other.propertiesRequestSubscribeTopic &&
        statusRequestPublishTopic == other.statusRequestPublishTopic &&
        statusRequestSubscribeTopic == other.statusRequestSubscribeTopic &&
        trafficRequestPublishTopic == other.trafficRequestPublishTopic &&
        trafficRequestSubscribeTopic == other.trafficRequestSubscribeTopic &&
        intersectionsRequestPublishTopic ==
            other.intersectionsRequestPublishTopic &&
        intersectionsRequestSubscribeTopic ==
            other.intersectionsRequestSubscribeTopic &&
        disconnectTopic == other.disconnectTopic &&
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
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(
                                                                $jc(
                                                                    $jc(
                                                                        $jc(
                                                                            $jc($jc($jc($jc($jc(0, broker.hashCode), isActiveLevelA.hashCode), isActiveLevelB.hashCode), isActiveLevelC.hashCode),
                                                                                isActiveLevelD.hashCode),
                                                                            isActiveBasicVehicle.hashCode),
                                                                        isActiveBasicTraffic.hashCode),
                                                                    levelAPropertiesPublishTopic.hashCode),
                                                                levelAStatusPublishTopic.hashCode),
                                                            levelAIntersectionSubscribeTopic.hashCode),
                                                        propertiesPublishTopic.hashCode),
                                                    statusPublishTopic.hashCode),
                                                propertiesRequestPublishTopic.hashCode),
                                            propertiesRequestSubscribeTopic.hashCode),
                                        statusRequestPublishTopic.hashCode),
                                    statusRequestSubscribeTopic.hashCode),
                                trafficRequestPublishTopic.hashCode),
                            trafficRequestSubscribeTopic.hashCode),
                        intersectionsRequestPublishTopic.hashCode),
                    intersectionsRequestSubscribeTopic.hashCode),
                disconnectTopic.hashCode),
            isBusy.hashCode),
        exception.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SettingsState')
          ..add('broker', broker)
          ..add('isActiveLevelA', isActiveLevelA)
          ..add('isActiveLevelB', isActiveLevelB)
          ..add('isActiveLevelC', isActiveLevelC)
          ..add('isActiveLevelD', isActiveLevelD)
          ..add('isActiveBasicVehicle', isActiveBasicVehicle)
          ..add('isActiveBasicTraffic', isActiveBasicTraffic)
          ..add('levelAPropertiesPublishTopic', levelAPropertiesPublishTopic)
          ..add('levelAStatusPublishTopic', levelAStatusPublishTopic)
          ..add('levelAIntersectionSubscribeTopic',
              levelAIntersectionSubscribeTopic)
          ..add('propertiesPublishTopic', propertiesPublishTopic)
          ..add('statusPublishTopic', statusPublishTopic)
          ..add('propertiesRequestPublishTopic', propertiesRequestPublishTopic)
          ..add('propertiesRequestSubscribeTopic',
              propertiesRequestSubscribeTopic)
          ..add('statusRequestPublishTopic', statusRequestPublishTopic)
          ..add('statusRequestSubscribeTopic', statusRequestSubscribeTopic)
          ..add('trafficRequestPublishTopic', trafficRequestPublishTopic)
          ..add('trafficRequestSubscribeTopic', trafficRequestSubscribeTopic)
          ..add('intersectionsRequestPublishTopic',
              intersectionsRequestPublishTopic)
          ..add('intersectionsRequestSubscribeTopic',
              intersectionsRequestSubscribeTopic)
          ..add('disconnectTopic', disconnectTopic)
          ..add('isBusy', isBusy)
          ..add('exception', exception))
        .toString();
  }
}

class SettingsStateBuilder
    implements Builder<SettingsState, SettingsStateBuilder> {
  _$SettingsState _$v;

  BrokerDtoBuilder _broker;
  BrokerDtoBuilder get broker => _$this._broker ??= new BrokerDtoBuilder();
  set broker(BrokerDtoBuilder broker) => _$this._broker = broker;

  bool _isActiveLevelA;
  bool get isActiveLevelA => _$this._isActiveLevelA;
  set isActiveLevelA(bool isActiveLevelA) =>
      _$this._isActiveLevelA = isActiveLevelA;

  bool _isActiveLevelB;
  bool get isActiveLevelB => _$this._isActiveLevelB;
  set isActiveLevelB(bool isActiveLevelB) =>
      _$this._isActiveLevelB = isActiveLevelB;

  bool _isActiveLevelC;
  bool get isActiveLevelC => _$this._isActiveLevelC;
  set isActiveLevelC(bool isActiveLevelC) =>
      _$this._isActiveLevelC = isActiveLevelC;

  bool _isActiveLevelD;
  bool get isActiveLevelD => _$this._isActiveLevelD;
  set isActiveLevelD(bool isActiveLevelD) =>
      _$this._isActiveLevelD = isActiveLevelD;

  bool _isActiveBasicVehicle;
  bool get isActiveBasicVehicle => _$this._isActiveBasicVehicle;
  set isActiveBasicVehicle(bool isActiveBasicVehicle) =>
      _$this._isActiveBasicVehicle = isActiveBasicVehicle;

  bool _isActiveBasicTraffic;
  bool get isActiveBasicTraffic => _$this._isActiveBasicTraffic;
  set isActiveBasicTraffic(bool isActiveBasicTraffic) =>
      _$this._isActiveBasicTraffic = isActiveBasicTraffic;

  String _levelAPropertiesPublishTopic;
  String get levelAPropertiesPublishTopic =>
      _$this._levelAPropertiesPublishTopic;
  set levelAPropertiesPublishTopic(String levelAPropertiesPublishTopic) =>
      _$this._levelAPropertiesPublishTopic = levelAPropertiesPublishTopic;

  String _levelAStatusPublishTopic;
  String get levelAStatusPublishTopic => _$this._levelAStatusPublishTopic;
  set levelAStatusPublishTopic(String levelAStatusPublishTopic) =>
      _$this._levelAStatusPublishTopic = levelAStatusPublishTopic;

  String _levelAIntersectionSubscribeTopic;
  String get levelAIntersectionSubscribeTopic =>
      _$this._levelAIntersectionSubscribeTopic;
  set levelAIntersectionSubscribeTopic(
          String levelAIntersectionSubscribeTopic) =>
      _$this._levelAIntersectionSubscribeTopic =
          levelAIntersectionSubscribeTopic;

  String _propertiesPublishTopic;
  String get propertiesPublishTopic => _$this._propertiesPublishTopic;
  set propertiesPublishTopic(String propertiesPublishTopic) =>
      _$this._propertiesPublishTopic = propertiesPublishTopic;

  String _statusPublishTopic;
  String get statusPublishTopic => _$this._statusPublishTopic;
  set statusPublishTopic(String statusPublishTopic) =>
      _$this._statusPublishTopic = statusPublishTopic;

  String _propertiesRequestPublishTopic;
  String get propertiesRequestPublishTopic =>
      _$this._propertiesRequestPublishTopic;
  set propertiesRequestPublishTopic(String propertiesRequestPublishTopic) =>
      _$this._propertiesRequestPublishTopic = propertiesRequestPublishTopic;

  String _propertiesRequestSubscribeTopic;
  String get propertiesRequestSubscribeTopic =>
      _$this._propertiesRequestSubscribeTopic;
  set propertiesRequestSubscribeTopic(String propertiesRequestSubscribeTopic) =>
      _$this._propertiesRequestSubscribeTopic = propertiesRequestSubscribeTopic;

  String _statusRequestPublishTopic;
  String get statusRequestPublishTopic => _$this._statusRequestPublishTopic;
  set statusRequestPublishTopic(String statusRequestPublishTopic) =>
      _$this._statusRequestPublishTopic = statusRequestPublishTopic;

  String _statusRequestSubscribeTopic;
  String get statusRequestSubscribeTopic => _$this._statusRequestSubscribeTopic;
  set statusRequestSubscribeTopic(String statusRequestSubscribeTopic) =>
      _$this._statusRequestSubscribeTopic = statusRequestSubscribeTopic;

  String _trafficRequestPublishTopic;
  String get trafficRequestPublishTopic => _$this._trafficRequestPublishTopic;
  set trafficRequestPublishTopic(String trafficRequestPublishTopic) =>
      _$this._trafficRequestPublishTopic = trafficRequestPublishTopic;

  String _trafficRequestSubscribeTopic;
  String get trafficRequestSubscribeTopic =>
      _$this._trafficRequestSubscribeTopic;
  set trafficRequestSubscribeTopic(String trafficRequestSubscribeTopic) =>
      _$this._trafficRequestSubscribeTopic = trafficRequestSubscribeTopic;

  String _intersectionsRequestPublishTopic;
  String get intersectionsRequestPublishTopic =>
      _$this._intersectionsRequestPublishTopic;
  set intersectionsRequestPublishTopic(
          String intersectionsRequestPublishTopic) =>
      _$this._intersectionsRequestPublishTopic =
          intersectionsRequestPublishTopic;

  String _intersectionsRequestSubscribeTopic;
  String get intersectionsRequestSubscribeTopic =>
      _$this._intersectionsRequestSubscribeTopic;
  set intersectionsRequestSubscribeTopic(
          String intersectionsRequestSubscribeTopic) =>
      _$this._intersectionsRequestSubscribeTopic =
          intersectionsRequestSubscribeTopic;

  String _disconnectTopic;
  String get disconnectTopic => _$this._disconnectTopic;
  set disconnectTopic(String disconnectTopic) =>
      _$this._disconnectTopic = disconnectTopic;

  bool _isBusy;
  bool get isBusy => _$this._isBusy;
  set isBusy(bool isBusy) => _$this._isBusy = isBusy;

  ActionException _exception;
  ActionException get exception => _$this._exception;
  set exception(ActionException exception) => _$this._exception = exception;

  SettingsStateBuilder();

  SettingsStateBuilder get _$this {
    if (_$v != null) {
      _broker = _$v.broker?.toBuilder();
      _isActiveLevelA = _$v.isActiveLevelA;
      _isActiveLevelB = _$v.isActiveLevelB;
      _isActiveLevelC = _$v.isActiveLevelC;
      _isActiveLevelD = _$v.isActiveLevelD;
      _isActiveBasicVehicle = _$v.isActiveBasicVehicle;
      _isActiveBasicTraffic = _$v.isActiveBasicTraffic;
      _levelAPropertiesPublishTopic = _$v.levelAPropertiesPublishTopic;
      _levelAStatusPublishTopic = _$v.levelAStatusPublishTopic;
      _levelAIntersectionSubscribeTopic = _$v.levelAIntersectionSubscribeTopic;
      _propertiesPublishTopic = _$v.propertiesPublishTopic;
      _statusPublishTopic = _$v.statusPublishTopic;
      _propertiesRequestPublishTopic = _$v.propertiesRequestPublishTopic;
      _propertiesRequestSubscribeTopic = _$v.propertiesRequestSubscribeTopic;
      _statusRequestPublishTopic = _$v.statusRequestPublishTopic;
      _statusRequestSubscribeTopic = _$v.statusRequestSubscribeTopic;
      _trafficRequestPublishTopic = _$v.trafficRequestPublishTopic;
      _trafficRequestSubscribeTopic = _$v.trafficRequestSubscribeTopic;
      _intersectionsRequestPublishTopic = _$v.intersectionsRequestPublishTopic;
      _intersectionsRequestSubscribeTopic =
          _$v.intersectionsRequestSubscribeTopic;
      _disconnectTopic = _$v.disconnectTopic;
      _isBusy = _$v.isBusy;
      _exception = _$v.exception;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SettingsState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SettingsState;
  }

  @override
  void update(void Function(SettingsStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SettingsState build() {
    _$SettingsState _$result;
    try {
      _$result = _$v ??
          new _$SettingsState._(
              broker: broker.build(),
              isActiveLevelA: isActiveLevelA,
              isActiveLevelB: isActiveLevelB,
              isActiveLevelC: isActiveLevelC,
              isActiveLevelD: isActiveLevelD,
              isActiveBasicVehicle: isActiveBasicVehicle,
              isActiveBasicTraffic: isActiveBasicTraffic,
              levelAPropertiesPublishTopic: levelAPropertiesPublishTopic,
              levelAStatusPublishTopic: levelAStatusPublishTopic,
              levelAIntersectionSubscribeTopic:
                  levelAIntersectionSubscribeTopic,
              propertiesPublishTopic: propertiesPublishTopic,
              statusPublishTopic: statusPublishTopic,
              propertiesRequestPublishTopic: propertiesRequestPublishTopic,
              propertiesRequestSubscribeTopic: propertiesRequestSubscribeTopic,
              statusRequestPublishTopic: statusRequestPublishTopic,
              statusRequestSubscribeTopic: statusRequestSubscribeTopic,
              trafficRequestPublishTopic: trafficRequestPublishTopic,
              trafficRequestSubscribeTopic: trafficRequestSubscribeTopic,
              intersectionsRequestPublishTopic:
                  intersectionsRequestPublishTopic,
              intersectionsRequestSubscribeTopic:
                  intersectionsRequestSubscribeTopic,
              disconnectTopic: disconnectTopic,
              isBusy: isBusy,
              exception: exception);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'broker';
        broker.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SettingsState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
