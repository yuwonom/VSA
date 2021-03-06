/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:built_collection/built_collection.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:vsa/features/map/dtos.dart';
import 'package:vsa/features/map/state.dart';
import 'package:vsa/features/settings/dtos.dart';
import 'package:vsa/features/settings/state.dart';
import 'package:vsa/utility/gps_helper.dart';

class MapViewModel {
  static const LatLng BRISBANE_LATLNG = const LatLng(-27.4698, 153.0251);
  
  static const int USER_VEHICLE_ZINDEX = 7;
  static const int OTHER_VEHICLE_ZINDEX = 6;
  static const int SECURITY_LINE_ZINDEX = 5;
  static const int USER_ACCURACY_ZINDEX = 4;
  static const int OTHER_ACCURACY_ZINDEX = 3;
  static const int TRAFFIC_ZINDEX = 2;
  static const int INTERSECTION_ZINDEX = 1;

  final MapState _mapState;
  final SettingsState _settingsState;

  const MapViewModel(this._mapState, this._settingsState)
    : assert(_mapState != null && _settingsState != null);

  VehicleDto get userVehicle => _mapState.userVehicle;

  LatLng get userPoint => hasUserPoint
    ? userVehicle.point.toLatLng()
    : BRISBANE_LATLNG;

  LatLng get userSecurityPoint => hasUserPoint
    ? userVehicle.securityPoint.toLatLng()
    : BRISBANE_LATLNG;

  MqttConnectionState get connectionState => _mapState.connectionState;

  SecurityLevelDto get securityLevel => _mapState.securityLevel;

  bool get hasUserPoint => _mapState.userVehicle.point != null;

  BuiltMap<String, VehicleDto> get otherVehicles => _mapState.otherVehicles;
  
  bool get hasOtherVehicles => otherVehicles.isNotEmpty;

  String get closestOtherVehicleId => _mapState.closestOtherVehicleId;

  LatLng get closestOtherVehiclePoint => otherVehicles[closestOtherVehicleId].point.toLatLng();

  BuiltList<IntersectionDto> get intersections => _mapState.intersections;

  bool get hasIntersections => intersections.isNotEmpty;

  String get currentIntersectionId => _mapState.currentIntersectionId;

  double get distanceFromIntersection => currentIntersectionId == null ? double.infinity
    : GpsHelper.distance(
        _mapState.userVehicle.point,
        GpsPointDto.fromLatLng(intersections
          .firstWhere((intersection) => intersection.id == currentIntersectionId)
          .latLng));
  
  double get distanceFromIntersectionPixels => meterToPixels(distanceFromIntersection);

  BrokerDto get broker => _settingsState.broker;

  String get address => broker.address;
  String get port => broker.port;
  String get username => broker.username;
  String get password => broker.password;

  double meterToPixels(double meters) => meters * 10;
}