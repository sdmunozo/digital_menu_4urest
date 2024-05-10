import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class RouteAwareState<T extends StatefulWidget> extends State<T>
    with RouteAware {
  String get screenName;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route is PageRoute) {
      final RouteObserver<PageRoute> routeObserver =
          Provider.of<RouteObserver<PageRoute>>(context, listen: false);
      routeObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    final route = ModalRoute.of(context);
    if (route is PageRoute) {
      final RouteObserver<PageRoute> routeObserver =
          Provider.of<RouteObserver<PageRoute>>(context, listen: false);
      routeObserver.unsubscribe(this);
    }
    super.dispose();
  }

  @override
  void didPush() {
    super.didPush();
    GlobalConfigProvider.updateActiveScreen(screenName);
  }

  @override
  void didPopNext() {
    super.didPopNext();
    GlobalConfigProvider.updateActiveScreen(screenName);
  }
}


/*

import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class RouteAwareState<T extends StatefulWidget> extends State<T>
    with RouteAware {
  String get screenName;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route is PageRoute) {
      final RouteObserver<PageRoute> routeObserver =
          Provider.of<RouteObserver<PageRoute>>(context, listen: false);
      routeObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    final route = ModalRoute.of(context);
    if (route is PageRoute) {
      final RouteObserver<PageRoute> routeObserver =
          Provider.of<RouteObserver<PageRoute>>(context, listen: false);
      routeObserver.unsubscribe(this);
    }
    super.dispose();
  }

  @override
  void didPush() {
    super.didPush();
    GlobalConfigProvider.updateActiveScreen(screenName);
  }

  @override
  void didPopNext() {
    super.didPopNext();
    GlobalConfigProvider.updateActiveScreen(screenName);
  }
}

*/