import 'dart:async';

import 'package:digital_menu_4urest/bloc/sliver_home_screen_bloc.dart';
import 'package:digital_menu_4urest/layout/main_layout.dart';
import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:digital_menu_4urest/providers/image_provider.dart';
import 'package:digital_menu_4urest/widgets/custom_tab_widget.dart';
import 'package:digital_menu_4urest/widgets/horizontal_section_widget.dart';
import 'package:digital_menu_4urest/widgets/static_search_widget.dart';
import 'package:digital_menu_4urest/widgets/vertical_section_widget.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter/rendering.dart';

class SliverHomeScreen extends StatefulWidget {
  const SliverHomeScreen({super.key});

  @override
  State<SliverHomeScreen> createState() => _SliverHomeScreenState();
}

class _SliverHomeScreenState extends State<SliverHomeScreen>
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    GlobalConfigProvider.updateActiveScreen("HomeScreen");
  }

  @override
  Widget build(BuildContext context) {
    GlobalConfigProvider.generateSectionSizes();
    return MainLayout(
        child: Container(
      color: GlobalConfigProvider.backgroundColor,
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
        child: BannerWidget(),
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
        color: GlobalConfigProvider.backgroundColor,
        child: Column(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: StaticSearchWidget(
                  onPressed: () {
                    GlobalConfigProvider.updateActiveScreen("WelcomeScreen");
                    Navigator.pop(context);
                  },
                ),
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
        decoration: BoxDecoration(
          color: GlobalConfigProvider.backgroundColor,
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
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: CustomImageProvider.getNetworkImageIP(
                            GlobalConfigProvider.branchCatalog!.brandLogo),
                        fit: BoxFit.cover,
                      ),
                    ),
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
                GlobalConfigProvider.updateActiveScreen("WelcomeScreen");
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
    );
  }
}

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage <
          GlobalConfigProvider.branchCatalog!.banners.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: 190,
      width: GlobalConfigProvider.maxWidth,
      child: PageView.builder(
        controller: _pageController,
        itemCount: GlobalConfigProvider.branchCatalog!.banners.length,
        itemBuilder: (context, index) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            child: SizedBox(
              key: ValueKey<String>(
                  GlobalConfigProvider.branchCatalog!.banners[index].image),
              height: 190,
              width: GlobalConfigProvider.maxWidth,
              child: FadeInImage(
                placeholder: const AssetImage('assets/tools/loading.gif'),
                image: CustomImageProvider.getNetworkImageIP(
                    GlobalConfigProvider.branchCatalog!.banners[index].image),
                fit: BoxFit.fill,
                fadeInDuration: const Duration(milliseconds: 200),
                fadeOutDuration: const Duration(milliseconds: 200),
              ),
            ),
          );
        },
      ),
    );
  }
}



/*
class _BannerWidget extends StatefulWidget {
  const _BannerWidget();

  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<_BannerWidget> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage <
          GlobalConfigProvider.branchCatalog!.banners.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 10),
        curve: Curves.linear,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190,
      width: GlobalConfigProvider.maxWidth,
      child: PageView.builder(
        controller: _pageController,
        itemCount: GlobalConfigProvider.branchCatalog!.banners.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CustomImageProvider.getNetworkImageIP(
                    GlobalConfigProvider.branchCatalog!.banners[index].image),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
*/