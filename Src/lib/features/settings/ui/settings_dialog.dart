/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:vsa/features/settings/actions.dart';
import 'package:vsa/state.dart';
import 'package:vsa/themes/theme.dart';
import 'package:vsa/themes/vsa_button.dart';

class SettingsDialog extends StatefulWidget {
  const SettingsDialog({
    @required this.title,
    @required this.value,
    @required this.actionType,
    this.validity,
    this.obscureText = false,
  }) : assert(title != null && value != null && actionType != null);

  final String title;
  final String value;
  final Type actionType;
  final bool Function(String) validity;
  final bool obscureText;

  @override
  _SettingsDialogState createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
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
    final isValid = widget.validity == null 
        ? true
        : widget.validity(_controller.text);

    final title = Text(widget.title, style: AppTextStyles.subtitle1.copyWith(color: AppColors.black));
    
    final textField = TextField(
      autofocus: true,
      autocorrect: false,
      controller: _controller,
      obscureText: widget.obscureText,
      onChanged: (String _) => setState((){}),
    );

    final errorText = Text(
      "Please enter value with the correct format.",
      style: AppTextStyles.body1.copyWith(color: AppColors.red),
      textAlign: TextAlign.left,
      maxLines: 2,
      softWrap: true,
    );

    final saveButton = VSAButton(
      text: "Save",
      type: VSAButtonType.secondary,
      enabled: isValid,
      onPressed: () {
        store.dispatch(UpdateSettings(widget.actionType, _controller.text));
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
        Opacity(
          opacity: isValid ? 0 : 1,
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