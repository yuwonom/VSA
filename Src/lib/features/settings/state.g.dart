// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SettingsState extends SettingsState {
  @override
  final BrokerDto broker;
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
  final bool isBusy;
  @override
  final ActionException exception;

  factory _$SettingsState([void updates(SettingsStateBuilder b)]) =>
      (new SettingsStateBuilder()..update(updates)).build();

  _$SettingsState._(
      {this.broker,
      this.propertiesPublishTopic,
      this.statusPublishTopic,
      this.propertiesRequestPublishTopic,
      this.propertiesRequestSubscribeTopic,
      this.statusRequestPublishTopic,
      this.statusRequestSubscribeTopic,
      this.trafficRequestPublishTopic,
      this.trafficRequestSubscribeTopic,
      this.isBusy,
      this.exception})
      : super._() {
    if (broker == null) {
      throw new BuiltValueNullFieldError('SettingsState', 'broker');
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
    if (isBusy == null) {
      throw new BuiltValueNullFieldError('SettingsState', 'isBusy');
    }
  }

  @override
  SettingsState rebuild(void updates(SettingsStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  SettingsStateBuilder toBuilder() => new SettingsStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SettingsState &&
        broker == other.broker &&
        propertiesPublishTopic == other.propertiesPublishTopic &&
        statusPublishTopic == other.statusPublishTopic &&
        propertiesRequestPublishTopic == other.propertiesRequestPublishTopic &&
        propertiesRequestSubscribeTopic ==
            other.propertiesRequestSubscribeTopic &&
        statusRequestPublishTopic == other.statusRequestPublishTopic &&
        statusRequestSubscribeTopic == other.statusRequestSubscribeTopic &&
        trafficRequestPublishTopic == other.trafficRequestPublishTopic &&
        trafficRequestSubscribeTopic == other.trafficRequestSubscribeTopic &&
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
                                        $jc($jc(0, broker.hashCode),
                                            propertiesPublishTopic.hashCode),
                                        statusPublishTopic.hashCode),
                                    propertiesRequestPublishTopic.hashCode),
                                propertiesRequestSubscribeTopic.hashCode),
                            statusRequestPublishTopic.hashCode),
                        statusRequestSubscribeTopic.hashCode),
                    trafficRequestPublishTopic.hashCode),
                trafficRequestSubscribeTopic.hashCode),
            isBusy.hashCode),
        exception.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SettingsState')
          ..add('broker', broker)
          ..add('propertiesPublishTopic', propertiesPublishTopic)
          ..add('statusPublishTopic', statusPublishTopic)
          ..add('propertiesRequestPublishTopic', propertiesRequestPublishTopic)
          ..add('propertiesRequestSubscribeTopic',
              propertiesRequestSubscribeTopic)
          ..add('statusRequestPublishTopic', statusRequestPublishTopic)
          ..add('statusRequestSubscribeTopic', statusRequestSubscribeTopic)
          ..add('trafficRequestPublishTopic', trafficRequestPublishTopic)
          ..add('trafficRequestSubscribeTopic', trafficRequestSubscribeTopic)
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
      _propertiesPublishTopic = _$v.propertiesPublishTopic;
      _statusPublishTopic = _$v.statusPublishTopic;
      _propertiesRequestPublishTopic = _$v.propertiesRequestPublishTopic;
      _propertiesRequestSubscribeTopic = _$v.propertiesRequestSubscribeTopic;
      _statusRequestPublishTopic = _$v.statusRequestPublishTopic;
      _statusRequestSubscribeTopic = _$v.statusRequestSubscribeTopic;
      _trafficRequestPublishTopic = _$v.trafficRequestPublishTopic;
      _trafficRequestSubscribeTopic = _$v.trafficRequestSubscribeTopic;
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
  void update(void updates(SettingsStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$SettingsState build() {
    _$SettingsState _$result;
    try {
      _$result = _$v ??
          new _$SettingsState._(
              broker: broker.build(),
              propertiesPublishTopic: propertiesPublishTopic,
              statusPublishTopic: statusPublishTopic,
              propertiesRequestPublishTopic: propertiesRequestPublishTopic,
              propertiesRequestSubscribeTopic: propertiesRequestSubscribeTopic,
              statusRequestPublishTopic: statusRequestPublishTopic,
              statusRequestSubscribeTopic: statusRequestSubscribeTopic,
              trafficRequestPublishTopic: trafficRequestPublishTopic,
              trafficRequestSubscribeTopic: trafficRequestSubscribeTopic,
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
