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
import 'package:vsa/features/map/ui/user_identifier_dialog.dart';
import 'package:vsa/features/map/viewmodels/details_viewmodel.dart';
import 'package:vsa/features/map/viewmodels/map_viewmodel.dart';
import 'package:vsa/state.dart';
import 'package:vsa/themes/theme.dart';
import 'package:vsa/utility/geolocator.dart';

class MapNormalPage extends StatefulWidget {
  @override
  _MapNormalPageState createState() => _MapNormalPageState();
}

class _MapNormalPageState extends State<MapNormalPage> {
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
      builder: (BuildContext context, MapViewModel viewModel) => _buildPage(context, StoreProvider.of(context), viewModel),
    );
    
  Widget _buildPage(BuildContext context, Store<AppState> store, MapViewModel viewModel) {
    final map = AbsorbPointer(
      absorbing: true,
      child: _buildMap(store, viewModel),
    );

    final topView = Align(
      alignment: Alignment.topCenter,
      child: _buildTopBar(viewModel),
    );

    final bottomView = Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSpeedIndicator(viewModel),
          _buildBottomBar(store, viewModel),
        ]
      ),
    );

    final page = Stack(
      children: <Widget>[
        map,
        topView,
        bottomView,
      ],
    );

    return page;
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
          text = "Connected to broker service.\nPlease drive safely.";
          break;
        case (SecurityLevelDto.controlled):
          barColor = AppColors.lightGreen;
          text = "Connected to broker service.\nPlease drive safely.";
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

  Widget _buildBottomBar(Store<AppState> store, MapViewModel viewModel) {
    final inIntersectionText = Wrap(
      children: <Widget>[
        Text("You are currently in intersection ",
          style: AppTextStyles.body2.copyWith(color: AppColors.black)),
        Text("#${viewModel.currentIntersectionId}",
          style: AppTextStyles.body2.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );

    final totalVehicles = Text(
      "Found ${viewModel.otherVehicles.length} active vehicles",
      style: AppTextStyles.body2.copyWith(color: AppColors.black),
    );

    final noIntersectionText = Text(
      "You are not currently within any intersection",
      style: AppTextStyles.body2.copyWith(color: AppColors.black),
    );

    final intersectionText = viewModel.currentIntersectionId != null
      ? Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            inIntersectionText,
            SizedBox(height: AppLengths.tiny),
            totalVehicles,
          ],
        )
      : noIntersectionText;
    
    final contents = Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(child: intersectionText),
        SizedBox(width: AppLengths.small),
        _buildPlayButton(context, store, viewModel),
      ],
    );

    final bottomBar = Container(
      color: AppColors.white,
      padding: AppEdges.smallAll,
      width: MediaQuery.of(context).size.width,
      child: contents,
    );

    return bottomBar;
  }

  Widget _buildSpeedIndicator(MapViewModel viewModel) {
    final speedText = Text(
      viewModel.userVehicle.point?.speed?.toStringAsFixed(0) ?? "0",
      style: AppTextStyles.header1.copyWith(
        color: AppColors.black,
        fontSize: 28,
        height: 1,
      ),
    );

    final kph = Text(
      "KPH",
      style: AppTextStyles.caption.copyWith(
        color: AppColors.black,
        fontWeight: FontWeight.bold,
      ),
    );

    final container = Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2.0),
        borderRadius: AppBorders.bezelGeom,
        color: AppColors.white,
      ),
      padding: AppEdges.tinyAll,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          speedText,
          kph,
        ],
      ),
    );

    final card = Card(
      color: AppColors.white,
      elevation: 3.0,
      margin: AppEdges.smallAll,
      shape: AppBorders.bezel,
      child: Padding(
        padding: AppEdges.tinyAll,
        child: container,
      ),
    );

    return card;
  }

  Widget _buildMap(Store<AppState> store, MapViewModel viewModel) {
    final markers = Set<Marker>();
    final polylines = Set<Polyline>();

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

    if (viewModel.connectionState == MqttConnectionState.connected &&
      viewModel.hasOtherVehicles && viewModel.securityLevel > SecurityLevelDto.controlled) {
        polylines.add(_buildSecurityLine(viewModel));
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
              final newPoint = point.rebuild((b) => b
                ..heading = store.state.map.userVehicle.point?.heading ?? 0);
              store.dispatch(UpdateUserGpsPoint(newPoint));
              _stickMap(point);
            },
            cancelOnError: true,
          );
      },
      mapType: MapType.normal,
      markers: markers,
      polylines: polylines,
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

  Polyline _buildSecurityLine(MapViewModel viewModel) {
    final userPoint = viewModel.userPoint;
    final otherPoint = viewModel.closestOtherVehiclePoint;

    final polyline = Polyline(
      polylineId: PolylineId(viewModel.closestOtherVehicleId),
      color: AppColors.red.withAlpha(100),
      patterns: <PatternItem>[
        PatternItem.dash(50.0),
        PatternItem.gap(20.0),
      ],
      points: <LatLng>[
        userPoint,
        otherPoint,
      ],
      zIndex: MapViewModel.SECURITY_LINE_ZINDEX,
    );

    return polyline;
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

class _CyclePage extends StatefulWidget {
  @override
  _CyclePageState createState() => _CyclePageState();
}

class _CyclePageState extends State<_CyclePage> with TickerProviderStateMixin {
  StreamSubscription<double> _directionStream;
  StreamSubscription<GpsPointDto> _gpsPointStream;
  StreamSubscription _timerStream;

  @override
  void initState() {
    super.initState();
    // Rebuild page every second
    _timerStream = Stream.periodic(Duration(seconds: 1))
      .listen((_) => setState((){}));
  }

  @override
  void dispose() {
    super.dispose();
    Geolocator.instance.resetController();
    _directionStream?.cancel();
    _gpsPointStream?.cancel();
    _timerStream?.cancel();
  }

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, MapViewModel>(
      onInit: (Store<AppState> store) => _startGpsListeners(store),
      converter: (Store<AppState> store) => MapViewModel(store.state.map, store.state.settings),
      builder: (BuildContext context, MapViewModel viewModel) => _buildPage(context, StoreProvider.of(context), viewModel),
    );

  Widget _buildPage(BuildContext context, Store<AppState> store, MapViewModel viewModel) {
    final body = Column(
      children: [
        Expanded(
          child: Center(
            child: _buildPlayButton(context, store, viewModel),
          ),
        ),
        _buildBottomBar(DetailsViewModel(store.state.map)),
      ],
    );

    final contents = <Widget>[
      Expanded(
        flex: 1,
        child: _buildTopBar(viewModel),
      ),
      Expanded(
        flex: 2,
        child: body,
      ),
    ];

    final page = Column(
      children: contents,
    );

    return page;
  }

  Widget _buildTopBar(MapViewModel viewModel) {
    Color barColor = AppColors.gray;
    Color textColor = AppColors.darkGray;
    String text = "Not connected to any broker service. Press start to share your geolocation status.";

    if (viewModel.connectionState == MqttConnectionState.connected) {
      barColor = AppColors.green;
      textColor = AppColors.white;
      text = "Connected to broker service. Sharing your geolocation status.";
    } else if (viewModel.connectionState == MqttConnectionState.connecting) {
      barColor = AppColors.gray;
      textColor = AppColors.darkGray;
      text = "Connecting to broker service...";
    } else if (viewModel.connectionState == MqttConnectionState.disconnecting) {
      barColor = AppColors.gray;
      textColor = AppColors.darkGray;
      text = "Disconnecting from broker service...";
    }

    final topBar = Container(
      color: barColor,
      padding: AppEdges.mediumAll,
      width: MediaQuery.of(context).size.width,
      child: Align(
        alignment: Alignment.center,
        child: Text(
          text,
          style: AppTextStyles.header1.copyWith(
            color: textColor,
            fontWeight: FontWeight.normal,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return topBar;
  }

  Widget _buildBottomBar(DetailsViewModel viewModel) {
    final labelStyle = AppTextStyles.body2.copyWith(color: AppColors.darkGray);
    final valueStyle = AppTextStyles.body2.copyWith(color: AppColors.black);

    final speedLabel = Text("Speed: ", style: labelStyle);
    final speedValue = Text("${viewModel.currentSpeedText} km/h", style: valueStyle);
    final speedText = Row(
      children: <Widget>[
        speedLabel,
        speedValue,
      ],
    );

    final elapsedTimeLabel = Text("Elapsed Time: ", style: labelStyle);
    final elapsedTimeValue = Text(viewModel.connectedToBroker
      ? viewModel.getDurationDisplay() : "00:00:00", style: valueStyle);
    final elapsedTimeText = Row(
      children: <Widget>[
        elapsedTimeLabel,
        elapsedTimeValue,
      ],
    );

    final contents = Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        speedText,
        elapsedTimeText,
      ],
    );

    final bottomBar = Container(
      padding: AppEdges.smallAll,
      child: contents,
    );

    return bottomBar;
  }

  void _startGpsListeners(Store<AppState> store) {
    _directionStream = FlutterCompass.events
      .listen((double direction) {
          final userVehicle = store.state.map.userVehicle;

          if (userVehicle.point == null) {
            return;
          }

          final point = userVehicle.point
            .rebuild((b) => b
              ..heading = direction
              ..dateTime = DateTime.now().toUtc());
          store.dispatch(UpdateUserGpsPoint(point));
        },
        cancelOnError: true,
      );

    _gpsPointStream = Geolocator.instance
      .getEvents()
      .listen((GpsPointDto point) {
          final newPoint = point.rebuild((b) => b
            ..heading = store.state.map.userVehicle.point?.heading ?? 0);
          store.dispatch(UpdateUserGpsPoint(newPoint));
        },
        cancelOnError: true,
      );
  }
}

Widget _buildPlayButton(BuildContext context, Store<AppState> store, MapViewModel viewModel) {
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