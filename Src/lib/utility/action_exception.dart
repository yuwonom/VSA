/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:meta/meta.dart';

/// An exception that was caused by the execution of an action.
@immutable
class ActionException implements Exception {
  final Exception exception;
  final Object action;

  const ActionException(this.exception, this.action)
      : assert(exception != null),
        assert(action != null);

  @override
  String toString() => "ActionException{action: $action, exception: $exception}";
}
