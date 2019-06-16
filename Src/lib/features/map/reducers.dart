/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:redux/redux.dart';
import 'package:vsa/features/map/actions.dart';
import 'package:vsa/features/map/state.dart';

final Reducer<MapState> mapStateReducer = combineReducers([
    TypedReducer<MapState, UpdateUserGpsPoint>(_updateUserGpsPointReducer),
  ]);

MapState _updateUserGpsPointReducer(MapState state, UpdateUserGpsPoint action) => state.rebuild((b) => b
  ..userGpsPoint.replace(action.point));