/// Authored by `@yuwonom (Michael Yuwono)`

import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:redux/redux.dart';
import 'package:vsa/features/map/actions.dart';
import 'package:vsa/features/map/dtos.dart';
import 'package:vsa/features/map/viewmodels.dart';
import 'package:vsa/state.dart';
import 'package:vsa/themes/theme.dart';

class MapPage extends StatefulWidget {
  @override
  MapPageState createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  final double _defaultZoom = 24;
  final double _defaultBearing = 50;
  final double _defaultTilt = 90;

  GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, MapViewModel>(
      onInit: (Store<AppState> store) => store.dispatch(ListenToGeolocator()),
      converter: (Store<AppState> store) => MapViewModel(store.state.map),
      builder: (BuildContext context, MapViewModel viewModel) => _buildPage(context, StoreProvider.of(context), viewModel)
    );
  
  Widget _buildPage(BuildContext context, Store<AppState> store, MapViewModel viewModel) {
    final actionButtons = _buildActionButtons(store, viewModel);
    
    final stack = Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        _buildMap(store, viewModel),
        Padding(
          padding: AppEdges.mediumAll,
          child: actionButtons,
        ),
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
      onPressed: () {},
    );

    final appBar = AppBar(
      title: Text("VSA", style: AppTextStyles.header2.copyWith(color: AppColors.black)),
      backgroundColor: AppColors.white,
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
          viewModel.server,
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
          backgroundColor: AppColors.blue,
          onPressed: disconnectCallback,
          child: Icon(Icons.stop, color: AppColors.white),
        );
      break;
      case MqttConnectionState.disconnected:
        playButton = FloatingActionButton(
          backgroundColor: AppColors.blue,
          onPressed: connectCallback,
          child: Icon(Icons.play_arrow, color: AppColors.white),
        );
      break;
      case MqttConnectionState.faulted:
        playButton = FloatingActionButton(
          backgroundColor: AppColors.blue,
          onPressed: connectCallback,
          child: Icon(Icons.play_arrow, color: AppColors.white),
        );
      break;
      default:
        playButton = FloatingActionButton(
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
      child: securityIndicatorIcon,
    );

    final myLocation = FloatingActionButton(
      backgroundColor: AppColors.white,
      onPressed: () => _moveMapCamera(viewModel.userPoint),
      child: Icon(Icons.my_location, color: AppColors.black),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        securityIndicator,
        playButton,
        myLocation,
      ],
    );
  }

  Widget _buildMap(Store<AppState> store, MapViewModel viewModel) {
    final userCircle = Circle(
      circleId: CircleId("user"),
      center: viewModel.userPoint,
      visible: viewModel.hasUserPoint,
      fillColor: AppColors.blue,
      radius: 5.0,
      strokeWidth: 1,
    );

    final circles = Set<Circle>.of(<Circle>[
      userCircle,
    ]);

    return Container(
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: viewModel.userPoint,
          zoom: _defaultZoom,
          bearing: _defaultBearing,
          tilt: _defaultTilt,
        ),
        onMapCreated: (GoogleMapController controller) => _mapController = controller,
        mapType: MapType.normal,
        circles: circles,
        compassEnabled: false,
        myLocationEnabled: false,
        myLocationButtonEnabled: false,
        tiltGesturesEnabled: false,
      ),
    );
  }

  void _moveMapCamera(LatLng point) {
    if (_mapController == null || point == null) {
      return;
    }

    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: point,
          zoom: _defaultZoom,
          bearing: _defaultBearing,
          tilt: _defaultTilt,
        ),
      ),
    );
  }
}

class DetailsBar extends StatefulWidget {
  DetailsBar(this.viewModel) : assert(viewModel != null);

  final DetailsViewModel viewModel;

  @override
  DetailsBarState createState() => DetailsBarState();
}

class DetailsBarState extends State<DetailsBar> with TickerProviderStateMixin {
  static const Duration animationDuration = const Duration(milliseconds: 100);
  static const double appBarSized = 60.0;
  static const double heightMinimized = 25.0;
  static const double heightMaximized = 150.0;

  double currentHeight = heightMinimized;

  AnimationController _drawerController;
  Animation<double> _drawerAnimation;

  String _timeDisplay = "00:00:00";
  StreamSubscription _timerStream;

  @override
  void initState() {
    super.initState();
    _drawerController = AnimationController(duration: animationDuration, vsync: this);
    _drawerAnimation = Tween(begin: heightMinimized, end: heightMaximized).animate(_drawerController);

    _timerStream = Stream.periodic(Duration(seconds: 1)).listen((_) {
      if (!widget.viewModel.connectedToBroker) {
        return;
      }

      setState(() {
        final diff = DateTime.now().difference(widget.viewModel.startTime);
        _timeDisplay = _getRideDurationDisplay(diff.inMilliseconds);
      });
    });
  }

  @override
  Widget build(BuildContext context) => StoreBuilder<AppState>(builder: _buildPage);

  Widget _buildPage(BuildContext context, Store<AppState> store) {
    final content = Container(
      height: currentHeight,
      color: AppColors.white,
      child: _createDetails(context),
    );

    final gesture = GestureDetector(
      onVerticalDragUpdate: _updateHeight,
      onVerticalDragEnd: _finalizeHeight,
      child: content,
    );

    final animatedBuilder = AnimatedBuilder(
      animation: _drawerController,
      builder: (BuildContext context, Widget child) => gesture,
    );

    return animatedBuilder;
  }

  void _updateHeight(DragUpdateDetails details) => setState(() {
        final targetHeight = (details.globalPosition.dy - appBarSized).clamp(heightMinimized, heightMaximized);
        currentHeight = lerpDouble(currentHeight, targetHeight, 0.3);
      });

  void _finalizeHeight(DragEndDetails details) {
    final projectedHeight = currentHeight + (details.velocity.pixelsPerSecond.dy * (animationDuration.inMilliseconds / 1000));
    final diffToMin = (projectedHeight - heightMinimized).abs();
    final diffToMax = (projectedHeight - heightMaximized).abs();
    final target = diffToMin < diffToMax ? heightMinimized : heightMaximized;

    final drawerCurve = CurvedAnimation(parent: _drawerController, curve: Curves.easeOut);
    _drawerAnimation = Tween(begin: currentHeight, end: target).animate(drawerCurve);
    _drawerAnimation.addListener(() => setState(() => currentHeight = _drawerAnimation.value));

    setState(() {
      _drawerController.reset();
      _drawerController.forward();
    });
  }

  Widget _createDetails(BuildContext context) {
    final divider = Container(
      color: AppColors.black,
      width: 1.5,
      height: 100.0,
    );

    final details = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Column(
          children: <Widget>[
            _createItem(_timeDisplay, "Elapsed Time"),
            _createItem(widget.viewModel.securityLevelText, "Security Level"),
          ],
        ),
        divider,
        Column(
          children: <Widget>[
            _createItem(widget.viewModel.currentSpeedText, "Speed (km/h)"),
            _createItem(widget.viewModel.averageSpeedText, "Avg (km/h)"),
          ],
        ),
        divider,
        Column(
          children: <Widget>[
            _createItem(widget.viewModel.distanceText, "Distance (km)"),
            _createItem("${widget.viewModel.accuracyText}%", "Accuracy"),
          ],
        ),
      ],
    );

    final handle = Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Icon(Icons.drag_handle, color: AppColors.darkGray, size: 24.0),
    );

    return OverflowBox(
      alignment: Alignment.bottomCenter,
      maxHeight: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget> [
          details,
          handle,
        ],
      ),
    );
  }

  Widget _createItem(String title, String description) => Padding(
      padding: AppEdges.tinyVertical,
      child: Column(
        children: <Widget>[
          Padding(
            padding: AppEdges.tinyVertical,
            child: Text(title, style: AppTextStyles.subtitle1.copyWith(color: AppColors.black), textAlign: TextAlign.center),
          ),
          Text(description, style: AppTextStyles.caption.copyWith(color: AppColors.black, letterSpacing: 0.4), textAlign: TextAlign.center),
        ],
      ),
    );

  String _getRideDurationDisplay(int milliseconds) {
    var seconds = (milliseconds / 1000).truncate();
    var minutes = (seconds / 60).truncate();
    var hours = (minutes / 60).truncate();

    var ss = (seconds % 60).toStringAsFixed(0).padLeft(2, "0");
    var mm = (minutes % 60).toStringAsFixed(0).padLeft(2, "0");
    var hh = hours.toStringAsFixed(0).padLeft(2, "0");
    return "$hh:$mm:$ss";
  }

  @override
  void dispose() {
    _drawerController.dispose();
    _timerStream.cancel();
    super.dispose();
  }
}