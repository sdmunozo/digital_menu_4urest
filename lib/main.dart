import 'package:digital_menu_4urest/providers/branch_catalog_provider.dart';
import 'package:digital_menu_4urest/screens/home_screen.dart';
import 'package:digital_menu_4urest/screens/not_found_screen.dart';
import 'package:flutter/material.dart';
import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfigProvider.initialize(Uri.base.path);

  //debugPaintSizeEnabled = true;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BranchCatalogProvider.instance..fetchBranchCatalog(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Menu Digital',
        home: Scaffold(
          body: Consumer<BranchCatalogProvider>(
              builder: (context, provider, child) {
            if (provider.hasError) {
              return const NotFoundScreen();
            }
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return const HomeScreen();
          }),
        ),
      ),
    );
  }
}
