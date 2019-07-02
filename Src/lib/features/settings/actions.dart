/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:flutter/material.dart';

@immutable
class UpdateBrokerAddress {
  UpdateBrokerAddress(this.value) : assert (value != null);

  final String value;
  
  @override
  String toString() => "UpdateBrokerAddress $value";
}

@immutable
class UpdateBrokerPort {
  UpdateBrokerPort(this.value) : assert (value != null);

  final String value;
  
  @override
  String toString() => "UpdateBrokerPort $value";
}

@immutable
class UpdateBrokerUsername {
  UpdateBrokerUsername(this.value) : assert (value != null);

  final String value;
  
  @override
  String toString() => "UpdateBrokerUsername $value";
}

@immutable
class UpdateBrokerPassword {
  UpdateBrokerPassword(this.value) : assert (value != null);

  final String value;
  
  @override
  String toString() => "UpdateBrokerPassword $value";
}

@immutable
class UpdateBrokerClientId {
  UpdateBrokerClientId(this.value) : assert (value != null);

  final String value;
  
  @override
  String toString() => "UpdateBrokerClientId $value";
}