/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:vsa/features/settings/actions.dart';
import 'package:vsa/features/settings/viewmodel.dart';
import 'package:vsa/state.dart';
import 'package:vsa/themes/theme.dart';
import 'package:vsa/themes/vsa_button.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => StoreConnector<AppState, SettingsViewModel>(
      converter: (Store<AppState> store) => SettingsViewModel(store.state.settings),
      builder: (BuildContext context, SettingsViewModel viewModel) => _buildPage(context, StoreProvider.of(context), viewModel),
    );

  Widget _buildPage(BuildContext context, Store<AppState> store, SettingsViewModel viewModel) {
    final brokerTileGroup = _buildTileGroup("Broker", <Widget>[
      _buildTile(context, "Address", viewModel.address, UpdateBrokerAddress),
      _buildTile(context, "Port", viewModel.port, UpdateBrokerPort),
      _buildTile(context, "Username", viewModel.username, UpdateBrokerUsername),
      _buildTile(context, "Password", viewModel.password, UpdateBrokerPassword, obscureText: true),
      _buildTile(context, "Identifier", viewModel.clientId, UpdateBrokerClientId),
    ]);

    final vehicleTopicsTileGroup = _buildTileGroup("Vehicle Topics", <Widget>[
      _buildTile(context, "Publish current properties", viewModel.propertiesPublishTopic, UpdatePropertiesPublishTopic),
      _buildTile(context, "Publish current status", viewModel.statusPublishTopic, UpdateStatusPublishTopic),
      _buildTile(context, "Request vehicle properties", viewModel.propertiesRequestPublishTopic, UpdatePropertiesRequestPublishTopic),
      _buildTile(context, "Get vehicle properties", viewModel.propertiesRequestSubscribeTopic, UpdatePropertiesRequestSubscribeTopic),
      _buildTile(context, "Request nearby vehicles", viewModel.statusRequestPublishTopic, UpdateStatusRequestPublishTopic),
      _buildTile(context, "Get nearby vehicles", viewModel.statusRequestSubscribeTopic, UpdateStatusRequestSubscribeTopic),
    ]);

    final trafficTopicsTileGroup = _buildTileGroup("Traffic Topics", <Widget>[
      _buildTile(context, "Request traffic", viewModel.trafficRequestPublishTopic, UpdateTrafficRequestPublishTopic),
      _buildTile(context, "Get traffic", viewModel.trafficRequestSubscribeTopic, UpdateTrafficRequestSubscribeTopic),
    ]);

    final body = SingleChildScrollView(
      padding: AppEdges.mediumAll,
      child: Column(
        children: <Widget>[
          brokerTileGroup,
          vehicleTopicsTileGroup,
          trafficTopicsTileGroup,
        ],
      ),
    );

    final appBar = AppBar(
      title: Text("Settings", style: AppTextStyles.header2.copyWith(color: AppColors.black)),
      backgroundColor: AppColors.white,
      iconTheme: IconThemeData(color: AppColors.black),
    );

    final scaffold = Scaffold(
      appBar: appBar,
      body: body,
    );
    
    return scaffold;
  }

  Widget _buildTile(BuildContext context, String title, String value, Type actionType, {bool obscureText = false}) => ListTile(
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
      onTap: () => showDialog(context: context, builder: (_) => SettingsDialog(title, value, actionType, obscureText: obscureText)),
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

class SettingsDialog extends StatefulWidget {
  const SettingsDialog(this.title, this.value, this.actionType, {this.obscureText = false})
    : assert(title != null && value != null && actionType != null);

  final String title;
  final String value;
  final Type actionType;
  final bool obscureText;

  @override
  SettingsDialogState createState() => SettingsDialogState();
}

class SettingsDialogState extends State<SettingsDialog> {
  TextEditingController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = widget.value;
  }

  @override
  Widget build(BuildContext context) => StoreBuilder(builder: _buildPage);

  Widget _buildPage(BuildContext context, Store<AppState> store) {
    final title = Text(widget.title, style: AppTextStyles.subtitle1.copyWith(color: AppColors.black));
    
    final textField = TextField(
      autofocus: true,
      autocorrect: false,
      controller: _controller,
      obscureText: widget.obscureText,
    );

    final saveButton = VSAButton(
      text: "Save",
      type: VSAButtonType.secondary,
      onPressed: () {
        final action = _getAction(widget.actionType);
        store.dispatch(action);
        Navigator.pop(context);
      },
    );

    final cancelButton = VSAButton(
      text: "Cancel",
      type: VSAButtonType.secondary,
      onPressed: () => Navigator.pop(context),
    );

    final buttons = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        saveButton,
        cancelButton,
      ],
    );

    final contents = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: AppLengths.small),
          child: title,
        ),
        Padding(
          padding: AppEdges.smallVertical,
          child: textField,
        ),
        buttons,
      ],
    );

    final container = Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppBorders.bezelGeom,
      ),
      margin: AppEdges.smallHorizontal,
      padding: AppEdges.mediumAll,
      child: Material(
        color: AppColors.white,
        child: contents,
      ),
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

  dynamic _getAction(Type type) {
    final value = _controller.text;
    switch (type) {
      case UpdateBrokerAddress:
        return UpdateBrokerAddress(value);
      case UpdateBrokerPort:
        return UpdateBrokerPort(value);
      case UpdateBrokerUsername:
        return UpdateBrokerUsername(value);
      case UpdateBrokerPassword:
        return UpdateBrokerPassword(value);
      case UpdateBrokerClientId:
        return UpdateBrokerClientId(value);
      case UpdatePropertiesPublishTopic:
        return UpdatePropertiesPublishTopic(value);
      case UpdateStatusPublishTopic:
        return UpdateStatusPublishTopic(value);
      case UpdatePropertiesRequestPublishTopic:
        return UpdatePropertiesRequestPublishTopic(value);
      case UpdatePropertiesRequestSubscribeTopic:
        return UpdatePropertiesRequestSubscribeTopic(value);
      case UpdateStatusRequestPublishTopic:
        return UpdateStatusRequestPublishTopic(value);
      case UpdateStatusRequestSubscribeTopic:
        return UpdateStatusRequestSubscribeTopic(value);
      case UpdateTrafficRequestPublishTopic:
        return UpdateTrafficRequestPublishTopic(value);
      case UpdateTrafficRequestSubscribeTopic:
        return UpdateTrafficRequestSubscribeTopic(value);
    }

    assert(false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}