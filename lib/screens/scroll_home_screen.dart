import 'package:digital_menu_4urest/layout/main_layout.dart';
import 'package:digital_menu_4urest/scroll_project/Presentation/Declarations/constants.dart';
import 'package:digital_menu_4urest/widgets/search_widget.dart';
import 'package:flutter/material.dart';

class ScrollHomeScreen extends StatelessWidget {
  const ScrollHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            pinned: true,
            centerTitle: false,
            expandedHeight: 200.0,
            flexibleSpace: const FlexibleSpaceBar(
              background: Image(
                image: AssetImage("assets/tools/restaurant_background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverAppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            pinned: true,
            bottom: const PreferredSize(
                preferredSize: Size.fromHeight(-10.0), child: SizedBox()),
            flexibleSpace: const SearchWidget(),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Padding(
                  padding:
                      EdgeInsets.only(left: kSpacing, bottom: 20, right: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: kBorderRadius,
                        color: secondaryColor.withOpacity(0.3)),
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                  ));
            },
            childCount: 20,
          ))
        ],
      ),
    );
  }
}
