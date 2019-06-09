/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:vsa/state.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

// Contains information about the currently active application.
ApplicationInformation applicationInformation;

/// Encapsulates APIs from all features.
class Apis {
  const Apis();
}

/// Encapsulates all "global" pieces of state for an application run.
class ApplicationInformation {
  final Apis apis;
  final Widget applicationWidget;
  final GlobalKey scaffoldKey;
  final Store<AppState> store;

  ApplicationInformation(this.apis, this.applicationWidget, this.scaffoldKey, this.store);
}
