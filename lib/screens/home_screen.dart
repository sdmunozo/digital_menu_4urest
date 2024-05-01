import 'package:digital_menu_4urest/layout/main_layout.dart';
import 'package:digital_menu_4urest/models/branch_catalog_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.branchCatalogModel,
  });

  final BranchCatalogModel branchCatalogModel;

  @override
  Widget build(BuildContext context) {
    return const MainLayout(
        child: Stack(
      children: [
        Column(
          children: [Text("Hola Mundo")],
        ),
      ],
    ));
  }
}
