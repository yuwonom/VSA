/// Authored by `@yuwonom (Michael Yuwono)`

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:redux/redux.dart';
import 'package:vsa/features/map/actions.dart';
import 'package:vsa/features/map/viewmodels.dart';
import 'package:vsa/state.dart';
import 'package:vsa/themes/theme.dart';

class MapPage extends StatefulWidget {
  @override
  MapPageState createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, MapViewModel>(
      onInit: (Store<AppState> store) => store.dispatch(ListenToGeolocator()),
      converter: (Store<AppState> store) => MapViewModel(store.state.map),
      builder: (BuildContext context, MapViewModel viewModel) => _buildPage(context, StoreProvider.of(context), viewModel)
    );
  
  Widget _buildPage(BuildContext context, Store<AppState> store, MapViewModel viewModel) {
    final playButton = _buildPlayButton(store, viewModel);
    
    final stack = Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        _buildMap(store, viewModel),
        Padding(
          padding: AppEdges.mediumVertical,
          child: playButton,
        ),
      ],
    );

    final body = SafeArea(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          RepaintBoundary(child: stack),
          DetailsBar(),
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

  Widget _buildPlayButton(Store<AppState> store, MapViewModel viewModel) {
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
        return FloatingActionButton(
          backgroundColor: AppColors.blue,
          onPressed: disconnectCallback,
          child: Icon(Icons.stop, color: AppColors.white),
        );
      case MqttConnectionState.disconnected:
        return FloatingActionButton(
          backgroundColor: AppColors.blue,
          onPressed: connectCallback,
          child: Icon(Icons.play_arrow, color: AppColors.white),
        );
      case MqttConnectionState.faulted:
        return FloatingActionButton(
          backgroundColor: AppColors.blue,
          onPressed: connectCallback,
          child: Icon(Icons.play_arrow, color: AppColors.white),
        );
      default:
        return FloatingActionButton(
          backgroundColor: AppColors.gray,
          onPressed: null,
          child: Padding(
            padding: AppEdges.smallAll,
            child: loading,
          ),
        );
    }
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
          target: MapViewModel.BRISBANE_LATLNG,
          zoom: 24,
          bearing: 50,
          tilt: 90,
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
}

class DetailsBar extends StatefulWidget {
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

  @override
  void initState() {
    super.initState();
    _drawerController = AnimationController(duration: animationDuration, vsync: this);
    _drawerAnimation = Tween(begin: heightMinimized, end: heightMaximized).animate(_drawerController);
  }

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, DetailsViewModel>(
      converter: (Store<AppState> store) => DetailsViewModel(store.state.map),
      builder: (BuildContext context, DetailsViewModel viewModel) => _buildPage(context, StoreProvider.of(context), viewModel)
    );

  Widget _buildPage(BuildContext context, Store<AppState> store, DetailsViewModel viewModel) {
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
            _createItem("42:00", "Elapsed Time"),
            _createItem("secured", "Security Level"),
          ],
        ),
        divider,
        Column(
          children: <Widget>[
            _createItem("42", "Speed (km/h)"),
            _createItem("42", "Avg (km/h)"),
          ],
        ),
        divider,
        Column(
          children: <Widget>[
            _createItem("42", "Distance (km)"),
            _createItem("42%", "Accuracy"),
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

  @override
  void dispose() {
    _drawerController.dispose();
    super.dispose();
  }
}