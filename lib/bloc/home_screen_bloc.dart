import 'package:digital_menu_4urest/models/category_model.dart';
import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:digital_menu_4urest/widgets/custom_tab_widget.dart';
import 'package:digital_menu_4urest/widgets/horizontal_section_widget.dart';
import 'package:digital_menu_4urest/widgets/vertical_section_widget.dart';
import 'package:flutter/material.dart';

class HomeScreenBLoC with ChangeNotifier {
  List<CustomTabWidget> tabs = [];
  late TabController tabController;
  List<TypeMenuSection> items = [];
  ScrollController scrollController = ScrollController();
  bool listen = true;

  List<CategoryModel> categories =
      GlobalConfigProvider.branchCatalog!.catalogs[0].categories;

  void init(TickerProvider ticker) {
    tabController = TabController(length: categories.length, vsync: ticker);
    for (int i = 0; i < categories.length; i++) {
      if (i > 0) {}

      tabs.add(CustomTabWidget(title: categories[i].name, isActive: (i == 0)));
    }

    scrollController.addListener(onScrollListener);
  }

  void onScrollListener() {
    double currentOffset = scrollController.offset;
    double maxScrollExtent = scrollController.position.maxScrollExtent;
    double accumulatedHeight = 0;

    if (listen) {
      if (currentOffset >= maxScrollExtent) {
        int lastIndex = categories.length - 1;
        onCategorySelected(lastIndex, animationRequired: false);
        tabController.animateTo(lastIndex);
      } else {
        for (int i = 0; i < categories.length; i++) {
          accumulatedHeight += GlobalConfigProvider.sectionSizes[i].height;
          if (currentOffset < accumulatedHeight) {
            onCategorySelected(i, animationRequired: false);
            tabController.animateTo(i);
            break;
          }
        }
      }
    }
  }

  void onCategorySelected(int index, {bool animationRequired = true}) async {
    double offsetSelectedCategory = 0;
    bool addOffset = true;

    for (int i = 0; i < tabs.length; i++) {
      tabs[i] = CustomTabWidget(
        title: tabs[i].title,
        isActive: index == i,
      );
      if (index == i) {
        addOffset = false;
      }

      if (addOffset) {
        offsetSelectedCategory += GlobalConfigProvider.sectionSizes[i].height;
      }
    }
    notifyListeners();

    if (animationRequired) {
      listen = false;
      await scrollController.animateTo(offsetSelectedCategory,
          duration: const Duration(milliseconds: 500),
          curve: Curves.decelerate);
    }
    listen = true;
  }

  @override
  void dispose() {
    scrollController.removeListener((onScrollListener));
    scrollController.dispose();
    tabController.dispose();
    super.dispose();
  }
}

class TypeMenuSection {
  final VerticalSectionWidget? verticalSection;
  final HorizontalSectionWidget? horizontalSection;

  TypeMenuSection({this.verticalSection, this.horizontalSection});

  bool get isVertical => verticalSection != null;
}

/*
  void onScrollListener() {
    double currentOffset = scrollController.offset;
    double accumulatedHeight = 0;

    if (listen) {
      for (int i = 0; i < categories.length; i++) {
        accumulatedHeight += GlobalConfigProvider.sectionSizes[i].height;
        if (currentOffset < accumulatedHeight) {
          onCategorySelected(i, animationRequired: false);
          tabController.animateTo(i);
          break;
        }
      }
    }
  }
*/