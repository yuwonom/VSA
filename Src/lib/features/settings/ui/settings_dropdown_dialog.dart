/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:vsa/state.dart';
import 'package:vsa/themes/theme.dart';
import 'package:vsa/themes/vsa_button.dart';

class SettingsDropdownDialog extends StatefulWidget {
  const SettingsDropdownDialog({
    @required this.title,
    @required this.value,
    @required this.values,
    @required this.onChanged,
  }) : assert(title != null && value != null && values != null && onChanged != null);

  final String title;
  final String value;
  final List<String> values;
  final ValueChanged<String> onChanged;

  @override
  _SettingsDropdownDialogState createState() => _SettingsDropdownDialogState();
}

class _SettingsDropdownDialogState extends State<SettingsDropdownDialog> {
  String _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value;
  }

  @override
  Widget build(BuildContext context) => StoreBuilder(builder: _buildPage);

  Widget _buildPage(BuildContext context, Store<AppState> store) {
    final title = Padding(
      padding: AppEdges.smallAll,
      child: Text(
        widget.title,
        style: AppTextStyles.subtitle1.copyWith(color: AppColors.black),
        textAlign: TextAlign.center,
      ),
    );

    final tiles = Column(
      children: widget.values.map((String value) => Material(
        color: value == _selectedValue
          ? AppColors.gray : AppColors.white,
        child: ListTile(
          contentPadding: AppEdges.smallHorizontal,
          enabled: value != _selectedValue,
          title: Text(value, style: AppTextStyles.body1.copyWith(color: AppColors.black)),
          trailing: value == _selectedValue
            ? Icon(Icons.check, color: AppColors.green) : null,
          onTap: () {
            setState(() => _selectedValue = value);
            widget.onChanged(_selectedValue);
          },
        ),
      )).toList(),  
    );

    final okButton = Padding(
      padding: AppEdges.mediumHorizontal,
      child: VSAButton(
        text: "OK",
        type: VSAButtonType.secondary,
        onPressed: () => Navigator.pop(context),
      ),
    );

    final contents = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        title,
        tiles,
        okButton,
      ],
    );

    final container = Card(
      color: AppColors.white,
      elevation: 3.0,
      shape: AppBorders.bezel,
      margin: AppEdges.mediumHorizontal,
      child: Padding(
        padding: AppEdges.smallVertical,
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
}