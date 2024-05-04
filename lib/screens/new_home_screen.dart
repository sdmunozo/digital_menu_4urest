import 'package:digital_menu_4urest/layout/main_layout.dart';
import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:digital_menu_4urest/providers/image_provider.dart';
import 'package:digital_menu_4urest/scroll_project/Presentation/Declarations/constants.dart';
import 'package:digital_menu_4urest/widgets/search_widget.dart';
import 'package:flutter/material.dart';

class NewHomeScreen extends StatelessWidget {
  const NewHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainLayout(
      child: CustomScrollView(
        slivers: [
          CustomSliverAppBar(),
          SearchBarAppBar(),
          SliverItemList(),
        ],
      ),
    );
  }
}

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      pinned: true,
      centerTitle: false,
      expandedHeight: 200.0,
      flexibleSpace: FlexibleSpaceBar(
        background: Image(
          image: CustomImageProvider.getNetworkImageIP(
              GlobalConfigProvider.branchCatalog!.menuBackground),
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}

class SearchBarAppBar extends StatelessWidget {
  const SearchBarAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      pinned: true,
      bottom: const PreferredSize(
          preferredSize: Size.fromHeight(-10.0), child: SizedBox()),
      flexibleSpace: const SearchWidget(),
    );
  }
}

class SliverItemList extends StatelessWidget {
  const SliverItemList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return const ItemTile();
        },
        childCount: 20,
      ),
    );
  }
}

class ItemTile extends StatelessWidget {
  const ItemTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: kSpacing, bottom: 20, right: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: kBorderRadius,
          color: secondaryColor.withOpacity(0.3),
        ),
        height: 200,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
