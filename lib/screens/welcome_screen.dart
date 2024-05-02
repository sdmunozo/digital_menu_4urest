import 'package:digital_menu_4urest/widgets/footer_4urest_widget.dart';
import 'package:digital_menu_4urest/widgets/social_media_widget.dart';
import 'package:digital_menu_4urest/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:digital_menu_4urest/layout/main_layout.dart';
import 'package:digital_menu_4urest/screens/home_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Column(
        children: [
          const SizedBox(height: 50),
          const TitleWidget(),
          const SizedBox(height: 50),
          const SocialMediaWidget(),
          const SizedBox(height: 40),
          Material(
            color: const Color(0xFFE57734),
            borderRadius: BorderRadius.circular(100),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
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
          const Footer4urestWidget(isRow: false),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}



/*import 'package:digital_menu_4urest/layout/main_layout.dart';
import 'package:digital_menu_4urest/screens/home_screen.dart';
import 'package:digital_menu_4urest/widgets/footer_4urest_widget.dart';
import 'package:digital_menu_4urest/widgets/social_media_widget.dart';
import 'package:digital_menu_4urest/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Column(
        children: [
          const SizedBox(height: 50),
          const TitleWidget(),
          const SizedBox(height: 50),
          const SocialMediaWidget(),
          const SizedBox(height: 40),
          Material(
            color: const Color(0xFFE57734),
            borderRadius: BorderRadius.circular(100),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
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
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

*/

/*
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
          const SizedBox(height: 50),
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
                    builder: (context) => HomeScreen(),
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
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

 */