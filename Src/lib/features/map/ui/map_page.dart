/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:redux/redux.dart';
import 'package:vsa/features/map/actions.dart';
import 'package:vsa/features/map/ui/map_details_page.dart';
import 'package:vsa/features/map/ui/map_minimal_page.dart';
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
  final _pages = [
    MapMinimalPage(),
    MapDetailsPage(),
  ];

  int _pageIndex = 0;

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
    final switchAction = IconButton(
      icon: Icon(Icons.loop),
      color: AppColors.black,
      iconSize: 20.0,
      tooltip: "Switch page",
      onPressed: viewModel.connectionState == MqttConnectionState.disconnected || viewModel.connectionState == MqttConnectionState.faulted
        ? () => setState(() => _pageIndex = (_pageIndex + 1) % _pages.length)
        : null,
    );

    final settingsAction = IconButton(
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
        switchAction,
        settingsAction,
      ],
    );

    final scaffold = Scaffold(
      appBar: appBar,
      body: _pages[_pageIndex],
    );

    return scaffold;
  }
}