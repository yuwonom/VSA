/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:mqtt_client/mqtt_client.dart';
import 'package:vsa/features/map/state.dart';
import 'package:vsa/utility/gps_helper.dart';

class DetailsViewModel {
  final MapState _state;

  const DetailsViewModel(this._state) : assert(_state != null);

  bool get connectedToBroker => _state.connectionState == MqttConnectionState.connected;
  
  DateTime get startTime => _state.startTime;

  String get securityLevelText => connectedToBroker ? _state.securityLevel.toString() : "-";

  String get currentSpeedText => _state.userVehicle.point?.speed?.toStringAsFixed(2) ?? "0.0";

  String get averageSpeedText {
    if (!connectedToBroker) {
      return "-";
    }

    return _state.recordedPoints.isNotEmpty
      ? GpsHelper.averageSpeed(_state.recordedPoints.asList()).toStringAsFixed(2)
      : "0.0";
  }

  String get distanceText {
    if (!connectedToBroker) {
      return "-";
    }

    return _state.recordedPoints.isNotEmpty
      ? GpsHelper.totalDistance(_state.recordedPoints.asList()).toStringAsFixed(2)
      : "0.0";
  }

  String get accuracyText => _state.userVehicle.point?.accuracy?.toStringAsFixed(2) ?? "0";

  String getDurationDisplay() {
    final diff = DateTime.now().difference(startTime);
    final milliseconds = diff.inMilliseconds;

    final seconds = (milliseconds / 1000).truncate();
    final minutes = (seconds / 60).truncate();
    final hours = (minutes / 60).truncate();

    final ss = (seconds % 60).toStringAsFixed(0).padLeft(2, "0");
    final mm = (minutes % 60).toStringAsFixed(0).padLeft(2, "0");
    final hh = hours.toStringAsFixed(0).padLeft(2, "0");

    return "$hh:$mm:$ss";
  }
}