/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:vsa/features/map/viewmodels/map_viewmodel.dart';
import 'package:vsa/state.dart';
import 'package:vsa/themes/theme.dart';

class MapMinimalPage extends StatefulWidget {
  @override
  _MapMinimalPageState createState() => _MapMinimalPageState();
}

class _MapMinimalPageState extends State<MapMinimalPage> {
  @override
  Widget build(BuildContext context) => StoreConnector<AppState, MapViewModel>(
      converter: (Store<AppState> store) => MapViewModel(store.state.map, store.state.settings),
      builder: (BuildContext context, MapViewModel viewModel) => _buildPage(context, StoreProvider.of(context), viewModel),
    );

  Widget _buildPage(BuildContext context, Store<AppState> store, MapViewModel viewModel) {
    final page = Container(color: AppColors.white);

    return page;
  }
}