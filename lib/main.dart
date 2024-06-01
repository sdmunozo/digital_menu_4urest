import 'package:digital_menu_4urest/providers/branch_catalog_provider.dart';
import 'package:digital_menu_4urest/providers/event_metric_provider.dart';
import 'package:digital_menu_4urest/providers/orders/order_summary_controller.dart';
import 'package:digital_menu_4urest/screens/not_found_screen.dart';
import 'package:digital_menu_4urest/screens/sliver_home_screen.dart';
import 'package:digital_menu_4urest/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfigProvider.initialize(Uri.base.path);

  //debugPaintSizeEnabled = true;

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    GlobalConfigProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(OrderSummaryController());
    //Get.put(OrderController());
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BranchCatalogProvider.instance..fetchBranchCatalog(),
        ),
        ChangeNotifierProvider(
          create: (_) => EventMetricProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Menu Digital',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Consumer<BranchCatalogProvider>(
              builder: (context, provider, child) {
            if (provider.hasError) {
              return const NotFoundScreen();
            }
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return const SliverHomeScreen();
            //return const WelcomeScreen();
            //return AddressSearchWidget();
          }),
        ),
      ),
    );
  }
}

/*

import 'package:digital_menu_4urest/providers/branch_catalog_provider.dart';
import 'package:digital_menu_4urest/providers/event_metric_provider.dart';
import 'package:digital_menu_4urest/providers/order_controller.dart';
import 'package:digital_menu_4urest/screens/not_found_screen.dart';
import 'package:digital_menu_4urest/screens/sliver_home_screen.dart';
import 'package:digital_menu_4urest/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfigProvider.initialize(Uri.base.path);

  //debugPaintSizeEnabled = true;

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    GlobalConfigProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(OrderController());
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BranchCatalogProvider.instance..fetchBranchCatalog(),
        ),
        ChangeNotifierProvider(
          create: (_) => EventMetricProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Menu Digital',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Consumer<BranchCatalogProvider>(
              builder: (context, provider, child) {
            if (provider.hasError) {
              return const NotFoundScreen();
            }
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return const SliverHomeScreen();
            //return const WelcomeScreen();
          }),
        ),
      ),
    );
  }
}

*/



/* RESPALDO INDEX HTML
<!DOCTYPE html>
<html>
<head>
  <!--
    If you are serving your web app in a path other than the root, change the
    href value below to reflect the base path you are serving from.

    The path provided below has to start and end with a slash "/" in order for
    it to work correctly.

    For more details:
    * https://developer.mozilla.org/en-US/docs/Web/HTML/Element/base

    This is a placeholder for base href that will be replaced by the value of
    the `--base-href` argument provided to `flutter build`.
  -->
  <base href="$FLUTTER_BASE_HREF">

  <meta charset="UTF-8">
  <meta content="IE=Edge" http-equiv="X-UA-Compatible">
  <meta name="description" content="Menú Digital y completamente interactivo de 4uRest">

  <!-- iOS meta tags & icons -->
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <meta name="apple-mobile-web-app-title" content="Menú Digital de 4uRest">
  <link rel="apple-touch-icon" href="icons/Icon-192.png">

  <!-- Favicon -->
  <link rel="icon" type="image/png" href="favicon.png"/>

  <title>Menú Interactivo de 4uRest</title>
  <link rel="manifest" href="manifest.json">
</head>
<body>
  <script src="flutter_bootstrap.js" async></script>
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCB1tV5EwwGaT7A9wtI9CCrjQtTyk8qabY"></script>
</body>
</html>

 */