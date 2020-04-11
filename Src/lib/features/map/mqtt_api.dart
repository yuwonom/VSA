/// Authored by `@yuwonom (Michael Yuwono)`

import 'dart:async';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:vsa/features/map/dtos.dart';

class MqttApi {
  static MqttApi _instance;
  static MqttApi get instance {
    if (_instance == null) {
      _instance = MqttApi._();
    }
    return _instance;
  }

  static MqttClient _client;
  static StreamController<MqttMessage> _controller;

  MqttApi._() : this._subscribedTopics = [];

  final List<String> _subscribedTopics;

  bool _isSubscribed(String topic) => _subscribedTopics.contains(topic);

  Future<bool> connect(String server, String clientId, String username, String password) async {
    // Disconnect any ongoing connection
    this.disconnect();

    _client = MqttClient(server, clientId);
    _client.onSubscribed = (topic) => _subscribedTopics.add(topic);
    _client.onUnsubscribed = (topic) => _subscribedTopics.remove(topic);
    final status = await _client.connect(username, password);
    
    return status.state == MqttConnectionState.connected;
  }

  void disconnect() {
    if (_client?.connectionStatus?.state != MqttConnectionState.disconnected) {
      _client?.disconnect();
      _subscribedTopics.clear();
    }
  }

  Stream<MqttMessage> getDataStream() {
    _controller?.close();
    _controller = StreamController<MqttMessage>();

    _client.updates.listen((List<MqttReceivedMessage<MqttMessage>> list) => _controller.add(list.first.payload));

    return _controller.stream;
  }

  void publish(String topic, String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    
    _client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload);
  }

  void subscribe(List<String> topics) => topics.forEach((topic) {
      if (_isSubscribed(topic)) {
        return;
      }
      _client.subscribe(topic, MqttQos.exactlyOnce);
    });

  void unsubscribe(List<String> topics) => topics.forEach((topic) {
      if (!_isSubscribed(topic)) {
        return;
      }
      _client.unsubscribe(topic);
    });

  static String propertiesMessage(String id, String name, VehicleTypeDto type, VehicleDimensionDto dimension) => "$id,$name,${type.toString()},${dimension.toString()}";

  static String statusMessage(String id, GpsPointDto point) => "$id,${point.latitude},${point.longitude},${point.speed.toStringAsFixed(2)},${point.accuracy.toStringAsFixed(2)},${point.heading.toStringAsFixed(2)},${point.dateTime}";
  
  static String propertiesRequestMessage(List<String> ids) => ids.join(",");

  static String statusRequestMessage(String id, int radius) => "$id,$radius";
}