import 'package:digital_menu_4urest/bloc/sliver_home_screen_bloc.dart';
import 'package:digital_menu_4urest/layout/main_layout.dart';
import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:digital_menu_4urest/widgets/custom_tab_widget.dart';
import 'package:digital_menu_4urest/widgets/horizontal_section_widget.dart';
import 'package:digital_menu_4urest/widgets/search_widget.dart';
import 'package:digital_menu_4urest/widgets/vertical_section_widget.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter/rendering.dart';

const _backgroundColor = Color(0xFFF6F9FA);

class SliverHomeScreen extends StatefulWidget {
  const SliverHomeScreen({super.key});

  @override
  State<SliverHomeScreen> createState() => _Test2HomeScreenState();
}

class _Test2HomeScreenState extends State<SliverHomeScreen>
    with TickerProviderStateMixin {
  final _bloc = SliverHomeScreenBLoC();

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
      child: CustomScrollView(
        controller: _bloc.scrollController,
        slivers: [
          SliverPersistentHeader(
            delegate: _HomeScreenDelegate(bloc: _bloc),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: AnimatedBuilder(
              animation: _bloc,
              builder: (_, __) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: ShrinkWrappingViewport(
                      offset: ViewportOffset.zero(),
                      slivers: [
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final category = GlobalConfigProvider
                                  .branchCatalog!.catalogs[0].categories[index];
                              return category.sectionType == "vertical"
                                  ? VerticalSectionWidget(category: category)
                                  : HorizontalSectionWidget(category: category);
                            },
                            childCount: GlobalConfigProvider
                                .branchCatalog!.catalogs[0].categories.length,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}

class ColumnColorsContainer extends StatelessWidget {
  const ColumnColorsContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 300,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 300,
            color: Colors.red,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 300,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 300,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}

const _maxHeaderHeightContainer = 240.0;
const _minHeaderHeightContainer = 97.0;

class _HomeScreenDelegate extends SliverPersistentHeaderDelegate {
  _HomeScreenDelegate({required this.bloc});

  SliverHomeScreenBLoC bloc;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double percent =
        shrinkOffset / (_maxHeaderHeightContainer - _minHeaderHeightContainer);
    percent = math.min(1.0, percent);

    return Stack(fit: StackFit.expand, children: [
      const Positioned(
        top: 0,
        left: 0,
        child: _BannerWidget(),
      ),
      Positioned(
        top: 35,
        left: 12,
        child: _BannerBackWidget(percent: percent),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        child: _DataBrandWidget(percent: percent),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: _TabAndSearchWidget(
          percent: percent,
          bloc: bloc,
        ), // enviar percent
      ),
    ]);
  }

  @override
  double get maxExtent => _maxHeaderHeightContainer;

  @override
  double get minExtent => _minHeaderHeightContainer;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

class _TabAndSearchWidget extends StatelessWidget {
  const _TabAndSearchWidget({required this.percent, required this.bloc});

  final double percent;
  final SliverHomeScreenBLoC bloc;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: percent,
      child: Container(
        height: 97,
        color: _backgroundColor,
        child: Column(
          children: [
            const Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: SearchWidget(),
              ),
            ),
            SizedBox(
              height: 45,
              //color: Colors.amber,
              child: AnimatedBuilder(
                animation: bloc,
                builder: (_, __) => TabBar(
                  onTap: bloc.onCategorySelected,
                  controller: bloc.tabController,
                  isScrollable: true,
                  indicatorColor: const Color.fromARGB(0, 0, 0, 0),
                  tabs: bloc.tabs
                      .map((e) =>
                          CustomTabWidget(title: e.title, isActive: e.isActive))
                      .toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _DataBrandWidget extends StatelessWidget {
  const _DataBrandWidget({
    required this.percent,
  });

  final double percent;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 1 - percent,
      child: Container(
        height: 50,
        width: GlobalConfigProvider.maxWidth,
        decoration: const BoxDecoration(
          color: _backgroundColor,
        ),
        child: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "${GlobalConfigProvider.branchCatalog!.brandName} - ${GlobalConfigProvider.branchCatalog!.branchName}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                  overflow: TextOverflow.ellipsis, // Overflow ellipsis
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: Image.asset(
                    "assets/temp/mcdonalds_logo.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BannerBackWidget extends StatelessWidget {
  const _BannerBackWidget({
    required this.percent,
  });

  final double percent;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 1 - percent,
      child: Container(
        height: 38,
        width: 38,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromARGB(218, 255, 255, 255),
        ),
        child: Center(
          child: Container(
            margin: const EdgeInsets.only(right: 5),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_outlined),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _BannerWidget extends StatelessWidget {
  const _BannerWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 190,
        width: GlobalConfigProvider.maxWidth,
        decoration: const BoxDecoration(),
        child: Image.asset(
          "assets/temp/McDonalds_Banner_4.jpeg",
          fit: BoxFit.cover,
        ));
  }
}



/* ESTRUCTURA MAIN FUNCIONANDO, HEADER/SEARCH-TABS/EXPANDED CONTAINER

import 'package:digital_menu_4urest/bloc/home_screen_bloc.dart';
import 'package:digital_menu_4urest/layout/main_layout.dart';
import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:digital_menu_4urest/widgets/custom_tab_widget.dart';
import 'package:digital_menu_4urest/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter/rendering.dart';

class Test2HomeScreen extends StatefulWidget {
  const Test2HomeScreen({super.key});

  @override
  State<Test2HomeScreen> createState() => _Test2HomeScreenState();
}

class _Test2HomeScreenState extends State<Test2HomeScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  final _bloc = HomeScreenBLoC();

  @override
  void initState() {
    tabController = TabController(vsync: this, length: 10);
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
    return MainLayout(
        child: CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          delegate: _HomeScreenDelegate(tabController: tabController),
          pinned: true,
        ),
        SliverToBoxAdapter(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: ShrinkWrappingViewport(
                    offset: ViewportOffset.zero(),
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            if (index.isOdd) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  height: 300,
                                  color: Colors.white,
                                ),
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  height: 300,
                                  color: Colors.red,
                                ),
                              );
                            }
                          },
                          childCount: 20,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}

class ColumnColorsContainer extends StatelessWidget {
  const ColumnColorsContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 300,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 300,
            color: Colors.red,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 300,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 300,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}

const _maxHeaderHeightContainer = 240.0;
const _minHeaderHeightContainer = 97.0;

class _HomeScreenDelegate extends SliverPersistentHeaderDelegate {
  _HomeScreenDelegate({required this.tabController});

  TabController tabController;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double percent =
        shrinkOffset / (_maxHeaderHeightContainer - _minHeaderHeightContainer);
    percent = math.min(1.0, percent);

    return Stack(fit: StackFit.expand, children: [
      const Positioned(
        top: 0,
        left: 0,
        child: _BannerWidget(),
      ),
      Positioned(
        top: 35,
        left: 12,
        child: _BannerBackWidget(percent: percent),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        child: _DataBrandWidget(percent: percent),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: _TabAndSearchWidget(
            percent: percent, tabController: tabController), // enviar percent
      ),
    ]);
  }

  @override
  double get maxExtent => _maxHeaderHeightContainer;

  @override
  double get minExtent => _minHeaderHeightContainer;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

class _TabAndSearchWidget extends StatelessWidget {
  const _TabAndSearchWidget({
    required this.percent,
    required this.tabController,
  });

  final double percent;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: percent,
      child: Container(
        height: 97,
        color: Colors.white,
        child: Column(
          children: [
            const Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: SearchWidget(),
              ),
            ),
            Container(
              height: 45,
              color: Colors.amber,
              child: TabBar(
                  controller: tabController,
                  isScrollable: true,
                  indicatorColor: const Color.fromARGB(0, 255, 255, 255),
                  tabs: List.generate(
                      10,
                      (index) => CustomTabWidget(
                          title: "Promociones", isActive: (index == 0)))),
            )
          ],
        ),
      ),
    );
  }
}

class _DataBrandWidget extends StatelessWidget {
  const _DataBrandWidget({
    required this.percent,
  });

  final double percent;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 1 - percent,
      child: Container(
        height: 50,
        width: GlobalConfigProvider.maxWidth,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "${GlobalConfigProvider.branchCatalog!.brandName} - ${GlobalConfigProvider.branchCatalog!.branchName}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                  overflow: TextOverflow.ellipsis, // Overflow ellipsis
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: Image.asset(
                    "assets/temp/mcdonalds_logo.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BannerBackWidget extends StatelessWidget {
  const _BannerBackWidget({
    required this.percent,
  });

  final double percent;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 1 - percent,
      child: Container(
        height: 38,
        width: 38,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromARGB(218, 255, 255, 255),
        ),
        child: Center(
          child: Container(
            margin: const EdgeInsets.only(right: 5),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_outlined),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _BannerWidget extends StatelessWidget {
  const _BannerWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 190,
        width: GlobalConfigProvider.maxWidth,
        decoration: const BoxDecoration(),
        child: Image.asset(
          "assets/temp/McDonalds_Banner_4.jpeg",
          fit: BoxFit.cover,
        ));
  }
}


 */


/*

intento mas proximo - no funciona la selecccion de las categorias y pausa al llegar al final

import 'package:digital_menu_4urest/bloc/home_screen_bloc.dart';
import 'package:digital_menu_4urest/layout/main_layout.dart';
import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:digital_menu_4urest/widgets/custom_tab_widget.dart';
import 'package:digital_menu_4urest/widgets/horizontal_section_widget.dart';
import 'package:digital_menu_4urest/widgets/search_widget.dart';
import 'package:digital_menu_4urest/widgets/vertical_section_widget.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

const _backgroundColor = Color(0xFFF6F9FA);

class Test2HomeScreen extends StatefulWidget {
  const Test2HomeScreen({super.key});

  @override
  State<Test2HomeScreen> createState() => _TestHomeScreenState();
}

class _TestHomeScreenState extends State<Test2HomeScreen>
    with TickerProviderStateMixin {
  final _bloc = HomeScreenBLoC();
  bool isFullyCollapsed = false;

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

  void updateCollapseState(bool state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isFullyCollapsed != state) {
        setState(() {
          isFullyCollapsed = state;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
        child: CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          delegate: _HomeScreenDelegate(
              bloc: _bloc, updateCollapseState: updateCollapseState),
          pinned: true,
        ),
        SliverToBoxAdapter(
          child: Container(
            color: _backgroundColor,
            height: 600,
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification notification) {
                return !isFullyCollapsed;
              },
              child: ListView.builder(
                physics: isFullyCollapsed
                    ? AlwaysScrollableScrollPhysics()
                    : NeverScrollableScrollPhysics(),
                controller: _bloc.scrollController,
                itemCount: GlobalConfigProvider
                        .branchCatalog!.catalogs[0].categories.isNotEmpty
                    ? GlobalConfigProvider
                        .branchCatalog!.catalogs[0].categories.length
                    : 0,
                itemBuilder: (context, index) {
                  if (GlobalConfigProvider
                      .branchCatalog!.catalogs[0].categories.isNotEmpty) {
                    final category = GlobalConfigProvider
                        .branchCatalog!.catalogs[0].categories[index];
                    return category.sectionType == "vertical"
                        ? VerticalSectionWidget(category: category)
                        : HorizontalSectionWidget(category: category);
                  } else {
                    return Container(); // Retornar un contenedor vacío o algún widget que indique lista vacía
                  }
                },
              ),
            ),
          ),
        )
      ],
    ));
  }
}

const _maxHeaderHeightContainer = 240.0;
const _minHeaderHeightContainer = 97.0;

class _HomeScreenDelegate extends SliverPersistentHeaderDelegate {
  final HomeScreenBLoC bloc;
  final Function(bool) updateCollapseState;

  _HomeScreenDelegate({required this.bloc, required this.updateCollapseState});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double percent =
        shrinkOffset / (_maxHeaderHeightContainer - _minHeaderHeightContainer);
    percent = math.min(1.0, percent);
    bool isFullyCollapsed = percent >= 1.0;

    updateCollapseState(isFullyCollapsed);

    return Stack(fit: StackFit.expand, children: [
      Positioned(
        top: 0,
        left: 0,
        child: Container(
            height: 190,
            width: GlobalConfigProvider.maxWidth,
            decoration: const BoxDecoration(),
            child: Image.asset(
              "assets/temp/McDonalds_Banner_4.jpeg",
              fit: BoxFit.cover,
            )),
      ),
      Positioned(
        top: 35,
        left: 12,
        child: Opacity(
          opacity: 1 - percent,
          child: Container(
            height: 38,
            width: 38,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(229, 255, 255, 255),
            ),
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(right: 5),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_outlined),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        child: Opacity(
          opacity: 1 - percent,
          child: Container(
            height: 50,
            width: GlobalConfigProvider.maxWidth,
            decoration: BoxDecoration(
              color: _backgroundColor,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "${GlobalConfigProvider.branchCatalog!.brandName} - ${GlobalConfigProvider.branchCatalog!.branchName}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      overflow: TextOverflow.ellipsis, // Overflow ellipsis
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: Image.asset(
                        "assets/temp/mcdonalds_logo.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Opacity(
          opacity: percent,
          child: Container(
            height: 97,
            color: _backgroundColor,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    height: 52,
                    child: SearchWidget(),
                  ),
                ),
                Container(
                  height: 45,
                  //color: Colors.red,
                  child: TabBar(
                    onTap: isFullyCollapsed ? bloc.onCategorySelected : null,
                    //onTap: bloc.onCategorySelected,
                    isScrollable: true,
                    controller: bloc.tabController,
                    indicatorColor: const Color.fromARGB(0, 0, 0, 0),
                    tabs: bloc.tabs
                        .map((e) => CustomTabWidget(
                            title: e.title, isActive: e.isActive))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  @override
  double get maxExtent => _maxHeaderHeightContainer;

  @override
  double get minExtent => _minHeaderHeightContainer;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

*/

/* como lo hizo GPT (MAL)
class TestHomeScreen extends StatefulWidget {
  const TestHomeScreen({super.key});

  @override
  State<TestHomeScreen> createState() => _TestHomeScreenState();
}

class _TestHomeScreenState extends State<TestHomeScreen>
    with TickerProviderStateMixin {
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
    return MainLayout(
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: _HomeScreenDelegate(bloc: _bloc),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 800,
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
    );
  }
}

const _maxHeaderHeightContainer = 240.0;
const _minHeaderHeightContainer = 97.0;

class _HomeScreenDelegate extends SliverPersistentHeaderDelegate {
  final HomeScreenBLoC bloc;

  _HomeScreenDelegate({required this.bloc});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double percent =
        shrinkOffset / (_maxHeaderHeightContainer - _minHeaderHeightContainer);
    percent = math.min(1.0, percent);

    return Stack(fit: StackFit.expand, children: [
      // Coloca aquí cualquier otro contenido estático o animado que necesites
      Positioned(
        bottom: 50,
        left: 0,
        right: 0,
        child: Opacity(
          opacity: 1 - percent,
          child: Container(
            height: 45,
            child: TabBar(
              onTap: bloc.onCategorySelected,
              isScrollable: true,
              controller: bloc.tabController,
              indicatorColor: const Color.fromARGB(0, 0, 0, 0),
              tabs: bloc.tabs
                  .map((e) =>
                      CustomTabWidget(title: e.title, isActive: e.isActive))
                  .toList(),
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Opacity(
          opacity: percent,
          child: Container(
            height: 52,
            child: SearchWidget(),
          ),
        ),
      ),
    ]);
  }

  @override
  double get maxExtent => _maxHeaderHeightContainer;

  @override
  double get minExtent => _minHeaderHeightContainer;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

*/

/*

Implementacion personal nada que ver con HomeScreen, Primera aplicacion de slaves

class TestHomeScreen extends StatefulWidget {
  const TestHomeScreen({super.key});

  @override
  State<TestHomeScreen> createState() => _TestHomeScreenState();
}

class _TestHomeScreenState extends State<TestHomeScreen>
    with TickerProviderStateMixin {
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
    return MainLayout(
        child: CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          delegate: _HomeScreenDelegate(),
          pinned: true,
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 800,
          ),
        )
      ],
    ));
  }
}

const _maxHeaderHeightContainer = 240.0;
const _minHeaderHeightContainer = 97.0;

class _HomeScreenDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double percent =
        shrinkOffset / (_maxHeaderHeightContainer - _minHeaderHeightContainer);
    percent = math.min(1.0, percent);

    return Stack(fit: StackFit.expand, children: [
      Positioned(
        top: 0,
        left: 0,
        child: Container(
            height: 190,
            width: GlobalConfigProvider.maxWidth,
            decoration: const BoxDecoration(),
            child: Image.asset(
              "assets/tools/restaurant_background.png",
              fit: BoxFit.cover,
            )),
      ),
      Positioned(
        top: 35,
        left: 12,
        child: Opacity(
          opacity: 1 - percent,
          child: Container(
            height: 38,
            width: 38,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(218, 255, 255, 255),
            ),
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(right: 5),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_outlined),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        child: Opacity(
          opacity: 1 - percent,
          child: Container(
            height: 50,
            width: GlobalConfigProvider.maxWidth,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "${GlobalConfigProvider.branchCatalog!.brandName} - ${GlobalConfigProvider.branchCatalog!.branchName}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      overflow: TextOverflow.ellipsis, // Overflow ellipsis
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: Image.asset(
                        "assets/tools/restaurant_background.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Opacity(
          opacity: percent,
          child: Container(
            height: 97,
            color: Colors.white,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    height: 52,
                    child: SearchWidget(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  @override
  double get maxExtent => _maxHeaderHeightContainer;

  @override
  double get minExtent => _minHeaderHeightContainer;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
*/


// search widget 52
// tabbar 45
// total 97




/*
import 'package:digital_menu_4urest/layout/main_layout.dart';
import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:digital_menu_4urest/widgets/search_widget.dart';
import 'package:digital_menu_4urest/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class TestHomeScreen extends StatelessWidget {
  const TestHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
        child: CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          delegate: _HomeScreenDelegate(),
          pinned: true,
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 800,
          ),
        )
      ],
    ));
  }
}

const _maxHeaderHeightContainer = 240.0;
const _minHeaderHeightContainer = 97.0;

class _HomeScreenDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double percent =
        shrinkOffset / (_maxHeaderHeightContainer - _minHeaderHeightContainer);
    percent = math.min(1.0, percent);

    return Stack(fit: StackFit.expand, children: [
      Positioned(
        top: 0,
        left: 0,
        child: Container(
            height: 190,
            width: GlobalConfigProvider.maxWidth,
            decoration: const BoxDecoration(),
            child: Image.asset(
              "assets/tools/restaurant_background.png",
              fit: BoxFit.cover,
            )),
      ),
      Positioned(
        top: 35,
        left: 12,
        child: Opacity(
          opacity: 1 - percent,
          child: Container(
            height: 38,
            width: 38,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(218, 255, 255, 255),
            ),
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(right: 5),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_outlined),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        child: Opacity(
          opacity: 1 - percent,
          child: Container(
            height: 50,
            width: GlobalConfigProvider.maxWidth,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "${GlobalConfigProvider.branchCatalog!.brandName} - ${GlobalConfigProvider.branchCatalog!.branchName}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      overflow: TextOverflow.ellipsis, // Overflow ellipsis
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: Image.asset(
                        "assets/tools/restaurant_background.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Opacity(
          opacity: percent,
          child: Container(
            height: 97,
            color: Colors.white,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    height: 52,
                    child: SearchWidget(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  @override
  double get maxExtent => _maxHeaderHeightContainer;

  @override
  double get minExtent => _minHeaderHeightContainer;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}


 */





/* IMPLEMENTACION SOLO DEL TABBAR

import 'package:digital_menu_4urest/bloc/home_screen_bloc.dart';
import 'package:digital_menu_4urest/layout/main_layout.dart';
import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:digital_menu_4urest/widgets/custom_tab_widget.dart';
import 'package:digital_menu_4urest/widgets/horizontal_section_widget.dart';
import 'package:digital_menu_4urest/widgets/search_widget.dart';
import 'package:digital_menu_4urest/widgets/vertical_section_widget.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class TestHomeScreen extends StatefulWidget {
  const TestHomeScreen({super.key});

  @override
  State<TestHomeScreen> createState() => _TestHomeScreenState();
}

class _TestHomeScreenState extends State<TestHomeScreen>
    with TickerProviderStateMixin {
  final _bloc = HomeScreenBLoC();
  late TabController tabController;

  @override
  void initState() {
    _bloc.init(this);
    tabController = TabController(vsync: this, length: 5);
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
        child: CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          delegate: _HomeScreenDelegate(bloc: _bloc),
          pinned: true,
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 1500,
          ),
        )
      ],
    ));
  }
}

const _maxHeaderHeightContainer = 240.0;
const _minHeaderHeightContainer = 97.0;

class _HomeScreenDelegate extends SliverPersistentHeaderDelegate {
  final HomeScreenBLoC bloc;
  //final TabController tabController;

  _HomeScreenDelegate({required this.bloc});
  //_HomeScreenDelegate({required this.tabController});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double percent =
        shrinkOffset / (_maxHeaderHeightContainer - _minHeaderHeightContainer);
    percent = math.min(1.0, percent);

    return Stack(fit: StackFit.expand, children: [
      Positioned(
        top: 0,
        left: 0,
        child: Container(
            height: 190,
            width: GlobalConfigProvider.maxWidth,
            decoration: const BoxDecoration(),
            child: Image.asset(
              "assets/tools/restaurant_background.png",
              fit: BoxFit.cover,
            )),
      ),
      Positioned(
        top: 35,
        left: 12,
        child: Opacity(
          opacity: 1 - percent,
          child: Container(
            height: 38,
            width: 38,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(218, 255, 255, 255),
            ),
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(right: 5),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_outlined),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        child: Opacity(
          opacity: 1 - percent,
          child: Container(
            height: 50,
            width: GlobalConfigProvider.maxWidth,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "${GlobalConfigProvider.branchCatalog!.brandName} - ${GlobalConfigProvider.branchCatalog!.branchName}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      overflow: TextOverflow.ellipsis, // Overflow ellipsis
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: Image.asset(
                        "assets/tools/restaurant_background.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Opacity(
          opacity: 1 - percent, // es solo percent
          child: Container(
            height: 97,
            color: Colors.white,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    height: 52,
                    child: SearchWidget(),
                  ),
                ),
                Container(
                  height: 45,
                  color: Colors.red,
                  child: TabBar(
                    onTap: bloc.onCategorySelected,
                    isScrollable: true,
                    controller: bloc.tabController,
                    indicatorColor: const Color.fromARGB(0, 0, 0, 0),
                    tabs: bloc.tabs
                        .map((e) => CustomTabWidget(
                            title: e.title, isActive: e.isActive))
                        .toList(),
                  ),

                  /*
                  child: TabBar(
                      isScrollable: true,
                      controller: bloc.tabController,
                      tabs: List.generate(
                          10,
                          (index) => CustomTabWidget(
                              title: "title", isActive: false))),*/
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  @override
  double get maxExtent => _maxHeaderHeightContainer;

  @override
  double get minExtent => _minHeaderHeightContainer;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}


 */