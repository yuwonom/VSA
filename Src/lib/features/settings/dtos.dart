/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:built_collection/built_collection.dart';
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

class TopicLevelDto extends EnumClass {
  static const TopicLevelDto levelA = _$levelA;
  static const TopicLevelDto levelB = _$levelB;
  static const TopicLevelDto levelC = _$levelC;

  const TopicLevelDto._(String name) : super(name);

  static Serializer<TopicLevelDto> get serializer => _$topicLevelDtoSerializer;

  static BuiltSet<TopicLevelDto> get values => _$topicLevelDtoValues;
  static TopicLevelDto valueOf(String name) => _$topicLevelDtoValueOf(name);
}