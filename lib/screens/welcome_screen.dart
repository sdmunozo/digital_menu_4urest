import 'package:digital_menu_4urest/layout/main_layout.dart';
import 'package:digital_menu_4urest/models/branch_catalog_model.dart';
import 'package:digital_menu_4urest/screens/home_screen.dart';
import 'package:digital_menu_4urest/widgets/footer_4urest_widget.dart';
import 'package:digital_menu_4urest/widgets/social_media_widget.dart';
import 'package:digital_menu_4urest/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({
    super.key,
    required this.branchCatalogModel,
  });

  final BranchCatalogModel branchCatalogModel;

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Column(
        children: [
          TitleWidget(branchCatalogModel: branchCatalogModel),
          const SizedBox(height: 50),
          SocialMediaWidget(
            branchCatalogModel: branchCatalogModel,
          ),
          const SizedBox(height: 40),
          Material(
            color: const Color(0xFFE57734),
            borderRadius: BorderRadius.circular(100),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(
                      branchCatalogModel: branchCatalogModel,
                    ),
                  ),
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                decoration: const BoxDecoration(),
                child: const Text(
                  "Ver Menú",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),
          const Footer4urestWidget(
            isRow: false,
          ),
        ],
      ),
    );
  }
}
