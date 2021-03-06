/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:vsa/state.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

// Contains information about the currently active application.
ApplicationInformation applicationInformation;

/// Encapsulates all "global" pieces of state for an application run.
class ApplicationInformation {
  final Widget applicationWidget;
  final GlobalKey scaffoldKey;
  final Store<AppState> store;

  ApplicationInformation(this.applicationWidget, this.scaffoldKey, this.store);
}
