/// Authored by `@yuwonom (Michael Yuwono)`

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:redux/redux.dart';
import 'package:vsa/features/map/actions.dart';
import 'package:vsa/features/map/dtos.dart';
import 'package:vsa/features/map/geolocator.dart';
import 'package:vsa/features/map/ui/user_identifier_dialog.dart';
import 'package:vsa/features/map/viewmodels/map_viewmodel.dart';
import 'package:vsa/state.dart';
import 'package:vsa/themes/theme.dart';

class MapMinimalPage extends StatefulWidget {
  @override
  _MapMinimalPageState createState() => _MapMinimalPageState();
}

class _MapMinimalPageState extends State<MapMinimalPage> {
  final double _defaultZoom = 20;
  final double _defaultBearing = 0;
  final double _defaultTilt = 0;

  GoogleMapController _mapController;
  StreamSubscription<double> _directionStream;
  StreamSubscription<GpsPointDto> _gpsPointStream;

  double _direction;

  @override
  void initState() {
    super.initState();
    _direction = _defaultBearing;
  }

  @override
  void dispose() {
    super.dispose();
    Geolocator.instance.resetController();
    _directionStream?.cancel();
    _gpsPointStream?.cancel();
  }

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, MapViewModel>(
      converter: (Store<AppState> store) => MapViewModel(store.state.map, store.state.settings),
      builder: (BuildContext context, MapViewModel viewModel) => viewModel.userVehicle.type == VehicleTypeDto.car
        ? _buildCarPage(context, StoreProvider.of(context), viewModel)
        : _buildCyclePage(context, StoreProvider.of(context), viewModel),
    );

  Widget _buildCyclePage(BuildContext context, Store<AppState> store, MapViewModel viewModel) {
    return Container();
  }
    
  Widget _buildCarPage(BuildContext context, Store<AppState> store, MapViewModel viewModel) {
    final map = AbsorbPointer(
      absorbing: true,
      child: _buildMap(store, viewModel),
    );

    final actionButtons = Padding(
      padding: AppEdges.mediumAll,
      child: _buildActionButtons(store, viewModel),
    );

    final topView = _buildTopBar(viewModel);

    final bottomView = Wrap(
      alignment: WrapAlignment.center,
      children: <Widget>[
        actionButtons,
        _buildBottomBar(viewModel),
      ],
    );

    final page = Stack(
      children: <Widget>[
        map,
        Align(
          alignment: Alignment.topCenter,
          child: topView,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: bottomView,
        ),
      ],
    );

    return page;
  }

  Widget _buildActionButtons(Store<AppState> store, MapViewModel viewModel) {
    Widget playButton;

    final VoidCallback connectCallback = () {
      if (viewModel.userVehicle.id.isEmpty) {
        showDialog(
          context: context,
          builder: (_) => UserIdentifierDialog(viewModel.broker),
        );
        return;
      }

      store.dispatch(ConnectToMqttBroker(
        viewModel.address,
        viewModel.userVehicle.id,
        username: viewModel.username,
        password: viewModel.password,
      ));
    };

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

    return playButton;
  }

  Widget _buildTopBar(MapViewModel viewModel) {
    Color barColor = AppColors.gray;
    Color textColor = AppColors.darkGray;
    String text = "Not connected to any broker service.\nPress start to connect.";

    if (viewModel.connectionState == MqttConnectionState.connected) {
      textColor = AppColors.white;
      switch (viewModel.securityLevel) {
        case (SecurityLevelDto.secured):
          barColor = AppColors.green;
          text = "Connected to broker service.\nPlease drive safely";
          break;
        case (SecurityLevelDto.controlled):
          barColor = AppColors.lightGreen;
          text = "Connected to broker service.\nPlease drive safely";
          break;
        case (SecurityLevelDto.cautious):
          barColor = AppColors.yellow;
          text = "There's a bike approaching.\nPlease drive with cautious.";
          break;
        case (SecurityLevelDto.dangerous):
          barColor = AppColors.orange;
          text = "Warning! Possible collision detected.";
          break;
        case (SecurityLevelDto.critical):
          barColor = AppColors.red;
          text = "Warning! Possible collision detected.";
          break;
        case (SecurityLevelDto.unknown):
          barColor = AppColors.gray;
          textColor = AppColors.darkGray;
          text = "Unknown security level.";
          break;
      }
    } else if (viewModel.connectionState == MqttConnectionState.connecting) {
      barColor = AppColors.gray;
      textColor = AppColors.darkGray;
      text = "Connecting...";
    } else if (viewModel.connectionState == MqttConnectionState.disconnecting) {
      barColor = AppColors.gray;
      textColor = AppColors.darkGray;
      text = "Disconnecting...";
    }

    final topBar = Container(
      color: barColor,
      padding: AppEdges.mediumAll,
      width: MediaQuery.of(context).size.width,
      child: Text(
        text,
        style: AppTextStyles.body1.copyWith(color: textColor),
        textAlign: TextAlign.center,
      ),
    );

    return topBar;
  }

  Widget _buildBottomBar(MapViewModel viewModel) {
    final inIntersectionText = Wrap(
      children: <Widget>[
        Text("You are currently in intersection ",
          style: AppTextStyles.body1.copyWith(color: AppColors.black)),
        Text("#${viewModel.currentIntersectionId}",
          style: AppTextStyles.body1.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );

    final totalVehicles = Text(
      "Found ${viewModel.otherVehicles.length} vehicles",
      style: AppTextStyles.body1.copyWith(color: AppColors.black),
    );

    final noIntersectionText = Text(
      "You are not currently within any intersection",
      style: AppTextStyles.body2.copyWith(color: AppColors.black),
    );

    final intersectionText = viewModel.currentIntersectionId != null
      ? Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            inIntersectionText,
            SizedBox(height: AppLengths.tiny),
            totalVehicles,
          ],
        )
      : noIntersectionText;

    final bottomBar = Container(
      color: AppColors.white,
      padding: AppEdges.mediumAll,
      width: MediaQuery.of(context).size.width,
      child: intersectionText,
    );

    return bottomBar;
  }

  Widget _buildMap(Store<AppState> store, MapViewModel viewModel) {
    final markers = Set<Marker>();

    if (viewModel.hasUserPoint) {
      _buildVehicleMarker(viewModel.userVehicle, true)
        ..then((Marker marker) => setState(() => markers.add(marker)));
    }

    if (viewModel.hasOtherVehicles) {
      viewModel.otherVehicles.values.forEach((VehicleDto other) {
        _buildVehicleMarker(other, false)
          ..then((Marker marker) => setState(() => markers.add(marker)));
      });
    }
    
    final map = GoogleMap(
      initialCameraPosition: CameraPosition(
        target: viewModel.userPoint,
        zoom: _defaultZoom,
        bearing: _defaultBearing,
        tilt: _defaultTilt,
      ),
      onMapCreated: (GoogleMapController controller) {
        _mapController = controller;
        rootBundle
          .loadString("assets/files/simple_map_style.txt")
          .then((String style) => _mapController.setMapStyle(style));

        _directionStream = FlutterCompass.events
          .listen((double direction) {
              setState(() => _direction = direction);

              final userVehicle = store.state.map.userVehicle;

              if (userVehicle.point == null) {
                return;
              }

              final point = userVehicle.point
                .rebuild((b) => b
                  ..heading = _direction
                  ..dateTime = DateTime.now().toUtc());
              store.dispatch(UpdateUserGpsPoint(point));
              
              _stickMap(point);
            },
            cancelOnError: true,
          );

        _gpsPointStream = Geolocator.instance
          .getEvents()
          .listen((GpsPointDto point) {
              store.dispatch(UpdateUserGpsPoint(point));
              _stickMap(point);
            },
            cancelOnError: true,
          );
      },
      mapType: MapType.normal,
      markers: markers,
      compassEnabled: false,
      myLocationEnabled: false,
      myLocationButtonEnabled: false,
      tiltGesturesEnabled: false,
    );

    return map;
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

  void _stickMap(GpsPointDto point) {
    if (point == null || _mapController == null) {
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