/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:redux/redux.dart';
import 'package:vsa/features/map/ui/map_details_page.dart';
import 'package:vsa/features/map/ui/map_minimal_page.dart';
import 'package:vsa/features/map/ui/map_normal_page.dart';
import 'package:vsa/features/map/viewmodels/map_viewmodel.dart';
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
    MapNormalPage(),
    MapDetailsPage(),
  ];

  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, MapViewModel>(
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
        ? () => showDialog(context: context, builder: (_) => SwitchMapDialog(_pageIndex,
            onChanged: (int index) => setState(() => _pageIndex = index)))
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

class SwitchMapDialog extends StatefulWidget {
  const SwitchMapDialog(this.currentIndex, {this.onChanged})
    : assert(currentIndex != null);

  final int currentIndex;
  final ValueChanged<int> onChanged;

  @override
  _SwitchMapDialogState createState() => _SwitchMapDialogState();
}

class _SwitchMapDialogState extends State<SwitchMapDialog> {
  final _pagesName = <String>[
    "Minimal",
    "Normal",
    "Details",
  ];
  
  int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    final tiles = Column(
      children: _pagesName.map((String value) => Material(
        color: value == _pagesName[_selectedIndex]
          ? AppColors.gray : AppColors.white,
        child: ListTile(
          contentPadding: AppEdges.smallHorizontal,
          title: Text(value, style: AppTextStyles.body1.copyWith(color: AppColors.black)),
          trailing: value == _pagesName[_selectedIndex]
            ? Icon(Icons.check, color: AppColors.green) : null,
          onTap: () {
            final selectedIndex = _pagesName.indexOf(value);
            setState(() => _selectedIndex = selectedIndex);
            if (widget.onChanged != null) {
              widget.onChanged(_selectedIndex);
            }
            Navigator.pop(context);
          },
        ),
      )).toList(),  
    );

    final container = Card(
      color: AppColors.white,
      elevation: 3.0,
      shape: AppBorders.bezel,
      margin: AppEdges.mediumHorizontal,
      clipBehavior: Clip.antiAlias,
      child: tiles,
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          container,
        ],
      ),
    );
  }
}