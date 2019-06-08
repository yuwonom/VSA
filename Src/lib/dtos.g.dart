// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dtos.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<DateDto> _$dateDtoSerializer = new _$DateDtoSerializer();

class _$DateDtoSerializer implements StructuredSerializer<DateDto> {
  @override
  final Iterable<Type> types = const [DateDto, _$DateDto];
  @override
  final String wireName = 'DateDto';

  @override
  Iterable serialize(Serializers serializers, DateDto object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'year',
      serializers.serialize(object.year, specifiedType: const FullType(int)),
      'month',
      serializers.serialize(object.month, specifiedType: const FullType(int)),
      'day',
      serializers.serialize(object.day, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  DateDto deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DateDtoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'year':
          result.year = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'month':
          result.month = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'day':
          result.day = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$DateDto extends DateDto {
  @override
  final int year;
  @override
  final int month;
  @override
  final int day;

  factory _$DateDto([void updates(DateDtoBuilder b)]) =>
      (new DateDtoBuilder()..update(updates)).build();

  _$DateDto._({this.year, this.month, this.day}) : super._() {
    if (year == null) {
      throw new BuiltValueNullFieldError('DateDto', 'year');
    }
    if (month == null) {
      throw new BuiltValueNullFieldError('DateDto', 'month');
    }
    if (day == null) {
      throw new BuiltValueNullFieldError('DateDto', 'day');
    }
  }

  @override
  DateDto rebuild(void updates(DateDtoBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  DateDtoBuilder toBuilder() => new DateDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DateDto &&
        year == other.year &&
        month == other.month &&
        day == other.day;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, year.hashCode), month.hashCode), day.hashCode));
  }
}

class DateDtoBuilder implements Builder<DateDto, DateDtoBuilder> {
  _$DateDto _$v;

  int _year;
  int get year => _$this._year;
  set year(int year) => _$this._year = year;

  int _month;
  int get month => _$this._month;
  set month(int month) => _$this._month = month;

  int _day;
  int get day => _$this._day;
  set day(int day) => _$this._day = day;

  DateDtoBuilder();

  DateDtoBuilder get _$this {
    if (_$v != null) {
      _year = _$v.year;
      _month = _$v.month;
      _day = _$v.day;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DateDto other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$DateDto;
  }

  @override
  void update(void updates(DateDtoBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$DateDto build() {
    final _$result = _$v ?? new _$DateDto._(year: year, month: month, day: day);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
