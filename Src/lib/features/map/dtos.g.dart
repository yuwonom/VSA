// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dtos.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GpsPointDto> _$gpsPointDtoSerializer = new _$GpsPointDtoSerializer();

class _$GpsPointDtoSerializer implements StructuredSerializer<GpsPointDto> {
  @override
  final Iterable<Type> types = const [GpsPointDto, _$GpsPointDto];
  @override
  final String wireName = 'GpsPointDto';

  @override
  Iterable serialize(Serializers serializers, GpsPointDto object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'point',
      serializers.serialize(object.point,
          specifiedType: const FullType(LatLng)),
      'altitude',
      serializers.serialize(object.altitude,
          specifiedType: const FullType(double)),
      'accuracy',
      serializers.serialize(object.accuracy,
          specifiedType: const FullType(double)),
      'dateTime',
      serializers.serialize(object.dateTime,
          specifiedType: const FullType(DateTime)),
    ];

    return result;
  }

  @override
  GpsPointDto deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GpsPointDtoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'point':
          result.point = serializers.deserialize(value,
              specifiedType: const FullType(LatLng)) as LatLng;
          break;
        case 'altitude':
          result.altitude = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'accuracy':
          result.accuracy = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'dateTime':
          result.dateTime = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
      }
    }

    return result.build();
  }
}

class _$GpsPointDto extends GpsPointDto {
  @override
  final LatLng point;
  @override
  final double altitude;
  @override
  final double accuracy;
  @override
  final DateTime dateTime;

  factory _$GpsPointDto([void updates(GpsPointDtoBuilder b)]) =>
      (new GpsPointDtoBuilder()..update(updates)).build();

  _$GpsPointDto._({this.point, this.altitude, this.accuracy, this.dateTime})
      : super._() {
    if (point == null) {
      throw new BuiltValueNullFieldError('GpsPointDto', 'point');
    }
    if (altitude == null) {
      throw new BuiltValueNullFieldError('GpsPointDto', 'altitude');
    }
    if (accuracy == null) {
      throw new BuiltValueNullFieldError('GpsPointDto', 'accuracy');
    }
    if (dateTime == null) {
      throw new BuiltValueNullFieldError('GpsPointDto', 'dateTime');
    }
  }

  @override
  GpsPointDto rebuild(void updates(GpsPointDtoBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  GpsPointDtoBuilder toBuilder() => new GpsPointDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GpsPointDto &&
        point == other.point &&
        altitude == other.altitude &&
        accuracy == other.accuracy &&
        dateTime == other.dateTime;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, point.hashCode), altitude.hashCode), accuracy.hashCode),
        dateTime.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GpsPointDto')
          ..add('point', point)
          ..add('altitude', altitude)
          ..add('accuracy', accuracy)
          ..add('dateTime', dateTime))
        .toString();
  }
}

class GpsPointDtoBuilder implements Builder<GpsPointDto, GpsPointDtoBuilder> {
  _$GpsPointDto _$v;

  LatLng _point;
  LatLng get point => _$this._point;
  set point(LatLng point) => _$this._point = point;

  double _altitude;
  double get altitude => _$this._altitude;
  set altitude(double altitude) => _$this._altitude = altitude;

  double _accuracy;
  double get accuracy => _$this._accuracy;
  set accuracy(double accuracy) => _$this._accuracy = accuracy;

  DateTime _dateTime;
  DateTime get dateTime => _$this._dateTime;
  set dateTime(DateTime dateTime) => _$this._dateTime = dateTime;

  GpsPointDtoBuilder();

  GpsPointDtoBuilder get _$this {
    if (_$v != null) {
      _point = _$v.point;
      _altitude = _$v.altitude;
      _accuracy = _$v.accuracy;
      _dateTime = _$v.dateTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GpsPointDto other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$GpsPointDto;
  }

  @override
  void update(void updates(GpsPointDtoBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$GpsPointDto build() {
    final _$result = _$v ??
        new _$GpsPointDto._(
            point: point,
            altitude: altitude,
            accuracy: accuracy,
            dateTime: dateTime);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
