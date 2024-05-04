import 'package:digital_menu_4urest/models/branch_catalog_model.dart';
import 'package:digital_menu_4urest/models/category_model.dart';
import 'package:digital_menu_4urest/models/item_model.dart';
import 'package:digital_menu_4urest/models/section_size_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

class GlobalConfigProvider {
  static SharedPreferences? prefs;
  static String userId = '';
  static String sessionId = '';
  static String lastUrlSegment = '';
  static bool develop = true;
  static BranchCatalogModel? branchCatalog;
  static double? maxHeight;
  static double? maxWidth;
  static List<SectionSizeModel> sectionSizes = [];

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
            totalHeight += 120;
          }
        }

        sizes.add(
            SectionSizeModel(categoryName: category.name, height: totalHeight));
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
      logError('Error initializing GlobalConfigProvider: $e');
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
        logError('Error GlobalConfigProvider - Invalid URL: $segment');
        return false;
      }
    } catch (e) {
      logError('Error en saveLastUrlSegment: $e');
      return false;
    }
  }

  static void logError(String message) {
    if (develop) {
      // ignore: avoid_print
      print(message);
    }
  }

  static void launchUrlLink(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      logError('No se pudo lanzar $url');
    }
  }
}
