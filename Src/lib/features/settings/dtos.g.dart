// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dtos.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TopicLevelDto _$levelA = const TopicLevelDto._('levelA');
const TopicLevelDto _$levelB = const TopicLevelDto._('levelB');
const TopicLevelDto _$levelC = const TopicLevelDto._('levelC');

TopicLevelDto _$topicLevelDtoValueOf(String name) {
  switch (name) {
    case 'levelA':
      return _$levelA;
    case 'levelB':
      return _$levelB;
    case 'levelC':
      return _$levelC;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<TopicLevelDto> _$topicLevelDtoValues =
    new BuiltSet<TopicLevelDto>(const <TopicLevelDto>[
  _$levelA,
  _$levelB,
  _$levelC,
]);

Serializer<BrokerDto> _$brokerDtoSerializer = new _$BrokerDtoSerializer();
Serializer<TopicLevelDto> _$topicLevelDtoSerializer =
    new _$TopicLevelDtoSerializer();

class _$BrokerDtoSerializer implements StructuredSerializer<BrokerDto> {
  @override
  final Iterable<Type> types = const [BrokerDto, _$BrokerDto];
  @override
  final String wireName = 'BrokerDto';

  @override
  Iterable<Object> serialize(Serializers serializers, BrokerDto object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'address',
      serializers.serialize(object.address,
          specifiedType: const FullType(String)),
      'port',
      serializers.serialize(object.port, specifiedType: const FullType(String)),
      'username',
      serializers.serialize(object.username,
          specifiedType: const FullType(String)),
      'password',
      serializers.serialize(object.password,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  BrokerDto deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BrokerDtoBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'address':
          result.address = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'port':
          result.port = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'username':
          result.username = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'password':
          result.password = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$TopicLevelDtoSerializer implements PrimitiveSerializer<TopicLevelDto> {
  @override
  final Iterable<Type> types = const <Type>[TopicLevelDto];
  @override
  final String wireName = 'TopicLevelDto';

  @override
  Object serialize(Serializers serializers, TopicLevelDto object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  TopicLevelDto deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TopicLevelDto.valueOf(serialized as String);
}

class _$BrokerDto extends BrokerDto {
  @override
  final String address;
  @override
  final String port;
  @override
  final String username;
  @override
  final String password;

  factory _$BrokerDto([void Function(BrokerDtoBuilder) updates]) =>
      (new BrokerDtoBuilder()..update(updates)).build();

  _$BrokerDto._({this.address, this.port, this.username, this.password})
      : super._() {
    if (address == null) {
      throw new BuiltValueNullFieldError('BrokerDto', 'address');
    }
    if (port == null) {
      throw new BuiltValueNullFieldError('BrokerDto', 'port');
    }
    if (username == null) {
      throw new BuiltValueNullFieldError('BrokerDto', 'username');
    }
    if (password == null) {
      throw new BuiltValueNullFieldError('BrokerDto', 'password');
    }
  }

  @override
  BrokerDto rebuild(void Function(BrokerDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BrokerDtoBuilder toBuilder() => new BrokerDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BrokerDto &&
        address == other.address &&
        port == other.port &&
        username == other.username &&
        password == other.password;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, address.hashCode), port.hashCode), username.hashCode),
        password.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BrokerDto')
          ..add('address', address)
          ..add('port', port)
          ..add('username', username)
          ..add('password', password))
        .toString();
  }
}

class BrokerDtoBuilder implements Builder<BrokerDto, BrokerDtoBuilder> {
  _$BrokerDto _$v;

  String _address;
  String get address => _$this._address;
  set address(String address) => _$this._address = address;

  String _port;
  String get port => _$this._port;
  set port(String port) => _$this._port = port;

  String _username;
  String get username => _$this._username;
  set username(String username) => _$this._username = username;

  String _password;
  String get password => _$this._password;
  set password(String password) => _$this._password = password;

  BrokerDtoBuilder();

  BrokerDtoBuilder get _$this {
    if (_$v != null) {
      _address = _$v.address;
      _port = _$v.port;
      _username = _$v.username;
      _password = _$v.password;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BrokerDto other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BrokerDto;
  }

  @override
  void update(void Function(BrokerDtoBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BrokerDto build() {
    final _$result = _$v ??
        new _$BrokerDto._(
            address: address,
            port: port,
            username: username,
            password: password);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
