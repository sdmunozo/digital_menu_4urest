import 'package:digital_menu_4urest/widgets/custom_tab_widget.dart';
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
              height: 75, //28
            ),
            CustomTabWidget()
            //SearchWidget(),
          ],
        ),
      ),
    );
  }
}
