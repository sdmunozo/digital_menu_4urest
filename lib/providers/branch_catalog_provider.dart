import 'dart:convert';
import 'package:digital_menu_4urest/api/api_4uRest.dart';
import 'package:digital_menu_4urest/models/branch_catalog_model.dart';
import 'package:digital_menu_4urest/models/category_model.dart';
import 'package:digital_menu_4urest/models/item_model.dart';
import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

class BranchCatalogProvider extends ChangeNotifier {
  static BranchCatalogProvider? _instance;

  bool _isLoading = false;
  late BranchCatalogModel _branchCatalog;
  bool _hasError = false;
  bool _isCatalogLoaded = false;

  BranchCatalogProvider._privateConstructor();

  static BranchCatalogProvider get instance {
    _instance ??= BranchCatalogProvider._privateConstructor();
    return _instance!;
  }

  bool get isLoading => _isLoading;
  BranchCatalogModel get branchCatalog => _branchCatalog;
  bool get hasError => _hasError;

  Future<void> fetchBranchCatalog() async {
    if (_isCatalogLoaded) return;

    _hasError = false;
    if (GlobalConfigProvider.lastUrlSegment == 'Invalid URL') {
      _hasError = true;
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      GlobalConfigProvider.logMessage(
          '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -');
      GlobalConfigProvider.logMessage(
          '- - - - - - - - - - MODO DESARROLLO - - - - - - - - - - - - - - -');
      GlobalConfigProvider.logMessage(
          '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -');
      if (GlobalConfigProvider.develop) {
        final jsonString =
            await rootBundle.loadString('assets/dev/branch_catalog.json');
        final jsonData = json.decode(jsonString);
        _branchCatalog = BranchCatalogModel.fromJson(jsonData);
      } else {
        final response = await Api4uRest.httpGet(
            '/digital-menu/get-digital-menu/${GlobalConfigProvider.lastUrlSegment}');
        _branchCatalog = BranchCatalogModel.fromJson(response);
      }

      // Agregar categoría de recomendaciones si hay recomendaciones
      if (_branchCatalog.recommendations.isNotEmpty) {
        const uuid = Uuid();
        final recommendationsCategory = CategoryModel(
          id: uuid.v4(),
          alias: "Recomendaciones",
          description:
              "Descubre nuestros productos estrella que te cautivarán desde el primer instante. ¡Sabores que no puedes perderte!",
          image: "",
          items: [],
          products: [],
          sectionType: "horizontal",
        );

        // Buscar los productos recomendados y agregarlos a la nueva categoría
        final recommendedProducts = <ItemModel>[];
        for (var recommendation in _branchCatalog.recommendations) {
          for (var catalog in _branchCatalog.catalogs) {
            for (var category in catalog.categories) {
              var product = category.products.firstWhere(
                (product) => product.id == recommendation.productId,
                orElse: () =>
                    ItemModel(), // retorna un item vacío si no se encuentra
              );
              if (product.id.isNotEmpty) {
                recommendedProducts.add(product);
              }
            }
          }
        }
        recommendationsCategory.products.addAll(recommendedProducts);

        // Agregar la categoría de recomendaciones al primer catálogo
        if (_branchCatalog.catalogs.isNotEmpty) {
          _branchCatalog.catalogs[0].categories
              .insert(0, recommendationsCategory);
        }
      }

      GlobalConfigProvider.setBranchCatalog(_branchCatalog);
      _isCatalogLoaded = true;
    } catch (e) {
      _hasError = true;
      GlobalConfigProvider.logMessage('Error fetching branch catalog: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}



/* Se agrego la categoria recomendations
import 'dart:convert';
import 'package:digital_menu_4urest/api/api_4uRest.dart';
import 'package:digital_menu_4urest/models/branch_catalog_model.dart';
import 'package:digital_menu_4urest/models/category_model.dart';
import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

class BranchCatalogProvider extends ChangeNotifier {
  static BranchCatalogProvider? _instance;

  bool _isLoading = false;
  late BranchCatalogModel _branchCatalog;
  bool _hasError = false;
  bool _isCatalogLoaded = false;

  BranchCatalogProvider._privateConstructor();

  static BranchCatalogProvider get instance {
    _instance ??= BranchCatalogProvider._privateConstructor();
    return _instance!;
  }

  bool get isLoading => _isLoading;
  BranchCatalogModel get branchCatalog => _branchCatalog;
  bool get hasError => _hasError;

  Future<void> fetchBranchCatalog() async {
    if (_isCatalogLoaded) return;

    _hasError = false;
    if (GlobalConfigProvider.lastUrlSegment == 'Invalid URL') {
      _hasError = true;
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      GlobalConfigProvider.logMessage(
          '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -');
      GlobalConfigProvider.logMessage(
          '- - - - - - - - - - MODO DESARROLLO - - - - - - - - - - - - - - -');
      GlobalConfigProvider.logMessage(
          '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -');
      if (GlobalConfigProvider.develop) {
        final jsonString =
            await rootBundle.loadString('assets/dev/branch_catalog.json');
        final jsonData = json.decode(jsonString);
        _branchCatalog = BranchCatalogModel.fromJson(jsonData);
      } else {
        final response = await Api4uRest.httpGet(
            '/digital-menu/get-digital-menu/${GlobalConfigProvider.lastUrlSegment}');
        _branchCatalog = BranchCatalogModel.fromJson(response);
      }

      // Agregar categoría de recomendaciones si hay recomendaciones
      if (_branchCatalog.recommendations.isNotEmpty) {
        const uuid = Uuid();
        final recommendationsCategory = CategoryModel(
          id: uuid.v4(),
          alias: "Recomendaciones",
          description:
              "Descubre nuestros productos estrella que te cautivarán desde el primer instante. ¡Sabores que no puedes perderte!",
          image: "",
          items: [],
          products: [],
          sectionType: "horizontal",
        );

        if (_branchCatalog.catalogs.isNotEmpty) {
          _branchCatalog.catalogs[0].categories
              .insert(0, recommendationsCategory);
        }
      }

      GlobalConfigProvider.setBranchCatalog(_branchCatalog);
      _isCatalogLoaded = true;
    } catch (e) {
      _hasError = true;
      GlobalConfigProvider.logMessage('Error fetching branch catalog: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}


*/

/*

import 'dart:convert';

import 'package:digital_menu_4urest/api/api_4uRest.dart';
import 'package:digital_menu_4urest/models/branch_catalog_model.dart';
import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BranchCatalogProvider extends ChangeNotifier {
  static BranchCatalogProvider? _instance;

  bool _isLoading = false;
  late BranchCatalogModel _branchCatalog;
  bool _hasError = false;
  bool _isCatalogLoaded = false;

  BranchCatalogProvider._privateConstructor();

  static BranchCatalogProvider get instance {
    _instance ??= BranchCatalogProvider._privateConstructor();
    return _instance!;
  }

  bool get isLoading => _isLoading;
  BranchCatalogModel get branchCatalog => _branchCatalog;
  bool get hasError => _hasError;

  Future<void> fetchBranchCatalog() async {
    if (_isCatalogLoaded) return;

    _hasError = false;
    if (GlobalConfigProvider.lastUrlSegment == 'Invalid URL') {
      _hasError = true;
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      GlobalConfigProvider.logMessage(
          '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -');
      GlobalConfigProvider.logMessage(
          '- - - - - - - - - - MODO DESARROLLO - - - - - - - - - - - - - - -');
      GlobalConfigProvider.logMessage(
          '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -');
      if (GlobalConfigProvider.develop) {
        final jsonString =
            await rootBundle.loadString('assets/dev/branch_catalog.json');
        final jsonData = json.decode(jsonString);
        _branchCatalog = BranchCatalogModel.fromJson(jsonData);
      } else {
        final response = await Api4uRest.httpGet(
            '/digital-menu/get-digital-menu/${GlobalConfigProvider.lastUrlSegment}');
        _branchCatalog = BranchCatalogModel.fromJson(response);
      }
      GlobalConfigProvider.setBranchCatalog(_branchCatalog);
      _isCatalogLoaded = true;
    } catch (e) {
      _hasError = true;
      GlobalConfigProvider.logMessage('Error fetching branch catalog: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}


*/