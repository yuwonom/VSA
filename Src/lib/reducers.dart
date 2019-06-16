/// Authored by `@yuwonom (Michael Yuwono)`

import 'package:vsa/features/map/reducers.dart';
import 'package:vsa/state.dart';
import 'package:redux/redux.dart';

final Reducer<AppState> appStateReducer = combineReducers([
    TypedReducer<AppState, dynamic>(_childStateReducer),
  ]);

AppState _childStateReducer(AppState state, dynamic action) => state.rebuild((b) => b
  ..map.replace(mapStateReducer(state.map, action)));