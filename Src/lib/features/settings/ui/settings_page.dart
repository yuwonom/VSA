/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:vsa/features/map/dtos.dart';
import 'package:vsa/features/settings/actions.dart';
import 'package:vsa/features/settings/ui/settings_dialog.dart';
import 'package:vsa/features/settings/viewmodels/settings_viewmodel.dart';
import 'package:vsa/state.dart';
import 'package:vsa/themes/theme.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => StoreConnector<AppState, SettingsViewModel>(
      converter: (Store<AppState> store) => SettingsViewModel(store.state.settings, store.state.map.userVehicle),
      builder: (BuildContext context, SettingsViewModel viewModel) => _buildPage(context, StoreProvider.of(context), viewModel),
    );

  Widget _buildPage(BuildContext context, Store<AppState> store, SettingsViewModel viewModel) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    
    final profileTileGroup = _buildTileGroup("Profile", <Widget>[
      _buildTile(context, "Identifier", viewModel.vehicleId, UpdateVehicleId, validity: (String value) => value.isNotEmpty),
      _buildTile(context, "Name", viewModel.vehicleName, UpdateVehicleName),
      _buildTileDropdown("Vehicle Type", viewModel.vehicleType.name, (String value) => store.dispatch(UpdateSettings(UpdateVehicleType, value))),
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
        onPressed: () => scaffoldKey.currentState.hideCurrentSnackBar(),
      ),
    );

    final topicStructureTileGroup = _buildTileGroup("Show Topics", <Widget>[
      _buildTileCheckbox("Level A", viewModel.isActiveLevelA, (bool checked) => store.dispatch(UpdateSettings(SwitchLevelA, checked))),
      _buildTileCheckbox("Level B", viewModel.isActiveLevelB, (bool checked) => scaffoldKey.currentState.showSnackBar(notAvailableSnackBar)),
      _buildTileCheckbox("Level C", viewModel.isActiveLevelC, (bool checked) => scaffoldKey.currentState.showSnackBar(notAvailableSnackBar)),
      _buildTileCheckbox("Level D", viewModel.isActiveLevelD, (bool checked) => scaffoldKey.currentState.showSnackBar(notAvailableSnackBar)),
      _buildTileCheckbox("Basic Vehicle", viewModel.isActiveBasicVehicle, (bool checked) => store.dispatch(UpdateSettings(SwitchBasicVehicle, checked))),
      _buildTileCheckbox("Basic Traffic", viewModel.isActiveBasicTraffic, (bool checked) => store.dispatch(UpdateSettings(SwitchBasicTraffic, checked))),
    ]);

    final levelATileGroup = _buildTileGroup("Level A Topics", <Widget>[
      _buildTile(context, "Publish current properties", viewModel.levelAPropertiesPublishTopic, UpdateLevelAPropertiesPublishTopic, validity: (String value) => value.isNotEmpty),
      _buildTile(context, "Publish current status", viewModel.levelAStatusPublishTopic, UpdateLevelAStatusPublishTopic, validity: (String value) => value.isNotEmpty),
      _buildTile(context, "Subscribe intersection", viewModel.levelAIntersectionSubscribeTopic, UpdateLevelAIntersectionSubscribeTopic, validity: (String value) => value.isNotEmpty),
    ]);

    final vehicleTopicsTileGroup = _buildTileGroup("Vehicle Topics", <Widget>[
      _buildTile(context, "Publish current properties", viewModel.propertiesPublishTopic, UpdatePropertiesPublishTopic, validity: (String value) => value.isNotEmpty),
      _buildTile(context, "Publish current status", viewModel.statusPublishTopic, UpdateStatusPublishTopic, validity: (String value) => value.isNotEmpty),
      _buildTile(context, "Request vehicle properties", viewModel.propertiesRequestPublishTopic, UpdatePropertiesRequestPublishTopic, validity: (String value) => value.isNotEmpty),
      _buildTile(context, "Get vehicle properties", viewModel.propertiesRequestSubscribeTopic, UpdatePropertiesRequestSubscribeTopic, validity: (String value) => value.isNotEmpty),
      _buildTile(context, "Request nearby vehicles", viewModel.statusRequestPublishTopic, UpdateStatusRequestPublishTopic, validity: (String value) => value.isNotEmpty),
      _buildTile(context, "Get nearby vehicles", viewModel.statusRequestSubscribeTopic, UpdateStatusRequestSubscribeTopic, validity: (String value) => value.isNotEmpty),
    ]);

    final trafficTopicsTileGroup = _buildTileGroup("Traffic Topics", <Widget>[
      _buildTile(context, "Request traffic", viewModel.trafficRequestPublishTopic, UpdateTrafficRequestPublishTopic, validity: (String value) => value.isNotEmpty),
      _buildTile(context, "Get traffic", viewModel.trafficRequestSubscribeTopic, UpdateTrafficRequestSubscribeTopic, validity: (String value) => value.isNotEmpty),
    ]);

    final body = ListView(
      key: const PageStorageKey<String>("settingsListView"),
      padding: AppEdges.mediumAll,
      children: <Widget>[
        profileTileGroup,
        brokerTileGroup,
        topicStructureTileGroup,
        viewModel.isActiveLevelA ? levelATileGroup : Container(),
        viewModel.isActiveBasicVehicle ? vehicleTopicsTileGroup : Container(),
        viewModel.isActiveBasicTraffic ? trafficTopicsTileGroup : Container(),
      ],
    );

    final appBar = AppBar(
      title: Text("Settings", style: AppTextStyles.header2.copyWith(color: AppColors.black)),
      backgroundColor: AppColors.white,
      brightness: Brightness.light,
      iconTheme: IconThemeData(color: AppColors.black),
    );

    final scaffold = Scaffold(
      key: scaffoldKey,
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

   Widget _buildTileCheckbox(String title, bool value, Function onChanged) => ListTile(
      leading: Checkbox(
        activeColor: AppColors.blue,
        value: value,
        onChanged: onChanged,
      ),
      title: Text(
        title,
        style: AppTextStyles.body1.copyWith(color: AppColors.black),
        overflow: TextOverflow.ellipsis,
        softWrap: true,
      ),
    );
  
  Widget _buildTileDropdown(String title, String value, Function onChanged) => ListTile(
      title: Text(
        title,
        style: AppTextStyles.body1.copyWith(color: AppColors.black),
        overflow: TextOverflow.ellipsis,
        softWrap: true,
      ),
      trailing: DropdownButton<String>(
        elevation: 2,
        style: AppTextStyles.body1.copyWith(color: AppColors.darkGray),
        value: value,
        items: VehicleTypeDto.values
          .map((VehicleTypeDto type) => DropdownMenuItem<String>(
            value: type.name,
            child: Text(type.name, style: AppTextStyles.body1.copyWith(color: AppColors.darkGray)),
          )).toList(),
        onChanged: onChanged,
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