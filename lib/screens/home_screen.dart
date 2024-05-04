import 'package:digital_menu_4urest/bloc/home_screen_bloc.dart';
import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:digital_menu_4urest/widgets/custom_tab_widget.dart';
import 'package:digital_menu_4urest/widgets/horizontal_section_widget.dart';
import 'package:digital_menu_4urest/widgets/vertical_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:digital_menu_4urest/layout/main_layout.dart';

const _backgroundColor = Color(0xFFF6F9FA);
const _blueColor = Color(0xFF0d1863);

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final _bloc = HomeScreenBLoC();

  @override
  void initState() {
    _bloc.init(this);
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GlobalConfigProvider.generateSectionSizes();

    return MainLayout(
      child: Container(
        color: _backgroundColor,
        child: AnimatedBuilder(
          animation: _bloc,
          builder: (_, __) => Column(
            children: [
              SizedBox(
                height: 100,
                child: Center(
                  child: Text(
                    '${GlobalConfigProvider.branchCatalog!.brandName} - ${GlobalConfigProvider.branchCatalog!.branchName}',
                    style: const TextStyle(
                        color: _blueColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              SizedBox(
                height: 45,
                child: TabBar(
                  onTap: _bloc.onCategorySelected,
                  isScrollable: true,
                  controller: _bloc.tabController,
                  indicatorColor: const Color.fromARGB(0, 0, 0, 0),
                  tabs: _bloc.tabs
                      .map((e) =>
                          CustomTabWidget(title: e.title, isActive: e.isActive))
                      .toList(),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: ListView.builder(
                    controller: _bloc.scrollController,
                    itemCount: GlobalConfigProvider
                        .branchCatalog!.catalogs[0].categories.length,
                    itemBuilder: (context, index) {
                      final category = GlobalConfigProvider
                          .branchCatalog!.catalogs[0].categories[index];
                      return category.sectionType == "vertical"
                          ? VerticalSectionWidget(category: category)
                          : HorizontalSectionWidget(category: category);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
