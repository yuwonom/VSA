// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dtos.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const VehicleTypeDto _$car = const VehicleTypeDto._('car');
const VehicleTypeDto _$cycle = const VehicleTypeDto._('cycle');
const VehicleTypeDto _$motorbike = const VehicleTypeDto._('motorbike');
const VehicleTypeDto _$scooter = const VehicleTypeDto._('scooter');
const VehicleTypeDto _$pedestrian = const VehicleTypeDto._('pedestrian');

VehicleTypeDto _$vehicleTypeDtoValueOf(String name) {
  switch (name) {
    case 'car':
      return _$car;
    case 'cycle':
      return _$cycle;
    case 'motorbike':
      return _$motorbike;
    case 'scooter':
      return _$scooter;
    case 'pedestrian':
      return _$pedestrian;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<VehicleTypeDto> _$vehicleTypeDtoValues =
    new BuiltSet<VehicleTypeDto>(const <VehicleTypeDto>[
  _$car,
  _$cycle,
  _$motorbike,
  _$scooter,
  _$pedestrian,
]);

const SecurityLevelDto _$unknown = const SecurityLevelDto._('unknown');
const SecurityLevelDto _$secured = const SecurityLevelDto._('secured');
const SecurityLevelDto _$controlled = const SecurityLevelDto._('controlled');
const SecurityLevelDto _$cautious = const SecurityLevelDto._('cautious');
const SecurityLevelDto _$dangerous = const SecurityLevelDto._('dangerous');
const SecurityLevelDto _$critical = const SecurityLevelDto._('critical');

SecurityLevelDto _$securityLevelDtoValueOf(String name) {
  switch (name) {
    case 'unknown':
      return _$unknown;
    case 'secured':
      return _$secured;
    case 'controlled':
      return _$controlled;
    case 'cautious':
      return _$cautious;
    case 'dangerous':
      return _$dangerous;
    case 'critical':
      return _$critical;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<SecurityLevelDto> _$securityLevelDtoValues =
    new BuiltSet<SecurityLevelDto>(const <SecurityLevelDto>[
  _$unknown,
  _$secured,
  _$controlled,
  _$cautious,
  _$dangerous,
  _$critical,
]);

Serializer<GpsPointDto> _$gpsPointDtoSerializer = new _$GpsPointDtoSerializer();
Serializer<VehicleDto> _$vehicleDtoSerializer = new _$VehicleDtoSerializer();
Serializer<VehicleDimensionDto> _$vehicleDimensionDtoSerializer =
    new _$VehicleDimensionDtoSerializer();
Serializer<VehicleTypeDto> _$vehicleTypeDtoSerializer =
    new _$VehicleTypeDtoSerializer();
Serializer<SecurityLevelDto> _$securityLevelDtoSerializer =
    new _$SecurityLevelDtoSerializer();
Serializer<IntersectionDto> _$intersectionDtoSerializer =
    new _$IntersectionDtoSerializer();

class _$GpsPointDtoSerializer implements StructuredSerializer<GpsPointDto> {
  @override
  final Iterable<Type> types = const [GpsPointDto, _$GpsPointDto];
  @override
  final String wireName = 'GpsPointDto';

  @override
  Iterable serialize(Serializers serializers, GpsPointDto object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'latitude',
      serializers.serialize(object.latitude,
          specifiedType: const FullType(double)),
      'longitude',
      serializers.serialize(object.longitude,
          specifiedType: const FullType(double)),
      'altitude',
      serializers.serialize(object.altitude,
          specifiedType: const FullType(double)),
      'accuracy',
      serializers.serialize(object.accuracy,
          specifiedType: const FullType(double)),
      'dateTime',
      serializers.serialize(object.dateTime,
          specifiedType: const FullType(DateTime)),
      'speed',
      serializers.serialize(object.speed,
          specifiedType: const FullType(double)),
      'heading',
      serializers.serialize(object.heading,
          specifiedType: const FullType(double)),
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
        case 'latitude':
          result.latitude = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'longitude':
          result.longitude = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
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
        case 'speed':
          result.speed = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'heading':
          result.heading = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
      }
    }

    return result.build();
  }
}

class _$VehicleDtoSerializer implements StructuredSerializer<VehicleDto> {
  @override
  final Iterable<Type> types = const [VehicleDto, _$VehicleDto];
  @override
  final String wireName = 'VehicleDto';

  @override
  Iterable serialize(Serializers serializers, VehicleDto object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'dimension',
      serializers.serialize(object.dimension,
          specifiedType: const FullType(VehicleDimensionDto)),
      'type',
      serializers.serialize(object.type,
          specifiedType: const FullType(VehicleTypeDto)),
    ];
    if (object.point != null) {
      result
        ..add('point')
        ..add(serializers.serialize(object.point,
            specifiedType: const FullType(GpsPointDto)));
    }

    return result;
  }

  @override
  VehicleDto deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new VehicleDtoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'dimension':
          result.dimension.replace(serializers.deserialize(value,
                  specifiedType: const FullType(VehicleDimensionDto))
              as VehicleDimensionDto);
          break;
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(VehicleTypeDto)) as VehicleTypeDto;
          break;
        case 'point':
          result.point.replace(serializers.deserialize(value,
              specifiedType: const FullType(GpsPointDto)) as GpsPointDto);
          break;
      }
    }

    return result.build();
  }
}

class _$VehicleDimensionDtoSerializer
    implements StructuredSerializer<VehicleDimensionDto> {
  @override
  final Iterable<Type> types = const [
    VehicleDimensionDto,
    _$VehicleDimensionDto
  ];
  @override
  final String wireName = 'VehicleDimensionDto';

  @override
  Iterable serialize(Serializers serializers, VehicleDimensionDto object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'left',
      serializers.serialize(object.left, specifiedType: const FullType(double)),
      'top',
      serializers.serialize(object.top, specifiedType: const FullType(double)),
      'right',
      serializers.serialize(object.right,
          specifiedType: const FullType(double)),
      'bottom',
      serializers.serialize(object.bottom,
          specifiedType: const FullType(double)),
    ];

    return result;
  }

  @override
  VehicleDimensionDto deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new VehicleDimensionDtoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'left':
          result.left = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'top':
          result.top = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'right':
          result.right = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'bottom':
          result.bottom = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
      }
    }

    return result.build();
  }
}

class _$VehicleTypeDtoSerializer
    implements PrimitiveSerializer<VehicleTypeDto> {
  @override
  final Iterable<Type> types = const <Type>[VehicleTypeDto];
  @override
  final String wireName = 'VehicleTypeDto';

  @override
  Object serialize(Serializers serializers, VehicleTypeDto object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  VehicleTypeDto deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      VehicleTypeDto.valueOf(serialized as String);
}

class _$SecurityLevelDtoSerializer
    implements PrimitiveSerializer<SecurityLevelDto> {
  @override
  final Iterable<Type> types = const <Type>[SecurityLevelDto];
  @override
  final String wireName = 'SecurityLevelDto';

  @override
  Object serialize(Serializers serializers, SecurityLevelDto object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  SecurityLevelDto deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      SecurityLevelDto.valueOf(serialized as String);
}

class _$IntersectionDtoSerializer
    implements StructuredSerializer<IntersectionDto> {
  @override
  final Iterable<Type> types = const [IntersectionDto, _$IntersectionDto];
  @override
  final String wireName = 'IntersectionDto';

  @override
  Iterable serialize(Serializers serializers, IntersectionDto object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'latLng',
      serializers.serialize(object.latLng,
          specifiedType: const FullType(LatLng)),
      'radius',
      serializers.serialize(object.radius,
          specifiedType: const FullType(double)),
    ];

    return result;
  }

  @override
  IntersectionDto deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new IntersectionDtoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'latLng':
          result.latLng = serializers.deserialize(value,
              specifiedType: const FullType(LatLng)) as LatLng;
          break;
        case 'radius':
          result.radius = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
      }
    }

    return result.build();
  }
}

class _$GpsPointDto extends GpsPointDto {
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final double altitude;
  @override
  final double accuracy;
  @override
  final DateTime dateTime;
  @override
  final double speed;
  @override
  final double heading;

  factory _$GpsPointDto([void updates(GpsPointDtoBuilder b)]) =>
      (new GpsPointDtoBuilder()..update(updates)).build();

  _$GpsPointDto._(
      {this.latitude,
      this.longitude,
      this.altitude,
      this.accuracy,
      this.dateTime,
      this.speed,
      this.heading})
      : super._() {
    if (latitude == null) {
      throw new BuiltValueNullFieldError('GpsPointDto', 'latitude');
    }
    if (longitude == null) {
      throw new BuiltValueNullFieldError('GpsPointDto', 'longitude');
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
    if (speed == null) {
      throw new BuiltValueNullFieldError('GpsPointDto', 'speed');
    }
    if (heading == null) {
      throw new BuiltValueNullFieldError('GpsPointDto', 'heading');
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
        latitude == other.latitude &&
        longitude == other.longitude &&
        altitude == other.altitude &&
        accuracy == other.accuracy &&
        dateTime == other.dateTime &&
        speed == other.speed &&
        heading == other.heading;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, latitude.hashCode), longitude.hashCode),
                        altitude.hashCode),
                    accuracy.hashCode),
                dateTime.hashCode),
            speed.hashCode),
        heading.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GpsPointDto')
          ..add('latitude', latitude)
          ..add('longitude', longitude)
          ..add('altitude', altitude)
          ..add('accuracy', accuracy)
          ..add('dateTime', dateTime)
          ..add('speed', speed)
          ..add('heading', heading))
        .toString();
  }
}

class GpsPointDtoBuilder implements Builder<GpsPointDto, GpsPointDtoBuilder> {
  _$GpsPointDto _$v;

  double _latitude;
  double get latitude => _$this._latitude;
  set latitude(double latitude) => _$this._latitude = latitude;

  double _longitude;
  double get longitude => _$this._longitude;
  set longitude(double longitude) => _$this._longitude = longitude;

  double _altitude;
  double get altitude => _$this._altitude;
  set altitude(double altitude) => _$this._altitude = altitude;

  double _accuracy;
  double get accuracy => _$this._accuracy;
  set accuracy(double accuracy) => _$this._accuracy = accuracy;

  DateTime _dateTime;
  DateTime get dateTime => _$this._dateTime;
  set dateTime(DateTime dateTime) => _$this._dateTime = dateTime;

  double _speed;
  double get speed => _$this._speed;
  set speed(double speed) => _$this._speed = speed;

  double _heading;
  double get heading => _$this._heading;
  set heading(double heading) => _$this._heading = heading;

  GpsPointDtoBuilder();

  GpsPointDtoBuilder get _$this {
    if (_$v != null) {
      _latitude = _$v.latitude;
      _longitude = _$v.longitude;
      _altitude = _$v.altitude;
      _accuracy = _$v.accuracy;
      _dateTime = _$v.dateTime;
      _speed = _$v.speed;
      _heading = _$v.heading;
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
            latitude: latitude,
            longitude: longitude,
            altitude: altitude,
            accuracy: accuracy,
            dateTime: dateTime,
            speed: speed,
            heading: heading);
    replace(_$result);
    return _$result;
  }
}

class _$VehicleDto extends VehicleDto {
  @override
  final String id;
  @override
  final String name;
  @override
  final VehicleDimensionDto dimension;
  @override
  final VehicleTypeDto type;
  @override
  final GpsPointDto point;

  factory _$VehicleDto([void updates(VehicleDtoBuilder b)]) =>
      (new VehicleDtoBuilder()..update(updates)).build();

  _$VehicleDto._({this.id, this.name, this.dimension, this.type, this.point})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('VehicleDto', 'id');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('VehicleDto', 'name');
    }
    if (dimension == null) {
      throw new BuiltValueNullFieldError('VehicleDto', 'dimension');
    }
    if (type == null) {
      throw new BuiltValueNullFieldError('VehicleDto', 'type');
    }
  }

  @override
  VehicleDto rebuild(void updates(VehicleDtoBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  VehicleDtoBuilder toBuilder() => new VehicleDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VehicleDto &&
        id == other.id &&
        name == other.name &&
        dimension == other.dimension &&
        type == other.type &&
        point == other.point;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, id.hashCode), name.hashCode), dimension.hashCode),
            type.hashCode),
        point.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('VehicleDto')
          ..add('id', id)
          ..add('name', name)
          ..add('dimension', dimension)
          ..add('type', type)
          ..add('point', point))
        .toString();
  }
}

class VehicleDtoBuilder implements Builder<VehicleDto, VehicleDtoBuilder> {
  _$VehicleDto _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  VehicleDimensionDtoBuilder _dimension;
  VehicleDimensionDtoBuilder get dimension =>
      _$this._dimension ??= new VehicleDimensionDtoBuilder();
  set dimension(VehicleDimensionDtoBuilder dimension) =>
      _$this._dimension = dimension;

  VehicleTypeDto _type;
  VehicleTypeDto get type => _$this._type;
  set type(VehicleTypeDto type) => _$this._type = type;

  GpsPointDtoBuilder _point;
  GpsPointDtoBuilder get point => _$this._point ??= new GpsPointDtoBuilder();
  set point(GpsPointDtoBuilder point) => _$this._point = point;

  VehicleDtoBuilder();

  VehicleDtoBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
      _dimension = _$v.dimension?.toBuilder();
      _type = _$v.type;
      _point = _$v.point?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(VehicleDto other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$VehicleDto;
  }

  @override
  void update(void updates(VehicleDtoBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$VehicleDto build() {
    _$VehicleDto _$result;
    try {
      _$result = _$v ??
          new _$VehicleDto._(
              id: id,
              name: name,
              dimension: dimension.build(),
              type: type,
              point: _point?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'dimension';
        dimension.build();

        _$failedField = 'point';
        _point?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'VehicleDto', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$VehicleDimensionDto extends VehicleDimensionDto {
  @override
  final double left;
  @override
  final double top;
  @override
  final double right;
  @override
  final double bottom;

  factory _$VehicleDimensionDto([void updates(VehicleDimensionDtoBuilder b)]) =>
      (new VehicleDimensionDtoBuilder()..update(updates)).build();

  _$VehicleDimensionDto._({this.left, this.top, this.right, this.bottom})
      : super._() {
    if (left == null) {
      throw new BuiltValueNullFieldError('VehicleDimensionDto', 'left');
    }
    if (top == null) {
      throw new BuiltValueNullFieldError('VehicleDimensionDto', 'top');
    }
    if (right == null) {
      throw new BuiltValueNullFieldError('VehicleDimensionDto', 'right');
    }
    if (bottom == null) {
      throw new BuiltValueNullFieldError('VehicleDimensionDto', 'bottom');
    }
  }

  @override
  VehicleDimensionDto rebuild(void updates(VehicleDimensionDtoBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  VehicleDimensionDtoBuilder toBuilder() =>
      new VehicleDimensionDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VehicleDimensionDto &&
        left == other.left &&
        top == other.top &&
        right == other.right &&
        bottom == other.bottom;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, left.hashCode), top.hashCode), right.hashCode),
        bottom.hashCode));
  }
}

class VehicleDimensionDtoBuilder
    implements Builder<VehicleDimensionDto, VehicleDimensionDtoBuilder> {
  _$VehicleDimensionDto _$v;

  double _left;
  double get left => _$this._left;
  set left(double left) => _$this._left = left;

  double _top;
  double get top => _$this._top;
  set top(double top) => _$this._top = top;

  double _right;
  double get right => _$this._right;
  set right(double right) => _$this._right = right;

  double _bottom;
  double get bottom => _$this._bottom;
  set bottom(double bottom) => _$this._bottom = bottom;

  VehicleDimensionDtoBuilder();

  VehicleDimensionDtoBuilder get _$this {
    if (_$v != null) {
      _left = _$v.left;
      _top = _$v.top;
      _right = _$v.right;
      _bottom = _$v.bottom;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(VehicleDimensionDto other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$VehicleDimensionDto;
  }

  @override
  void update(void updates(VehicleDimensionDtoBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$VehicleDimensionDto build() {
    final _$result = _$v ??
        new _$VehicleDimensionDto._(
            left: left, top: top, right: right, bottom: bottom);
    replace(_$result);
    return _$result;
  }
}

class _$IntersectionDto extends IntersectionDto {
  @override
  final String id;
  @override
  final LatLng latLng;
  @override
  final double radius;

  factory _$IntersectionDto([void updates(IntersectionDtoBuilder b)]) =>
      (new IntersectionDtoBuilder()..update(updates)).build();

  _$IntersectionDto._({this.id, this.latLng, this.radius}) : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('IntersectionDto', 'id');
    }
    if (latLng == null) {
      throw new BuiltValueNullFieldError('IntersectionDto', 'latLng');
    }
    if (radius == null) {
      throw new BuiltValueNullFieldError('IntersectionDto', 'radius');
    }
  }

  @override
  IntersectionDto rebuild(void updates(IntersectionDtoBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  IntersectionDtoBuilder toBuilder() =>
      new IntersectionDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is IntersectionDto &&
        id == other.id &&
        latLng == other.latLng &&
        radius == other.radius;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, id.hashCode), latLng.hashCode), radius.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('IntersectionDto')
          ..add('id', id)
          ..add('latLng', latLng)
          ..add('radius', radius))
        .toString();
  }
}

class IntersectionDtoBuilder
    implements Builder<IntersectionDto, IntersectionDtoBuilder> {
  _$IntersectionDto _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  LatLng _latLng;
  LatLng get latLng => _$this._latLng;
  set latLng(LatLng latLng) => _$this._latLng = latLng;

  double _radius;
  double get radius => _$this._radius;
  set radius(double radius) => _$this._radius = radius;

  IntersectionDtoBuilder();

  IntersectionDtoBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _latLng = _$v.latLng;
      _radius = _$v.radius;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(IntersectionDto other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$IntersectionDto;
  }

  @override
  void update(void updates(IntersectionDtoBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$IntersectionDto build() {
    final _$result =
        _$v ?? new _$IntersectionDto._(id: id, latLng: latLng, radius: radius);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
