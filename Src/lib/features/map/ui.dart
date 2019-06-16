/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
      body: _buildMap(store, viewModel),
    );

    return scaffold;
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