import 'dart:async';

import 'package:digital_menu_4urest/models/branch_catalog_model.dart';
import 'package:digital_menu_4urest/models/category_model.dart';
import 'package:digital_menu_4urest/models/item_model.dart';
import 'package:digital_menu_4urest/models/metrics/click_event_metric.dart';
import 'package:digital_menu_4urest/models/metrics/view_time_metric.dart';
import 'package:digital_menu_4urest/models/section_size_model.dart';
import 'package:digital_menu_4urest/providers/event_metric_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

class GlobalConfigProvider {
  static bool develop = false;
  static SharedPreferences? prefs;
  static String userId = '';
  static String sessionId = '';
  static String lastUrlSegment = '';
  static BranchCatalogModel? branchCatalog;
  static double maxHeight = 0;
  static double maxWidth = 0;
  static List<SectionSizeModel> sectionSizes = [];
  static Color backgroundColor = const Color(0xFFF6F9FA);
  static double sectionVerticalItemHeight = 200;
  static double sectionHorizontalItemHeight = 130;
  static int welcomeScreenViewTime = 0;
  static int homeScreenViewTime = 0;
  static int searchResultScreenViewTime = 0;
  static int showItemScreenViewTime = 0;
  static String activeScreen = '';
  static Timer? _timer;
  static Timer? _logTimer;
  static bool _isEventMetricProviderInitialized = false;
  static EventMetricProvider? eventMetricProvider;

  static void initEventMetricProvider(BuildContext context) {
    if (!_isEventMetricProviderInitialized) {
      eventMetricProvider =
          Provider.of<EventMetricProvider>(context, listen: false);
      _isEventMetricProviderInitialized = true;
    }
  }

  static void updateActiveScreen(String screenName) {
    _recordViewTimeMetric();

    if (activeScreen != screenName) {
      activeScreen = screenName;
    }

    // Detener el timer actual
    _timer?.cancel();
    _logTimer?.cancel();

    // Iniciar un nuevo timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      switch (activeScreen) {
        case 'WelcomeScreen':
          welcomeScreenViewTime++;
          break;
        case 'HomeScreen':
          homeScreenViewTime++;
          break;
        case 'SearchResultScreen':
          searchResultScreenViewTime++;
          break;
        case 'ShowItemScreen':
          showItemScreenViewTime++;
          break;
      }
    });

    // Iniciar un timer para el registro cada 5 segundos
    _logTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _recordViewTimeMetric();
    });
  }

  static void _recordViewTimeMetric() {
    String? pageName;
    int? viewTimeSeconds;

    switch (activeScreen) {
      case 'WelcomeScreen':
        pageName = 'WelcomeScreen';
        viewTimeSeconds = welcomeScreenViewTime;
        break;
      case 'HomeScreen':
        pageName = 'HomeScreen';
        viewTimeSeconds = homeScreenViewTime;
        break;
      case 'SearchResultScreen':
        pageName = 'SearchResultScreen';
        viewTimeSeconds = searchResultScreenViewTime;
        break;
      case 'ShowItemScreen':
        pageName = 'ShowItemScreen';
        viewTimeSeconds = showItemScreenViewTime;
        break;
    }

    if (pageName != null && viewTimeSeconds != null) {
      final metric = ViewTimeMetric(
        pageName: pageName,
        viewTimeSeconds: viewTimeSeconds,
      );

      if (!develop) {
        eventMetricProvider?.addMetric(metric);
      }
    }
  }

  static void dispose() {
    _timer?.cancel();
    _logTimer?.cancel();
  }

  static void recordClickEventMetric(
      {required String origin,
      required String clickedElement,
      required String destination}) {
    final metric = ClickEventMetric(
      origin: origin,
      clickedElement: clickedElement,
      destination: destination,
    );

    if (!develop) {
      eventMetricProvider?.addMetric(metric);
    }
  }

  static void generateSectionSizes() {
    List<SectionSizeModel> sizes = [];
    if (branchCatalog != null) {
      for (CategoryModel category in branchCatalog!.catalogs[0].categories) {
        double totalHeight;

        if (category.sectionType == 'horizontal') {
          totalHeight = 300;
        } else {
          totalHeight = 109.5;
          // ignore: unused_local_variable
          for (ItemModel product in category.products) {
            totalHeight += sectionHorizontalItemHeight;
          }
        }

        sizes.add(SectionSizeModel(
            categoryName: category.alias, height: totalHeight));
      }
    }
    sectionSizes = sizes;
  }

  static void setMaxHeight(double height) {
    maxHeight = height;
  }

  static double? getMaxHeight() {
    return maxHeight;
  }

  static void setMaxWidth(double width) {
    maxWidth = width;
  }

  static double? getMaxWidth() {
    return maxWidth;
  }

  static Future<bool> initialize(String segment) async {
    try {
      prefs = await SharedPreferences.getInstance();
      String? storedUserId = prefs!.getString('userId');
      userId = storedUserId ?? const Uuid().v4();
      if (storedUserId == null) {
        await prefs!.setString('userId', userId);
      }

      sessionId = const Uuid().v4();
      await prefs!.setString('sessionId', sessionId);

      return saveLastUrlSegment(segment);
    } catch (e) {
      logMessage('Error initializing GlobalConfigProvider: $e');
      return false;
    }
  }

  static void setBranchCatalog(BranchCatalogModel? catalog) {
    branchCatalog = catalog;
  }

  static bool saveLastUrlSegment(String segment) {
    try {
      segment = segment.split('/').last;
      if (segment.isNotEmpty &&
          segment == segment.toLowerCase() &&
          segment.contains('-')) {
        lastUrlSegment = segment;
        return true;
      } else if (develop) {
        lastUrlSegment = 'dev-mode';
        return true;
      } else {
        lastUrlSegment = 'Invalid URL';
        logMessage('Error GlobalConfigProvider - Invalid URL: $segment');
        return false;
      }
    } catch (e) {
      logMessage('Error en saveLastUrlSegment: $e');
      return false;
    }
  }

  static void logMessage(String message) {
    if (develop) {
      // ignore: avoid_print
      print(message);
    }
  }

  static void launchUrlLink(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      logMessage('No se pudo lanzar $url');
    }
  }
}
