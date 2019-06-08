import 'package:vsa/globals.dart';
import 'package:vsa/middleware.dart';
import 'package:vsa/reducers.dart';
import 'package:vsa/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

ApplicationInformation createApplicationInformation(Apis apis, NavigatorObserver navigatorObserver) {
  final appKey = GlobalKey(debugLabel: "app");
  final navigatorKey = GlobalKey<NavigatorState>(debugLabel: "navigator");

  // Do not use this to navigate to tabs of TopLevelWidget, use NavigateMainTo action instead.
  final routes = <String, WidgetBuilder>{};

  final materialApp = MaterialApp(
    title: "VSA",
    key: appKey,
    home: Container(),
    navigatorKey: navigatorKey,
    navigatorObservers: [navigatorObserver],
    routes: routes,
  );

  final middleware = getMiddleware(apis, navigatorKey);

  final store = Store<AppState>(
    appStateReducer,
    initialState: AppState.initial(),
    middleware: middleware,
  );

  final storeProvider = StoreProvider<AppState>(
    store: store,
    child: materialApp,
  );

  return ApplicationInformation(apis, storeProvider, navigatorKey, store);
}

class CompositeNavigatorObserver extends NavigatorObserver {
  final List<NavigatorObserver> _observers;

  CompositeNavigatorObserver() : _observers = <NavigatorObserver>[];

  void addObserver(NavigatorObserver observer) => _observers.add(observer);

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    for (var observer in _observers) {
      observer.didPush(route, previousRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    for (var observer in _observers) {
      observer.didPop(route, previousRoute);
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {
    for (var observer in _observers) {
      observer.didRemove(route, previousRoute);
    }
  }

  @override
  void didReplace({Route<dynamic> oldRoute, Route<dynamic> newRoute}) {
    for (var observer in _observers) {
      observer.didReplace(oldRoute: oldRoute, newRoute: newRoute);
    }
  }
}