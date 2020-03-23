/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dtos.g.dart';

abstract class BrokerDto implements Built<BrokerDto, BrokerDtoBuilder> {
  factory BrokerDto([void updates(BrokerDtoBuilder b)]) = _$BrokerDto;

  BrokerDto._();

  String get address;
  String get port;
  String get username;
  String get password;

  static Serializer<BrokerDto> get serializer => _$brokerDtoSerializer;
}