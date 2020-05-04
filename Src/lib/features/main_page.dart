/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:vsa/features/settings/actions.dart';
import 'package:vsa/state.dart';
import 'package:vsa/themes/theme.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => StoreBuilder<AppState>(
      onInit: (Store<AppState> store) => store.dispatch(LoadSettings()),
      builder: _buildPage,
    );

  Widget _buildPage(BuildContext context, Store<AppState> store) {
    final caption = Text("Loading settings...",
      style: AppTextStyles.body1.copyWith(color: AppColors.black),
      textAlign: TextAlign.center,
    );

    final body = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(height: AppLengths.medium),
          caption,
        ],
      ),
    );

    final scaffold = Scaffold(
      backgroundColor: AppColors.white,
      body: body,
    );

    return scaffold;
  }
}