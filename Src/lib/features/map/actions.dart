/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:built_collection/built_collection.dart';
import 'package:meta/meta.dart';
import 'package:vsa/features/map/dtos.dart';
import 'package:vsa/utility/action_exception.dart';

@immutable
class ListenToGeolocator {
  @override
  String toString() => "ListenToGeolocator";
}

@immutable
class UpdateUserGpsPoint {
  UpdateUserGpsPoint(this.point) : assert (point != null);

  final GpsPointDto point;
  
  @override
  String toString() => "UpdateUserGpsPoint $point";
}

@immutable
class RecordUserGpsPoint {
  RecordUserGpsPoint(this.point) : assert (point != null);

  final GpsPointDto point;
  
  @override
  String toString() => "RecordUserGpsPoint $point";
}

@immutable
class ConnectToMqttBroker {
  ConnectToMqttBroker(
    this.server,
    this.clientId, {
    this.username,
    this.password,
  }) : assert (server != null && clientId != null);

  final String server;
  final String clientId;
  final String username;
  final String password;

  @override
  String toString() => "ConnectToMqttBroker $server, $clientId, $username, $password";
}

@immutable
class ConnectToMqttBrokerSuccessful {
  @override
  String toString() => "ConnectToMqttBrokerSuccessful";
}

@immutable
class ConnectToMqttBrokerFailed {
  ConnectToMqttBrokerFailed(this.exception) : assert (exception != null);

  final ActionException exception;

  @override
  String toString() => "ConnectToMqttBrokerFailed $exception";
}

@immutable
class DisconnectFromMqttBroker {
  @override
  String toString() => "DisconnectFromMqttBroker";
}

@immutable
class ListenToMqttBroker {
  @override
  String toString() => "ListenToMqttBroker";
}

@immutable
class PublishMessageToMqttBroker {
  PublishMessageToMqttBroker(
    this.topic,
    this.message,
  ) : assert (topic != null && message != null);

  final String topic;
  final String message;

  @override
  String toString() => "PublishMessageToMqttBroker $topic, $message";
}

@immutable
class PublishMessageToMqttBrokerSuccessful {
  @override
  String toString() => "PublishMessageToMqttBrokerSuccessful";
}

@immutable
class PublishMessageToMqttBrokerFailed {
  PublishMessageToMqttBrokerFailed(this.exception) : assert (exception != null);

  final ActionException exception;

  @override
  String toString() => "PublishMessageToMqttBrokerFailed $exception";
}

@immutable
class UpdateOtherVehiclesStatus {
  UpdateOtherVehiclesStatus(this.map) : assert (map != null);

  final BuiltMap<String, VehicleDto> map;
  
  @override
  String toString() => "UpdateOtherVehiclesStatus $map";
}

@immutable
class UpdateOtherVehiclesProperties {
  UpdateOtherVehiclesProperties(this.map) : assert (map != null);

  final BuiltMap<String, VehicleDto> map;
  
  @override
  String toString() => "UpdateOtherVehiclesProperties $map";
}