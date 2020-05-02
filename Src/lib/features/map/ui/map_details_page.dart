/// Authored by `@yuwonom (Michael Yuwono)`

import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:redux/redux.dart';
import 'package:vsa/features/map/actions.dart';
import 'package:vsa/features/map/dtos.dart';
import 'package:vsa/features/map/geolocator.dart';
import 'package:vsa/features/map/ui/user_identifier_dialog.dart';
import 'package:vsa/features/map/viewmodels/details_viewmodel.dart';
import 'package:vsa/features/map/viewmodels/map_viewmodel.dart';
import 'package:vsa/features/settings/actions.dart';
import 'package:vsa/state.dart';
import 'package:vsa/themes/theme.dart';

class MapDetailsPage extends StatefulWidget {
  @override
  _MapDetailsPageState createState() => _MapDetailsPageState();
}

class _MapDetailsPageState extends State<MapDetailsPage> {
  final double _defaultZoom = 18;
  final double _defaultBearing = 0;
  final double _defaultTilt = 45;

  GoogleMapController _mapController;
  StreamSubscription<double> _directionStream;
  StreamSubscription<GpsPointDto> _gpsPointStream;

  double _direction;
  bool _isSticky;

  @override
  void initState() {
    super.initState();
    _direction = _defaultBearing;
    _isSticky = true;
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

    final page = SafeArea(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          RepaintBoundary(child: stack),
          _DetailsBar(DetailsViewModel(store.state.map)),
        ],
      ),
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

  void _stickMap(GpsPointDto point) {
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

class _DetailsBar extends StatefulWidget {
  _DetailsBar(this.viewModel) : assert(viewModel != null);

  final DetailsViewModel viewModel;

  @override
  _DetailsBarState createState() => _DetailsBarState();
}

class _DetailsBarState extends State<_DetailsBar> with TickerProviderStateMixin {
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
            _createItem("${widget.viewModel.accuracyText} m", "Accuracy"),
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