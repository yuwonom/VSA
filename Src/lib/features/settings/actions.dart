/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:flutter/material.dart';

@immutable
class LoadSettings {
  @override
  String toString() => "LoadSettings";
}

@immutable
class LoadSettingsSuccessful {
  @override
  String toString() => "LoadSettingsSuccessful";
}

@immutable
class UpdateSettings {
  UpdateSettings(
    this.actionType,
    this.value,
  ) : assert (actionType != null && value != null);

  final Type actionType;
  final Object value;

  @override
  String toString() => "UpdateSettings $actionType, $value";
}

@immutable
class UpdateVehicleId {
  UpdateVehicleId(this.value) : assert (value != null);

  final String value;
  
  @override
  String toString() => "UpdateVehicleId $value";
}

@immutable
class UpdateVehicleName {
  UpdateVehicleName(this.value) : assert (value != null);

  final String value;
  
  @override
  String toString() => "UpdateVehicleName $value";
}

@immutable
class UpdateVehicleType {
  UpdateVehicleType(this.value) : assert (value != null);

  final String value;
  
  @override
  String toString() => "UpdateVehicleType $value";
}

@immutable
class UpdateDimension {
  UpdateDimension(this.value) : assert (value != null);

  final String value;
  
  @override
  String toString() => "UpdateDimension $value";
}

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
class SwitchLevelA {
  SwitchLevelA(this.value) : assert (value != null);

  final bool value;
  
  @override
  String toString() => "SwitchLevelA $value";
}

@immutable
class SwitchLevelB {
  SwitchLevelB(this.value) : assert (value != null);

  final bool value;
  
  @override
  String toString() => "SwitchLevelB $value";
}

@immutable
class SwitchLevelC {
  SwitchLevelC(this.value) : assert (value != null);

  final bool value;
  
  @override
  String toString() => "SwitchLevelC $value";
}

@immutable
class SwitchLevelD {
  SwitchLevelD(this.value) : assert (value != null);

  final bool value;
  
  @override
  String toString() => "SwitchLevelD $value";
}

class SwitchBasicVehicle {
  SwitchBasicVehicle(this.value) : assert (value != null);

  final bool value;
  
  @override
  String toString() => "SwitchBasicVehicle $value";
}

@immutable
class SwitchBasicTraffic {
  SwitchBasicTraffic(this.value) : assert (value != null);

  final bool value;
  
  @override
  String toString() => "SwitchBasicTraffic $value";
}

@immutable
class UpdateLevelAPropertiesPublishTopic {
  UpdateLevelAPropertiesPublishTopic(this.value) : assert (value != null);

  final String value;
  
  @override
  String toString() => "UpdateLevelAPropertiesPublishTopic $value";
}

@immutable
class UpdateLevelAStatusPublishTopic {
  UpdateLevelAStatusPublishTopic(this.value) : assert (value != null);

  final String value;
  
  @override
  String toString() => "UpdateLevelAStatusPublishTopic $value";
}

@immutable
class UpdateLevelAIntersectionSubscribeTopic {
  UpdateLevelAIntersectionSubscribeTopic(this.value) : assert (value != null);

  final String value;
  
  @override
  String toString() => "UpdateLevelAIntersectionSubscribeTopic $value";
}

@immutable
class UpdatePropertiesPublishTopic {
  UpdatePropertiesPublishTopic(this.value) : assert (value != null);

  final String value;
  
  @override
  String toString() => "UpdatePropertiesPublishTopic $value";
}

@immutable
class UpdateStatusPublishTopic {
  UpdateStatusPublishTopic(this.value) : assert (value != null);

  final String value;
  
  @override
  String toString() => "UpdateStatusPublishTopic $value";
}

@immutable
class UpdatePropertiesRequestPublishTopic {
  UpdatePropertiesRequestPublishTopic(this.value) : assert (value != null);

  final String value;
  
  @override
  String toString() => "UpdatePropertiesRequestPublishTopic $value";
}

@immutable
class UpdatePropertiesRequestSubscribeTopic {
  UpdatePropertiesRequestSubscribeTopic(this.value) : assert (value != null);

  final String value;
  
  @override
  String toString() => "UpdatePropertiesRequestSubscribeTopic $value";
}

@immutable
class UpdateStatusRequestPublishTopic {
  UpdateStatusRequestPublishTopic(this.value) : assert (value != null);

  final String value;
  
  @override
  String toString() => "UpdateStatusRequestPublishTopic $value";
}

@immutable
class UpdateStatusRequestSubscribeTopic {
  UpdateStatusRequestSubscribeTopic(this.value) : assert (value != null);

  final String value;
  
  @override
  String toString() => "UpdateStatusRequestSubscribeTopic $value";
}

@immutable
class UpdateTrafficRequestPublishTopic {
  UpdateTrafficRequestPublishTopic(this.value) : assert (value != null);

  final String value;
  
  @override
  String toString() => "UpdateTrafficRequestPublishTopic $value";
}

@immutable
class UpdateTrafficRequestSubscribeTopic {
  UpdateTrafficRequestSubscribeTopic(this.value) : assert (value != null);

  final String value;
  
  @override
  String toString() => "UpdateTrafficRequestSubscribeTopic $value";
}