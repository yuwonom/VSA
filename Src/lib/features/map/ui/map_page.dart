/// Authored by `@yuwonom (Michael Yuwono)`

import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:redux/redux.dart';
import 'package:vsa/features/map/actions.dart';
import 'package:vsa/features/map/dtos.dart';
import 'package:vsa/features/map/geolocator.dart';
import 'package:vsa/features/map/mqtt_api.dart';
import 'package:vsa/features/map/ui/details_bar.dart';
import 'package:vsa/features/map/viewmodels/details_viewmodel.dart';
import 'package:vsa/features/map/viewmodels/map_viewmodel.dart';
import 'package:vsa/features/settings/actions.dart';
import 'package:vsa/features/settings/ui/settings_page.dart';
import 'package:vsa/state.dart';
import 'package:vsa/themes/theme.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final double _defaultZoom = 18;
  final double _defaultBearing = 0;
  final double _defaultTilt = 45;

  GoogleMapController _mapController;
  double _direction;
  bool _isSticky;

  @override void initState() {
    super.initState();
    _direction = _defaultBearing;
    _isSticky = true;
  }

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, MapViewModel>(
      onInit: (Store<AppState> store) => store
        ..dispatch(ListenToGeolocator())
        ..dispatch(LoadSettings())
        ..dispatch(LoadIntersections()),
      converter: (Store<AppState> store) => MapViewModel(store.state.map, store.state.settings),
      builder: (BuildContext context, MapViewModel viewModel) => _buildPage(context, StoreProvider.of(context), viewModel),
    );
  
  Widget _buildPage(BuildContext context, Store<AppState> store, MapViewModel viewModel) {
    final map = GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanDown: (_) => setState(() => _isSticky = false),
      child: _buildMap(store, viewModel),
    );

    final actionButtons = Padding(
      padding: AppEdges.mediumAll,
      child: _buildActionButtons(store, viewModel)
    );
    
    final stack = Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        map,
        actionButtons,
      ],
    );

    final body = SafeArea(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          RepaintBoundary(child: stack),
          DetailsBar(DetailsViewModel(store.state.map)),
        ],
      ),
    );
    
    final settings = IconButton(
      icon: Icon(Icons.settings),
      color: AppColors.black,
      iconSize: 20.0,
      tooltip: "Settings",
      onPressed: viewModel.connectionState == MqttConnectionState.disconnected || viewModel.connectionState == MqttConnectionState.faulted
        ? () => Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsPage()))
        : null,
    );

    final appBar = AppBar(
      title: Text("VSA", style: AppTextStyles.header2.copyWith(color: AppColors.black)),
      backgroundColor: AppColors.white,
      brightness: Brightness.light,
      elevation: 0.0,
      actions: <Widget>[
        settings,
      ],
    );

    final scaffold = Scaffold(
      appBar: appBar,
      body: body,
    );

    return scaffold;
  }

  Widget _buildActionButtons(Store<AppState> store, MapViewModel viewModel) {
    Widget playButton;

    final VoidCallback connectCallback =
      () => store.dispatch(ConnectToMqttBroker(
          viewModel.address,
          viewModel.clientId,
          username: viewModel.username,
          password: viewModel.password,
        ));
    final VoidCallback disconnectCallback =
      () => store.dispatch(DisconnectFromMqttBroker());

    final loading = CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(AppColors.white),
    );

    switch (viewModel.connectionState) {
      case MqttConnectionState.connected:
        playButton = FloatingActionButton(
          heroTag: "playButton",
          backgroundColor: AppColors.blue,
          onPressed: disconnectCallback,
          child: Icon(Icons.stop, color: AppColors.white),
        );
      break;
      case MqttConnectionState.disconnected:
        playButton = FloatingActionButton(
          heroTag: "playButton",
          backgroundColor: AppColors.blue,
          onPressed: viewModel.hasUserPoint ? connectCallback : null,
          child: Icon(Icons.play_arrow, color: AppColors.white),
        );
      break;
      case MqttConnectionState.faulted:
        playButton = FloatingActionButton(
          heroTag: "playButton",
          backgroundColor: AppColors.blue,
          onPressed: connectCallback,
          child: Icon(Icons.play_arrow, color: AppColors.white),
        );
      break;
      default:
        playButton = FloatingActionButton(
          heroTag: "playButton",
          backgroundColor: AppColors.gray,
          onPressed: null,
          child: Padding(
            padding: AppEdges.smallAll,
            child: loading,
          ),
        );
    }

    const double iconSize = 50.0;
    Widget securityIndicatorIcon = Icon(
      Icons.signal_wifi_off,
      color: AppColors.gray,
      size: iconSize,
    );

    if (viewModel.connectionState == MqttConnectionState.connected) {
      switch (viewModel.securityLevel) {
        case (SecurityLevelDto.secured):
          securityIndicatorIcon = Icon(
            Icons.security,
            color: AppColors.green,
            size: iconSize,
          );
          break;
        case (SecurityLevelDto.controlled):
          securityIndicatorIcon = Icon(
            Icons.security,
            color: AppColors.lightGreen,
            size: iconSize,
          );
          break;
        case (SecurityLevelDto.cautious):
          securityIndicatorIcon = Icon(
            Icons.warning,
            color: AppColors.yellow,
            size: iconSize,
          );
          break;
        case (SecurityLevelDto.dangerous):
          securityIndicatorIcon = Icon(
            Icons.warning,
            color: AppColors.orange,
            size: iconSize,
          );
          break;
        case (SecurityLevelDto.critical):
          securityIndicatorIcon = Icon(
            Icons.warning,
            color: AppColors.red,
            size: iconSize,
          );
          break;
        case (SecurityLevelDto.unknown):
          securityIndicatorIcon = Icon(
            Icons.signal_wifi_off,
            color: AppColors.red,
            size: iconSize,
          );
          break;
      }
    }

    final securityIndicator = Tooltip(
      message: viewModel.securityLevel.toString(),
      child: Padding(
        padding: AppEdges.tinyHorizontal,
        child: securityIndicatorIcon,
      ),
    );

    final myLocation = FloatingActionButton(
      heroTag: "myLocationButton",
      backgroundColor: AppColors.white,
      onPressed: () => _animateMapCamera(viewModel.userPoint)
          .then((_) => Future.delayed(const Duration(seconds: 1)))
          .then((_) => setState(() => _isSticky = true)),
      child: Icon(Icons.my_location, color: AppColors.black),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        securityIndicator,
        playButton,
        Visibility(
          visible: !_isSticky && viewModel.hasUserPoint,
          replacement: const SizedBox(width: 56.0),
          child: myLocation,
        ),
      ],
    );
  }

  Widget _buildMap(Store<AppState> store, MapViewModel viewModel) {
    final markers = Set<Marker>();
    final circles = Set<Circle>();

    if (viewModel.hasUserPoint) {
      _buildVehicleMarker(viewModel.userVehicle, true)
        ..then((Marker marker) => setState(() => markers.add(marker)));
      
      final userAccuracyCircle = _buildAccuracyCircle(viewModel.userVehicle, true);
      circles.add(userAccuracyCircle);
    }

    if (viewModel.hasOtherVehicles) {
      viewModel.otherVehicles.values.forEach((VehicleDto other) {
        _buildVehicleMarker(other, false)
          ..then((Marker marker) => setState(() => markers.add(marker)));

        final otherAccuracyCircle = _buildAccuracyCircle(other, false);
        circles.add(otherAccuracyCircle);
      });
    }

    if (viewModel.hasIntersections) {
      viewModel.intersections.forEach((IntersectionDto intersection) {
        final intersectionCircle = _buildIntersectionCircle(intersection);
        circles.add(intersectionCircle);
      });
    }
    
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: viewModel.userPoint,
        zoom: _defaultZoom,
        bearing: _defaultBearing,
        tilt: _defaultTilt,
      ),
      onMapCreated: (GoogleMapController controller) {
        _mapController = controller;

        FlutterCompass.events.listen((double direction) {
          setState(() => _direction = direction);
          _stickMap(store);

          final mapState = store.state.map;
          final settingsState = store.state.settings;
          
          if (mapState.connectionState == MqttConnectionState.connected) {
            final topic = "${settingsState.statusPublishTopic}/${settingsState.broker.clientId}";
            final message = MqttApi.statusMessage(
              mapState.userVehicle.id,
              mapState.userVehicle.point.rebuild((b) => b
                ..heading = _direction
                ..dateTime = DateTime.now().toUtc()),
            );
            store.dispatch(PublishMessageToMqttBroker(topic, message));
          }
        });

        Geolocator.instance.events.listen((GpsPointDto point) {
          store.dispatch(UpdateUserGpsPoint(point));
          _stickMap(store);
        });
      },
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
          Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer()),
        ].toSet(),
      mapType: MapType.normal,
      markers: markers,
      circles: circles,
      compassEnabled: false,
      myLocationEnabled: false,
      myLocationButtonEnabled: false,
      tiltGesturesEnabled: false,
    );
  }

  Future<Marker> _buildVehicleMarker(VehicleDto vehicle, bool isUser) async {
    final iconPath = "assets/images/vehicles/";
    final iconType = vehicle.type.toString();
    final iconFor = isUser ? "self" : "other";
    final icon = BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "$iconPath${iconType}_$iconFor.png",
    );

    final marker = Marker(
      markerId: MarkerId(vehicle.id),
      flat: true,
      rotation: isUser ? _direction : vehicle.point.heading,
      position: vehicle.point.toLatLng(),
      icon: await icon,
      anchor: const Offset(0.5, 0.5),
      zIndex: isUser
        ? MapViewModel.USER_ACCURACY_ZINDEX.toDouble()
        : MapViewModel.OTHER_ACCURACY_ZINDEX.toDouble(),
    );

    return marker;
  }

  Circle _buildAccuracyCircle(VehicleDto vehicle, bool isUser) => Circle(
      circleId: CircleId("Accuracy_${vehicle.id}"),
      center: vehicle.point.toLatLng(),
      radius: vehicle.point.accuracy,
      fillColor: isUser ? AppColors.blue.withAlpha(100) : AppColors.red.withAlpha(100),
      strokeWidth: 1,
      strokeColor: AppColors.white,
      zIndex: isUser
        ? MapViewModel.USER_ACCURACY_ZINDEX
        : MapViewModel.OTHER_ACCURACY_ZINDEX,
    );
  
  Circle _buildIntersectionCircle(IntersectionDto intersection) => Circle(
      circleId: CircleId("Intersection_${intersection.id}"),
      center: intersection.latLng,
      radius: intersection.radius,
      fillColor: AppColors.darkGray.withAlpha(100),
      strokeWidth: 10,
      strokeColor: AppColors.white,
      zIndex: MapViewModel.INTERSECTION_ZINDEX,
    );

  Future<void> _animateMapCamera(LatLng point) async {
    if (_mapController == null || point == null) {
      return;
    }

    await _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: point,
          zoom: _defaultZoom,
          bearing: _direction,
          tilt: _defaultTilt,
        ),
      ),
    );
  }

  void _stickMap(Store<AppState> store) {
    final point = store.state.map.userVehicle.point;

    if (!_isSticky || point == null || _mapController == null) {
      return;
    }

    _mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: point.toLatLng(),
          zoom: _defaultZoom,
          bearing: _direction,
          tilt: _defaultTilt,
        ),
      ),
    );
  }
}