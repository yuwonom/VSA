/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:vsa/features/map/dtos.dart';
import 'package:vsa/features/settings/actions.dart';
import 'package:vsa/features/settings/dtos.dart';
import 'package:vsa/features/settings/ui/settings_dialog.dart';
import 'package:vsa/features/settings/ui/settings_dropdown_dialog.dart';
import 'package:vsa/features/settings/viewmodels/settings_viewmodel.dart';
import 'package:vsa/state.dart';
import 'package:vsa/themes/theme.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, SettingsViewModel>(
      converter: (Store<AppState> store) => SettingsViewModel(store.state.settings, store.state.map.userVehicle),
      builder: (BuildContext context, SettingsViewModel viewModel) => _buildPage(context, StoreProvider.of(context), viewModel),
    );

  Widget _buildPage(BuildContext context, Store<AppState> store, SettingsViewModel viewModel) {
    final profileTileGroup = _buildTileGroup("Profile", <Widget>[
      _buildTile(context, "Identifier", viewModel.vehicleId, UpdateVehicleId, validity: (String value) => value.isNotEmpty),
      _buildTile(context, "Name", viewModel.vehicleName, UpdateVehicleName),
      _buildDropdownTile(context, "Vehicle Type", viewModel.vehicleType.name, VehicleTypeDto.values.map<String>((VehicleTypeDto type) => type.name).toList(), (String value) => store.dispatch(UpdateSettings(UpdateVehicleType, value))),
      _buildTile(context, "Dimension", viewModel.dimensionString, UpdateDimension, validity: (String value) {
        final values = value.split(',');
        if (values.length != 4) {
          return false;
        }

        return !values
          .map<bool>((String val) => double.tryParse(val.trim()) == null)
          .contains(true);
      }),
    ]);

    final brokerTileGroup = _buildTileGroup("Broker", <Widget>[
      _buildTile(context, "Address", viewModel.address, UpdateBrokerAddress),
      _buildTile(context, "Port", viewModel.port, UpdateBrokerPort),
      _buildTile(context, "Username", viewModel.username, UpdateBrokerUsername),
      _buildTile(context, "Password", viewModel.password, UpdateBrokerPassword, obscureText: true),
    ]);
    
    final notAvailableSnackBar = SnackBar(
      duration: const Duration(seconds: 2),
      content: Text("Level is not yet available"),
      action: SnackBarAction(
        label: "OKAY",
        onPressed: () => _scaffoldKey.currentState.hideCurrentSnackBar(),
      ),
    );

    final topicStructureTileGroup = _buildTileGroup("Show Topics", <Widget>[
      _buildTileCheckbox("Level A", viewModel.isActiveLevelA, (bool checked) => store.dispatch(UpdateSettings(UpdateTopicLevel, TopicLevelDto.levelA))),
      _buildTileCheckbox("Level B", viewModel.isActiveLevelB, (bool checked) => store.dispatch(UpdateSettings(UpdateTopicLevel, TopicLevelDto.levelB))),
      _buildTileCheckbox("Level C", viewModel.isActiveLevelC, (bool checked) => _scaffoldKey.currentState.showSnackBar(notAvailableSnackBar)),
      // Hide vehicle & events for now
      // _buildTileCheckbox("Basic Vehicle", viewModel.isActiveBasicVehicle, (bool checked) => store.dispatch(UpdateSettings(SwitchBasicVehicle, checked))),
      // _buildTileCheckbox("Basic Events", viewModel.isActiveBasicEvents, (bool checked) => store.dispatch(UpdateSettings(SwitchBasicEvents, checked))),
    ]);

    var listItems = <Widget>[
        profileTileGroup,
        brokerTileGroup,
        topicStructureTileGroup,
    ];

    if (viewModel.isActiveLevelA) {
      final levelATileGroup = _buildTileGroup("Level A Topics", <Widget>[
        _buildTile(context, "Publish current properties", viewModel.levelAPropertiesPublishTopic, UpdateLevelAPropertiesPublishTopic, validity: (String value) => value.isNotEmpty),
        _buildTile(context, "Publish current status", viewModel.levelAStatusPublishTopic, UpdateLevelAStatusPublishTopic, validity: (String value) => value.isNotEmpty),
        _buildTile(context, "Subscribe intersection", viewModel.levelAIntersectionSubscribeTopic, UpdateLevelAIntersectionSubscribeTopic, validity: (String value) => value.isNotEmpty),
      ]);
      listItems.add(levelATileGroup);
    }

    if (viewModel.isActiveLevelB) {
      final levelBTileGroup = _buildTileGroup("Level B Topics", <Widget>[
        _buildTile(context, "Publish current properties", viewModel.levelBPropertiesPublishTopic, UpdateLevelBPropertiesPublishTopic, validity: (String value) => value.isNotEmpty),
        _buildTile(context, "Publish current status", viewModel.levelBStatusPublishTopic, UpdateLevelBStatusPublishTopic, validity: (String value) => value.isNotEmpty),
        _buildTile(context, "Subscribe intersection", viewModel.levelBIntersectionSubscribeTopic, UpdateLevelBIntersectionSubscribeTopic, validity: (String value) => value.isNotEmpty),
        _buildTile(context, "Subscribe events", viewModel.levelBEventsSubscribeTopic, UpdateLevelBEventsSubscribeTopic, validity: (String value) => value.isNotEmpty),
      ]);
      listItems.add(levelBTileGroup);
    }

    if (viewModel.isActiveBasicVehicle) {
      final vehicleTopicsTileGroup = _buildTileGroup("Vehicle Topics", <Widget>[
        _buildTile(context, "Publish current properties", viewModel.propertiesPublishTopic, UpdatePropertiesPublishTopic, validity: (String value) => value.isNotEmpty),
        _buildTile(context, "Publish current status", viewModel.statusPublishTopic, UpdateStatusPublishTopic, validity: (String value) => value.isNotEmpty),
        _buildTile(context, "Request vehicle properties", viewModel.propertiesRequestPublishTopic, UpdatePropertiesRequestPublishTopic, validity: (String value) => value.isNotEmpty),
        _buildTile(context, "Get vehicle properties", viewModel.propertiesRequestSubscribeTopic, UpdatePropertiesRequestSubscribeTopic, validity: (String value) => value.isNotEmpty),
        _buildTile(context, "Request nearby vehicles", viewModel.statusRequestPublishTopic, UpdateStatusRequestPublishTopic, validity: (String value) => value.isNotEmpty),
        _buildTile(context, "Get nearby vehicles", viewModel.statusRequestSubscribeTopic, UpdateStatusRequestSubscribeTopic, validity: (String value) => value.isNotEmpty),
      ]);
      listItems.add(vehicleTopicsTileGroup);
    }

    if (viewModel.isActiveBasicEvents) {
      final eventsTopicsTileGroup = _buildTileGroup("Events Topics", <Widget>[
        _buildTile(context, "Request events", viewModel.eventsRequestPublishTopic, UpdateEventsRequestPublishTopic, validity: (String value) => value.isNotEmpty),
        _buildTile(context, "Get events", viewModel.eventsRequestSubscribeTopic, UpdateEventsRequestSubscribeTopic, validity: (String value) => value.isNotEmpty),
      ]);
      listItems.add(eventsTopicsTileGroup);
    }

    final body = ListView(
      key: const PageStorageKey<String>("settingsListView"),
      padding: AppEdges.mediumAll,
      children: listItems,
    );

    final appBar = AppBar(
      title: Text("Settings", style: AppTextStyles.header2.copyWith(color: AppColors.black)),
      backgroundColor: AppColors.white,
      brightness: Brightness.light,
      iconTheme: IconThemeData(color: AppColors.black),
    );

    final scaffold = Scaffold(
      key: _scaffoldKey,
      appBar: appBar,
      body: body,
    );
    
    return scaffold;
  }

  Widget _buildTile(BuildContext context, String title, String value, Type actionType, {bool Function(String) validity, bool obscureText = false}) => ListTile(
      title: Text(
        title,
        style: AppTextStyles.body1.copyWith(color: AppColors.black),
        overflow: TextOverflow.ellipsis,
        softWrap: true,
      ),
      subtitle: Text(
        obscureText ? "•" * value.length : value,
        style: AppTextStyles.body1.copyWith(color: AppColors.darkGray),
        overflow: TextOverflow.ellipsis,
        softWrap: true,
        maxLines: 2,
      ),
      onTap: () => showDialog(
        context: context,
        builder: (_) => SettingsDialog(
          title: title,
          value: value,
          actionType: actionType,
          validity: validity,
          obscureText: obscureText,
        ),
      ),
    );

   Widget _buildTileCheckbox(String title, bool value, ValueChanged<bool> onChanged) => ListTile(
      leading: Checkbox(
        activeColor: AppColors.blue,
        value: value,
        onChanged: onChanged,
      ),
      title: GestureDetector(
        onTap: () => onChanged(true),
        child: Text(
          title,
          style: AppTextStyles.body1.copyWith(color: AppColors.black),
          overflow: TextOverflow.ellipsis,
          softWrap: true,
        ),
      ),
    );
  
  Widget _buildDropdownTile(BuildContext context, String title, String value, List<String> values, Function onChanged) => ListTile(
      title: Text(
        title,
        style: AppTextStyles.body1.copyWith(color: AppColors.black),
        overflow: TextOverflow.ellipsis,
        softWrap: true,
      ),
      subtitle: Text(
        value,
        style: AppTextStyles.body1.copyWith(color: AppColors.darkGray),
        overflow: TextOverflow.ellipsis,
        softWrap: true,
        maxLines: 2,
      ),
      onTap: () => showDialog(
        context: context,
        builder: (_) => SettingsDropdownDialog(
          title: title,
          value: value,
          values: values,
          onChanged: onChanged,
        ),
      ),
    );

  Widget _buildTileGroup(String headerText, List<Widget> tiles) {
    final title = Padding(
      padding: AppEdges.smallHorizontal,
      child: Text(
        headerText,
        style: AppTextStyles.subtitle1.copyWith(color: AppColors.black),
        textAlign: TextAlign.left,
      ),
    );

    final tilesColumn = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: tiles,
    );

    final group =  Container(
      margin: AppEdges.smallVertical,
      decoration: BoxDecoration(
        borderRadius: AppBorders.bezelGeom,
        border: Border.all(color: AppColors.lightGray),
      ),
      child: Material(
        color: AppColors.white,
        borderRadius: AppBorders.bezelGeom,
        child: tilesColumn,
      ),
    );

    final tileGroup = Padding(
      padding: const EdgeInsets.only(bottom: AppLengths.small),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          title,
          group,
        ],
      ),
    );

    return tileGroup;
  }
}