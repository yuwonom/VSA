/// Authored by `@yuwonom (Michael Yuwono)`

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
      actions: <Widget>[
        settings,
      ],
    );

    final scaffold = Scaffold(
      appBar: appBar,
      body: stack,
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