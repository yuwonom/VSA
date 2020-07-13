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

const GeometryTypeDto _$point = const GeometryTypeDto._('point');
const GeometryTypeDto _$lineString = const GeometryTypeDto._('lineString');

GeometryTypeDto _$valueOf(String name) {
  switch (name) {
    case 'point':
      return _$point;
    case 'lineString':
      return _$lineString;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<GeometryTypeDto> _$geometryTypeDtooValues =
    new BuiltSet<GeometryTypeDto>(const <GeometryTypeDto>[
  _$point,
  _$lineString,
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
Serializer<EventDto> _$eventDtoSerializer = new _$EventDtoSerializer();
Serializer<GeometryTypeDto> _$geometryTypeDtoSerializer =
    new _$GeometryTypeDtoSerializer();

class _$GpsPointDtoSerializer implements StructuredSerializer<GpsPointDto> {
  @override
  final Iterable<Type> types = const [GpsPointDto, _$GpsPointDto];
  @override
  final String wireName = 'GpsPointDto';

  @override
  Iterable<Object> serialize(Serializers serializers, GpsPointDto object,
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
  GpsPointDto deserialize(Serializers serializers, Iterable<Object> serialized,
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
  Iterable<Object> serialize(Serializers serializers, VehicleDto object,
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
  VehicleDto deserialize(Serializers serializers, Iterable<Object> serialized,
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
  Iterable<Object> serialize(
      Serializers serializers, VehicleDimensionDto object,
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
  VehicleDimensionDto deserialize(
      Serializers serializers, Iterable<Object> serialized,
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
  Iterable<Object> serialize(Serializers serializers, IntersectionDto object,
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
  IntersectionDto deserialize(
      Serializers serializers, Iterable<Object> serialized,
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

class _$EventDtoSerializer implements StructuredSerializer<EventDto> {
  @override
  final Iterable<Type> types = const [EventDto, _$EventDto];
  @override
  final String wireName = 'EventDto';

  @override
  Iterable<Object> serialize(Serializers serializers, EventDto object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'geometries',
      serializers.serialize(object.geometries,
          specifiedType:
              const FullType(List, const [const FullType(GeometryDto)])),
      'sourceName',
      serializers.serialize(object.sourceName,
          specifiedType: const FullType(String)),
      'eventType',
      serializers.serialize(object.eventType,
          specifiedType: const FullType(String)),
      'eventSubtype',
      serializers.serialize(object.eventSubtype,
          specifiedType: const FullType(String)),
      'impactType',
      serializers.serialize(object.impactType,
          specifiedType: const FullType(String)),
      'startTime',
      serializers.serialize(object.startTime,
          specifiedType: const FullType(DateTime)),
      'endTime',
      serializers.serialize(object.endTime,
          specifiedType: const FullType(DateTime)),
      'eventPriority',
      serializers.serialize(object.eventPriority,
          specifiedType: const FullType(String)),
    ];
    if (object.impactSubtype != null) {
      result
        ..add('impactSubtype')
        ..add(serializers.serialize(object.impactSubtype,
            specifiedType: const FullType(String)));
    }
    if (object.description != null) {
      result
        ..add('description')
        ..add(serializers.serialize(object.description,
            specifiedType: const FullType(String)));
    }
    if (object.information != null) {
      result
        ..add('information')
        ..add(serializers.serialize(object.information,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  EventDto deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new EventDtoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'geometries':
          result.geometries = serializers.deserialize(value,
                  specifiedType:
                      const FullType(List, const [const FullType(GeometryDto)]))
              as List<GeometryDto>;
          break;
        case 'sourceName':
          result.sourceName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'eventType':
          result.eventType = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'eventSubtype':
          result.eventSubtype = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'impactType':
          result.impactType = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'impactSubtype':
          result.impactSubtype = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'startTime':
          result.startTime = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'endTime':
          result.endTime = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'eventPriority':
          result.eventPriority = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'information':
          result.information = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GeometryTypeDtoSerializer
    implements PrimitiveSerializer<GeometryTypeDto> {
  @override
  final Iterable<Type> types = const <Type>[GeometryTypeDto];
  @override
  final String wireName = 'GeometryTypeDto';

  @override
  Object serialize(Serializers serializers, GeometryTypeDto object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  GeometryTypeDto deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GeometryTypeDto.valueOf(serialized as String);
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

  factory _$GpsPointDto([void Function(GpsPointDtoBuilder) updates]) =>
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
  GpsPointDto rebuild(void Function(GpsPointDtoBuilder) updates) =>
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
  void update(void Function(GpsPointDtoBuilder) updates) {
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

  factory _$VehicleDto([void Function(VehicleDtoBuilder) updates]) =>
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
  VehicleDto rebuild(void Function(VehicleDtoBuilder) updates) =>
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
  void update(void Function(VehicleDtoBuilder) updates) {
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

  factory _$VehicleDimensionDto(
          [void Function(VehicleDimensionDtoBuilder) updates]) =>
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
  VehicleDimensionDto rebuild(
          void Function(VehicleDimensionDtoBuilder) updates) =>
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
  void update(void Function(VehicleDimensionDtoBuilder) updates) {
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

  factory _$IntersectionDto([void Function(IntersectionDtoBuilder) updates]) =>
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
  IntersectionDto rebuild(void Function(IntersectionDtoBuilder) updates) =>
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
  void update(void Function(IntersectionDtoBuilder) updates) {
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

class _$EventDto extends EventDto {
  @override
  final int id;
  @override
  final List<GeometryDto> geometries;
  @override
  final String sourceName;
  @override
  final String eventType;
  @override
  final String eventSubtype;
  @override
  final String impactType;
  @override
  final String impactSubtype;
  @override
  final DateTime startTime;
  @override
  final DateTime endTime;
  @override
  final String eventPriority;
  @override
  final String description;
  @override
  final String information;

  factory _$EventDto([void Function(EventDtoBuilder) updates]) =>
      (new EventDtoBuilder()..update(updates)).build();

  _$EventDto._(
      {this.id,
      this.geometries,
      this.sourceName,
      this.eventType,
      this.eventSubtype,
      this.impactType,
      this.impactSubtype,
      this.startTime,
      this.endTime,
      this.eventPriority,
      this.description,
      this.information})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('EventDto', 'id');
    }
    if (geometries == null) {
      throw new BuiltValueNullFieldError('EventDto', 'geometries');
    }
    if (sourceName == null) {
      throw new BuiltValueNullFieldError('EventDto', 'sourceName');
    }
    if (eventType == null) {
      throw new BuiltValueNullFieldError('EventDto', 'eventType');
    }
    if (eventSubtype == null) {
      throw new BuiltValueNullFieldError('EventDto', 'eventSubtype');
    }
    if (impactType == null) {
      throw new BuiltValueNullFieldError('EventDto', 'impactType');
    }
    if (startTime == null) {
      throw new BuiltValueNullFieldError('EventDto', 'startTime');
    }
    if (endTime == null) {
      throw new BuiltValueNullFieldError('EventDto', 'endTime');
    }
    if (eventPriority == null) {
      throw new BuiltValueNullFieldError('EventDto', 'eventPriority');
    }
  }

  @override
  EventDto rebuild(void Function(EventDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EventDtoBuilder toBuilder() => new EventDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EventDto &&
        id == other.id &&
        geometries == other.geometries &&
        sourceName == other.sourceName &&
        eventType == other.eventType &&
        eventSubtype == other.eventSubtype &&
        impactType == other.impactType &&
        impactSubtype == other.impactSubtype &&
        startTime == other.startTime &&
        endTime == other.endTime &&
        eventPriority == other.eventPriority &&
        description == other.description &&
        information == other.information;
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
                                            $jc($jc(0, id.hashCode),
                                                geometries.hashCode),
                                            sourceName.hashCode),
                                        eventType.hashCode),
                                    eventSubtype.hashCode),
                                impactType.hashCode),
                            impactSubtype.hashCode),
                        startTime.hashCode),
                    endTime.hashCode),
                eventPriority.hashCode),
            description.hashCode),
        information.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('EventDto')
          ..add('id', id)
          ..add('geometries', geometries)
          ..add('sourceName', sourceName)
          ..add('eventType', eventType)
          ..add('eventSubtype', eventSubtype)
          ..add('impactType', impactType)
          ..add('impactSubtype', impactSubtype)
          ..add('startTime', startTime)
          ..add('endTime', endTime)
          ..add('eventPriority', eventPriority)
          ..add('description', description)
          ..add('information', information))
        .toString();
  }
}

class EventDtoBuilder implements Builder<EventDto, EventDtoBuilder> {
  _$EventDto _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  List<GeometryDto> _geometries;
  List<GeometryDto> get geometries => _$this._geometries;
  set geometries(List<GeometryDto> geometries) =>
      _$this._geometries = geometries;

  String _sourceName;
  String get sourceName => _$this._sourceName;
  set sourceName(String sourceName) => _$this._sourceName = sourceName;

  String _eventType;
  String get eventType => _$this._eventType;
  set eventType(String eventType) => _$this._eventType = eventType;

  String _eventSubtype;
  String get eventSubtype => _$this._eventSubtype;
  set eventSubtype(String eventSubtype) => _$this._eventSubtype = eventSubtype;

  String _impactType;
  String get impactType => _$this._impactType;
  set impactType(String impactType) => _$this._impactType = impactType;

  String _impactSubtype;
  String get impactSubtype => _$this._impactSubtype;
  set impactSubtype(String impactSubtype) =>
      _$this._impactSubtype = impactSubtype;

  DateTime _startTime;
  DateTime get startTime => _$this._startTime;
  set startTime(DateTime startTime) => _$this._startTime = startTime;

  DateTime _endTime;
  DateTime get endTime => _$this._endTime;
  set endTime(DateTime endTime) => _$this._endTime = endTime;

  String _eventPriority;
  String get eventPriority => _$this._eventPriority;
  set eventPriority(String eventPriority) =>
      _$this._eventPriority = eventPriority;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  String _information;
  String get information => _$this._information;
  set information(String information) => _$this._information = information;

  EventDtoBuilder();

  EventDtoBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _geometries = _$v.geometries;
      _sourceName = _$v.sourceName;
      _eventType = _$v.eventType;
      _eventSubtype = _$v.eventSubtype;
      _impactType = _$v.impactType;
      _impactSubtype = _$v.impactSubtype;
      _startTime = _$v.startTime;
      _endTime = _$v.endTime;
      _eventPriority = _$v.eventPriority;
      _description = _$v.description;
      _information = _$v.information;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EventDto other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$EventDto;
  }

  @override
  void update(void Function(EventDtoBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$EventDto build() {
    final _$result = _$v ??
        new _$EventDto._(
            id: id,
            geometries: geometries,
            sourceName: sourceName,
            eventType: eventType,
            eventSubtype: eventSubtype,
            impactType: impactType,
            impactSubtype: impactSubtype,
            startTime: startTime,
            endTime: endTime,
            eventPriority: eventPriority,
            description: description,
            information: information);
    replace(_$result);
    return _$result;
  }
}

class _$GeometryDto extends GeometryDto {
  @override
  final GeometryTypeDto type;
  @override
  final List<LatLng> coordinates;

  factory _$GeometryDto([void Function(GeometryDtoBuilder) updates]) =>
      (new GeometryDtoBuilder()..update(updates)).build();

  _$GeometryDto._({this.type, this.coordinates}) : super._() {
    if (type == null) {
      throw new BuiltValueNullFieldError('GeometryDto', 'type');
    }
    if (coordinates == null) {
      throw new BuiltValueNullFieldError('GeometryDto', 'coordinates');
    }
  }

  @override
  GeometryDto rebuild(void Function(GeometryDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GeometryDtoBuilder toBuilder() => new GeometryDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GeometryDto &&
        type == other.type &&
        coordinates == other.coordinates;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, type.hashCode), coordinates.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GeometryDto')
          ..add('type', type)
          ..add('coordinates', coordinates))
        .toString();
  }
}

class GeometryDtoBuilder implements Builder<GeometryDto, GeometryDtoBuilder> {
  _$GeometryDto _$v;

  GeometryTypeDto _type;
  GeometryTypeDto get type => _$this._type;
  set type(GeometryTypeDto type) => _$this._type = type;

  List<LatLng> _coordinates;
  List<LatLng> get coordinates => _$this._coordinates;
  set coordinates(List<LatLng> coordinates) =>
      _$this._coordinates = coordinates;

  GeometryDtoBuilder();

  GeometryDtoBuilder get _$this {
    if (_$v != null) {
      _type = _$v.type;
      _coordinates = _$v.coordinates;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GeometryDto other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$GeometryDto;
  }

  @override
  void update(void Function(GeometryDtoBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GeometryDto build() {
    final _$result =
        _$v ?? new _$GeometryDto._(type: type, coordinates: coordinates);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
