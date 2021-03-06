// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SettingsState extends SettingsState {
  @override
  final BrokerDto broker;
  @override
  final TopicLevelDto topicLevel;
  @override
  final bool isActiveBasicVehicle;
  @override
  final bool isActiveBasicEvents;
  @override
  final String levelAPropertiesPublishTopic;
  @override
  final String levelAStatusPublishTopic;
  @override
  final String levelAIntersectionSubscribeTopic;
  @override
  final String levelBPropertiesPublishTopic;
  @override
  final String levelBStatusPublishTopic;
  @override
  final String levelBIntersectionSubscribeTopic;
  @override
  final String levelBEventsSubscribeTopic;
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
  final String eventsRequestPublishTopic;
  @override
  final String eventsRequestSubscribeTopic;
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
      this.topicLevel,
      this.isActiveBasicVehicle,
      this.isActiveBasicEvents,
      this.levelAPropertiesPublishTopic,
      this.levelAStatusPublishTopic,
      this.levelAIntersectionSubscribeTopic,
      this.levelBPropertiesPublishTopic,
      this.levelBStatusPublishTopic,
      this.levelBIntersectionSubscribeTopic,
      this.levelBEventsSubscribeTopic,
      this.propertiesPublishTopic,
      this.statusPublishTopic,
      this.propertiesRequestPublishTopic,
      this.propertiesRequestSubscribeTopic,
      this.statusRequestPublishTopic,
      this.statusRequestSubscribeTopic,
      this.eventsRequestPublishTopic,
      this.eventsRequestSubscribeTopic,
      this.intersectionsRequestPublishTopic,
      this.intersectionsRequestSubscribeTopic,
      this.disconnectTopic,
      this.isBusy,
      this.exception})
      : super._() {
    if (broker == null) {
      throw new BuiltValueNullFieldError('SettingsState', 'broker');
    }
    if (topicLevel == null) {
      throw new BuiltValueNullFieldError('SettingsState', 'topicLevel');
    }
    if (isActiveBasicVehicle == null) {
      throw new BuiltValueNullFieldError(
          'SettingsState', 'isActiveBasicVehicle');
    }
    if (isActiveBasicEvents == null) {
      throw new BuiltValueNullFieldError(
          'SettingsState', 'isActiveBasicEvents');
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
    if (levelBPropertiesPublishTopic == null) {
      throw new BuiltValueNullFieldError(
          'SettingsState', 'levelBPropertiesPublishTopic');
    }
    if (levelBStatusPublishTopic == null) {
      throw new BuiltValueNullFieldError(
          'SettingsState', 'levelBStatusPublishTopic');
    }
    if (levelBIntersectionSubscribeTopic == null) {
      throw new BuiltValueNullFieldError(
          'SettingsState', 'levelBIntersectionSubscribeTopic');
    }
    if (levelBEventsSubscribeTopic == null) {
      throw new BuiltValueNullFieldError(
          'SettingsState', 'levelBEventsSubscribeTopic');
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
    if (eventsRequestPublishTopic == null) {
      throw new BuiltValueNullFieldError(
          'SettingsState', 'eventsRequestPublishTopic');
    }
    if (eventsRequestSubscribeTopic == null) {
      throw new BuiltValueNullFieldError(
          'SettingsState', 'eventsRequestSubscribeTopic');
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
        topicLevel == other.topicLevel &&
        isActiveBasicVehicle == other.isActiveBasicVehicle &&
        isActiveBasicEvents == other.isActiveBasicEvents &&
        levelAPropertiesPublishTopic == other.levelAPropertiesPublishTopic &&
        levelAStatusPublishTopic == other.levelAStatusPublishTopic &&
        levelAIntersectionSubscribeTopic ==
            other.levelAIntersectionSubscribeTopic &&
        levelBPropertiesPublishTopic == other.levelBPropertiesPublishTopic &&
        levelBStatusPublishTopic == other.levelBStatusPublishTopic &&
        levelBIntersectionSubscribeTopic ==
            other.levelBIntersectionSubscribeTopic &&
        levelBEventsSubscribeTopic == other.levelBEventsSubscribeTopic &&
        propertiesPublishTopic == other.propertiesPublishTopic &&
        statusPublishTopic == other.statusPublishTopic &&
        propertiesRequestPublishTopic == other.propertiesRequestPublishTopic &&
        propertiesRequestSubscribeTopic ==
            other.propertiesRequestSubscribeTopic &&
        statusRequestPublishTopic == other.statusRequestPublishTopic &&
        statusRequestSubscribeTopic == other.statusRequestSubscribeTopic &&
        eventsRequestPublishTopic == other.eventsRequestPublishTopic &&
        eventsRequestSubscribeTopic == other.eventsRequestSubscribeTopic &&
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
                                                                            $jc($jc($jc($jc($jc($jc(0, broker.hashCode), topicLevel.hashCode), isActiveBasicVehicle.hashCode), isActiveBasicEvents.hashCode), levelAPropertiesPublishTopic.hashCode),
                                                                                levelAStatusPublishTopic.hashCode),
                                                                            levelAIntersectionSubscribeTopic.hashCode),
                                                                        levelBPropertiesPublishTopic.hashCode),
                                                                    levelBStatusPublishTopic.hashCode),
                                                                levelBIntersectionSubscribeTopic.hashCode),
                                                            levelBEventsSubscribeTopic.hashCode),
                                                        propertiesPublishTopic.hashCode),
                                                    statusPublishTopic.hashCode),
                                                propertiesRequestPublishTopic.hashCode),
                                            propertiesRequestSubscribeTopic.hashCode),
                                        statusRequestPublishTopic.hashCode),
                                    statusRequestSubscribeTopic.hashCode),
                                eventsRequestPublishTopic.hashCode),
                            eventsRequestSubscribeTopic.hashCode),
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
          ..add('topicLevel', topicLevel)
          ..add('isActiveBasicVehicle', isActiveBasicVehicle)
          ..add('isActiveBasicEvents', isActiveBasicEvents)
          ..add('levelAPropertiesPublishTopic', levelAPropertiesPublishTopic)
          ..add('levelAStatusPublishTopic', levelAStatusPublishTopic)
          ..add('levelAIntersectionSubscribeTopic',
              levelAIntersectionSubscribeTopic)
          ..add('levelBPropertiesPublishTopic', levelBPropertiesPublishTopic)
          ..add('levelBStatusPublishTopic', levelBStatusPublishTopic)
          ..add('levelBIntersectionSubscribeTopic',
              levelBIntersectionSubscribeTopic)
          ..add('levelBEventsSubscribeTopic', levelBEventsSubscribeTopic)
          ..add('propertiesPublishTopic', propertiesPublishTopic)
          ..add('statusPublishTopic', statusPublishTopic)
          ..add('propertiesRequestPublishTopic', propertiesRequestPublishTopic)
          ..add('propertiesRequestSubscribeTopic',
              propertiesRequestSubscribeTopic)
          ..add('statusRequestPublishTopic', statusRequestPublishTopic)
          ..add('statusRequestSubscribeTopic', statusRequestSubscribeTopic)
          ..add('eventsRequestPublishTopic', eventsRequestPublishTopic)
          ..add('eventsRequestSubscribeTopic', eventsRequestSubscribeTopic)
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

  TopicLevelDto _topicLevel;
  TopicLevelDto get topicLevel => _$this._topicLevel;
  set topicLevel(TopicLevelDto topicLevel) => _$this._topicLevel = topicLevel;

  bool _isActiveBasicVehicle;
  bool get isActiveBasicVehicle => _$this._isActiveBasicVehicle;
  set isActiveBasicVehicle(bool isActiveBasicVehicle) =>
      _$this._isActiveBasicVehicle = isActiveBasicVehicle;

  bool _isActiveBasicEvents;
  bool get isActiveBasicEvents => _$this._isActiveBasicEvents;
  set isActiveBasicEvents(bool isActiveBasicEvents) =>
      _$this._isActiveBasicEvents = isActiveBasicEvents;

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

  String _levelBPropertiesPublishTopic;
  String get levelBPropertiesPublishTopic =>
      _$this._levelBPropertiesPublishTopic;
  set levelBPropertiesPublishTopic(String levelBPropertiesPublishTopic) =>
      _$this._levelBPropertiesPublishTopic = levelBPropertiesPublishTopic;

  String _levelBStatusPublishTopic;
  String get levelBStatusPublishTopic => _$this._levelBStatusPublishTopic;
  set levelBStatusPublishTopic(String levelBStatusPublishTopic) =>
      _$this._levelBStatusPublishTopic = levelBStatusPublishTopic;

  String _levelBIntersectionSubscribeTopic;
  String get levelBIntersectionSubscribeTopic =>
      _$this._levelBIntersectionSubscribeTopic;
  set levelBIntersectionSubscribeTopic(
          String levelBIntersectionSubscribeTopic) =>
      _$this._levelBIntersectionSubscribeTopic =
          levelBIntersectionSubscribeTopic;

  String _levelBEventsSubscribeTopic;
  String get levelBEventsSubscribeTopic => _$this._levelBEventsSubscribeTopic;
  set levelBEventsSubscribeTopic(String levelBEventsSubscribeTopic) =>
      _$this._levelBEventsSubscribeTopic = levelBEventsSubscribeTopic;

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

  String _eventsRequestPublishTopic;
  String get eventsRequestPublishTopic => _$this._eventsRequestPublishTopic;
  set eventsRequestPublishTopic(String eventsRequestPublishTopic) =>
      _$this._eventsRequestPublishTopic = eventsRequestPublishTopic;

  String _eventsRequestSubscribeTopic;
  String get eventsRequestSubscribeTopic => _$this._eventsRequestSubscribeTopic;
  set eventsRequestSubscribeTopic(String eventsRequestSubscribeTopic) =>
      _$this._eventsRequestSubscribeTopic = eventsRequestSubscribeTopic;

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
      _topicLevel = _$v.topicLevel;
      _isActiveBasicVehicle = _$v.isActiveBasicVehicle;
      _isActiveBasicEvents = _$v.isActiveBasicEvents;
      _levelAPropertiesPublishTopic = _$v.levelAPropertiesPublishTopic;
      _levelAStatusPublishTopic = _$v.levelAStatusPublishTopic;
      _levelAIntersectionSubscribeTopic = _$v.levelAIntersectionSubscribeTopic;
      _levelBPropertiesPublishTopic = _$v.levelBPropertiesPublishTopic;
      _levelBStatusPublishTopic = _$v.levelBStatusPublishTopic;
      _levelBIntersectionSubscribeTopic = _$v.levelBIntersectionSubscribeTopic;
      _levelBEventsSubscribeTopic = _$v.levelBEventsSubscribeTopic;
      _propertiesPublishTopic = _$v.propertiesPublishTopic;
      _statusPublishTopic = _$v.statusPublishTopic;
      _propertiesRequestPublishTopic = _$v.propertiesRequestPublishTopic;
      _propertiesRequestSubscribeTopic = _$v.propertiesRequestSubscribeTopic;
      _statusRequestPublishTopic = _$v.statusRequestPublishTopic;
      _statusRequestSubscribeTopic = _$v.statusRequestSubscribeTopic;
      _eventsRequestPublishTopic = _$v.eventsRequestPublishTopic;
      _eventsRequestSubscribeTopic = _$v.eventsRequestSubscribeTopic;
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
              topicLevel: topicLevel,
              isActiveBasicVehicle: isActiveBasicVehicle,
              isActiveBasicEvents: isActiveBasicEvents,
              levelAPropertiesPublishTopic: levelAPropertiesPublishTopic,
              levelAStatusPublishTopic: levelAStatusPublishTopic,
              levelAIntersectionSubscribeTopic:
                  levelAIntersectionSubscribeTopic,
              levelBPropertiesPublishTopic: levelBPropertiesPublishTopic,
              levelBStatusPublishTopic: levelBStatusPublishTopic,
              levelBIntersectionSubscribeTopic:
                  levelBIntersectionSubscribeTopic,
              levelBEventsSubscribeTopic: levelBEventsSubscribeTopic,
              propertiesPublishTopic: propertiesPublishTopic,
              statusPublishTopic: statusPublishTopic,
              propertiesRequestPublishTopic: propertiesRequestPublishTopic,
              propertiesRequestSubscribeTopic: propertiesRequestSubscribeTopic,
              statusRequestPublishTopic: statusRequestPublishTopic,
              statusRequestSubscribeTopic: statusRequestSubscribeTopic,
              eventsRequestPublishTopic: eventsRequestPublishTopic,
              eventsRequestSubscribeTopic: eventsRequestSubscribeTopic,
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
