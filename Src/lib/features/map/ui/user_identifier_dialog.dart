/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:vsa/features/map/actions.dart';
import 'package:vsa/features/settings/actions.dart';
import 'package:vsa/features/settings/dtos.dart';
import 'package:vsa/state.dart';
import 'package:vsa/themes/theme.dart';
import 'package:vsa/themes/vsa_button.dart';

class UserIdentifierDialog extends StatefulWidget {
  const UserIdentifierDialog(this.broker);

  final BrokerDto broker;

  @override
  _UserIdentifierDialogState createState() => _UserIdentifierDialogState();
}

class _UserIdentifierDialogState extends State<UserIdentifierDialog> {
  TextEditingController _controller;
  bool _hasReceivedInput;
  
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _hasReceivedInput = false;
  }

  @override
  Widget build(BuildContext context) => StoreBuilder(builder: _buildPage);

  Widget _buildPage(BuildContext context, Store<AppState> store) {
    final isValid = _controller.text.isNotEmpty;
    final showErrorMessage = !isValid && _hasReceivedInput;

    final title = Text(
      "Set Your Unique Identifier",
      style: AppTextStyles.subtitle1.copyWith(color: AppColors.black),
      textAlign: TextAlign.left,
      maxLines: 1,
    );

    final caption = Text(
      "You need to set a unique identifier for the broker to identify and exchange the correct information.",
      style: AppTextStyles.body2.copyWith(color: AppColors.darkGray),
      textAlign: TextAlign.left,
    );
    
    final textField = TextField(
      autofocus: true,
      autocorrect: false,
      controller: _controller,
      onChanged: (String _) => setState(() => _hasReceivedInput = true),
    );

    final errorText = Text(
      "Identifier cannot be empty.",
      style: AppTextStyles.body1.copyWith(color: AppColors.red),
      textAlign: TextAlign.left,
      maxLines: 2,
      softWrap: true,
    );

    final startButton = VSAButton(
      text: "Start",
      type: VSAButtonType.secondary,
      enabled: isValid,
      onPressed: () {
        store.dispatch(UpdateSettings(UpdateVehicleId, _controller.text));
        Navigator.pop(context);
        
        store.dispatch(ConnectToMqttBroker(
          widget.broker.address,
          _controller.text,
          username: widget.broker.username,
          password: widget.broker.password,
        ));
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
        startButton,
        cancelButton,
      ],
    );

    final contents = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: AppEdges.smallVertical,
          child: title,
        ),
        Padding(
          padding: AppEdges.noneAll,
          child: caption,
        ),
        Padding(
          padding: AppEdges.smallVertical,
          child: textField,
        ),
        Opacity(
          opacity: showErrorMessage ? 1 : 0,
          child: errorText,
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}