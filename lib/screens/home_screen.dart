import 'package:digital_menu_4urest/widgets/custom_tab_widget.dart';
import 'package:digital_menu_4urest/widgets/horizontal_section_widget.dart';
import 'package:digital_menu_4urest/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:digital_menu_4urest/layout/main_layout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Container(
        //color: const Color(0xfffafafa),
        child: Column(
          children: [
            Container(
              color: const Color(0xfffafafa),
              height: 26, //28
            ),
            Container(
                color: const Color(0xfffafafa), child: const SearchWidget()),
            Container(
              color: const Color(0xfffafafa),
              child: const Row(
                children: [
                  CustomTabWidget(
                    title: "Promociones",
                    isActive: true,
                  ),
                  CustomTabWidget(
                    title: "Favoritos",
                    isActive: false,
                  ),
                ],
              ),
            ),
            const HorizontalSectionWidget(
              title: "Promociones",
              description:
                  'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el ',
            ),
            const HorizontalSectionWidget(
              title: "Favoritos",
              description:
                  'Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el ',
            ),
          ],
        ),
      ),
    );
  }
}
