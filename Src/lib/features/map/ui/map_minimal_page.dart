/// Authored by `@yuwonom (Michael Yuwono)`

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:redux/redux.dart';
import 'package:vsa/features/map/actions.dart';
import 'package:vsa/features/map/dtos.dart';
import 'package:vsa/features/map/ui/user_identifier_dialog.dart';
import 'package:vsa/features/map/viewmodels/details_viewmodel.dart';
import 'package:vsa/features/map/viewmodels/map_viewmodel.dart';
import 'package:vsa/state.dart';
import 'package:vsa/themes/theme.dart';
import 'package:vsa/themes/vsa_map.dart';
import 'package:vsa/utility/geolocator.dart';

class MapMinimalPage extends StatefulWidget {
  @override
  _MapMinimalPageState createState() => _MapMinimalPageState();
}

class _MapMinimalPageState extends State<MapMinimalPage> {
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
      onInit: (Store<AppState> store) => Future.delayed(const Duration(seconds: 1))
          .then((_) => _startGpsListeners(store)),
      converter: (Store<AppState> store) => MapViewModel(store.state.map, store.state.settings),
      builder: (BuildContext context, MapViewModel viewModel) => viewModel.userVehicle.type == VehicleTypeDto.car
        ? _CarPage(context, viewModel) : _CyclePage(context, viewModel),
    );

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

class _CarPage extends StatelessWidget {
  _CarPage(this.context, this.viewModel);

  final BuildContext context;
  final MapViewModel viewModel;

  Store<AppState> get store => StoreProvider.of(context);

  @override
  Widget build(BuildContext context) {
    final canvasHeight = MediaQuery.of(context).size.height * 5;
    final canvasWidth = MediaQuery.of(context).size.width * 5;
    final distance = min(500.0, viewModel.distanceFromIntersectionPixels);

    final map = OverflowBox(
      alignment: Alignment.center,
      maxHeight: canvasHeight,
      minHeight: canvasHeight,
      maxWidth: canvasWidth,
      minWidth: canvasWidth,
      child: CustomPaint(
        painter: VSAMapIntersections(),
        child: Container(),
      ),
    );

    final transformedMap = viewModel.hasUserPoint
      ? Transform.translate(
          offset: Offset(0, 100.0 - distance),
          child: Transform.rotate(
            angle: viewModel.userVehicle.point.heading / 180 * pi * -1,
            origin: Offset(0, distance),
            child: map,
          ),
        )
      : Container();

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
        ],
      ),
    );

    final bottomPosition = canvasHeight * 0.0575;
    final userVehicleMarker = Positioned(
      left: 0,
      right: 0,
      bottom: bottomPosition,
      child: _buildUserVehicleMarker(viewModel),
    );

    final page = Container(
      color: AppColors.white,
      child: Stack(
        children: <Widget>[
          transformedMap,
          topView,
          bottomView,
          userVehicleMarker,
        ],
      ),
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
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(
            color: AppColors.lightGray,
            width: 1.0,
          ),
        ),
      ),
      padding: AppEdges.smallAll,
      width: MediaQuery.of(context).size.width,
      child: SafeArea(child: contents)
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

  Widget _buildUserVehicleMarker(MapViewModel viewModel) {
    final iconPath = "assets/images/vehicles/";
    final iconType = viewModel.userVehicle.type.toString();
    return Image.asset("$iconPath${iconType}_self.png", height: 40.0, width: 40.0);
  }
}

class _CyclePage extends StatelessWidget {
  _CyclePage(this.context, this.viewModel);

  final BuildContext context;
  final MapViewModel viewModel;

  Store<AppState> get store => StoreProvider.of(context);

  @override
  Widget build(BuildContext context) {
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