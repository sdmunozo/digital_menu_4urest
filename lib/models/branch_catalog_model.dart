import 'dart:convert';

import 'package:digital_menu_4urest/models/banner_model.dart';
import 'package:digital_menu_4urest/models/catalog_model.dart';
import 'package:digital_menu_4urest/models/orders/delivery_type.dart';
import 'package:digital_menu_4urest/models/orders/payment_method_model.dart';
import 'package:digital_menu_4urest/models/recommendations_model.dart';

BranchCatalogModel branchCatalogResponseFromJson(String str) =>
    BranchCatalogModel.fromJson(json.decode(str));

String branchCatalogResponseToJson(BranchCatalogModel data) =>
    json.encode(data.toJson());

class BranchCatalogModel {
  String brandId;
  String branchId;
  String brandName;
  String branchName;
  String instagramLink;
  String facebookLink;
  String websiteLink;
  String brandLogo;
  String brandSlogan;
  String brandWhatsApp;
  String menuBackground;
  List<BannerModel> banners;
  List<CatalogModel> catalogs;
  List<RecommendationsModel> recommendations;
  List<PaymentMethodModel> paymentMethods;
  List<DeliveryTypeModel> deliveryTypes;

  BranchCatalogModel({
    this.brandId = '',
    this.branchId = '',
    this.brandName = '',
    this.branchName = '',
    this.instagramLink = '',
    this.facebookLink = '',
    this.websiteLink = '',
    this.brandLogo = '',
    this.brandSlogan = '',
    this.brandWhatsApp = '',
    this.menuBackground = '',
    this.banners = const [],
    this.catalogs = const [],
    this.recommendations = const [],
    this.paymentMethods = const [], // Inicialización
    this.deliveryTypes = const [], // Inicialización
  });

  factory BranchCatalogModel.fromJson(Map<String, dynamic> json) =>
      BranchCatalogModel(
        brandId: json["brandId"] ?? '',
        branchId: json["branchId"] ?? '',
        brandName: json["brandName"] ?? '',
        branchName: json["branchName"] ?? '',
        instagramLink: json["instagramLink"] ?? '',
        facebookLink: json["facebookLink"] ?? '',
        websiteLink: json["websiteLink"] ?? '',
        brandLogo: json["brandLogo"] ?? '',
        brandSlogan: json["brandSlogan"] ?? '',
        brandWhatsApp: json["brandWhatsApp"] ?? '',
        menuBackground: json["menuBackground"] ?? '',
        banners: List<BannerModel>.from(
            json["banners"]?.map((x) => BannerModel.fromJson(x)) ?? []),
        catalogs: List<CatalogModel>.from(
            json["catalogs"]?.map((x) => CatalogModel.fromJson(x)) ?? []),
        recommendations: List<RecommendationsModel>.from(json["recommendations"]
                ?.map((x) => RecommendationsModel.fromJson(x)) ??
            []),
        paymentMethods: List<PaymentMethodModel>.from(json["paymentMethods"]
                ?.map((x) => PaymentMethodModel.fromJson(x)) ??
            []), // Carga desde JSON
        deliveryTypes: List<DeliveryTypeModel>.from(
            json["deliveryTypes"]?.map((x) => DeliveryTypeModel.fromJson(x)) ??
                []), // Carga desde JSON
      );

  Map<String, dynamic> toJson() => {
        "brandId": brandId,
        "branchId": branchId,
        "brandName": brandName,
        "branchName": branchName,
        "instagramLink": instagramLink,
        "facebookLink": facebookLink,
        "websiteLink": websiteLink,
        "brandLogo": brandLogo,
        "brandSlogan": brandSlogan,
        "brandWhatsApp": brandWhatsApp,
        "menuBackground": menuBackground,
        "banners": List<dynamic>.from(banners.map((x) => x.toJson())),
        "catalogs": List<dynamic>.from(catalogs.map((x) => x.toJson())),
        "recommendations":
            List<dynamic>.from(recommendations.map((x) => x.toJson())),
        "paymentMethods": List<dynamic>.from(
            paymentMethods.map((x) => x.toJson())), // Conversión a JSON
        "deliveryTypes": List<dynamic>.from(
            deliveryTypes.map((x) => x.toJson())), // Conversión a JSON
      };
}


/*
class BranchCatalogModel {
  String brandId;
  String branchId;
  String brandName;
  String branchName;
  String instagramLink;
  String facebookLink;
  String websiteLink;
  String brandLogo;
  String brandSlogan;
  String brandWhatsApp;
  String menuBackground;
  List<BannerModel> banners;
  List<CatalogModel> catalogs;
  List<RecommendationsModel> recommendations;

  BranchCatalogModel({
    this.brandId = '',
    this.branchId = '',
    this.brandName = '',
    this.branchName = '',
    this.instagramLink = '',
    this.facebookLink = '',
    this.websiteLink = '',
    this.brandLogo = '',
    this.brandSlogan = '',
    this.brandWhatsApp = '',
    this.menuBackground = '',
    this.banners = const [],
    this.catalogs = const [],
    this.recommendations = const [],
  });

  factory BranchCatalogModel.fromJson(Map<String, dynamic> json) =>
      BranchCatalogModel(
        brandId: json["brandId"] ?? '',
        branchId: json["branchId"] ?? '',
        brandName: json["brandName"] ?? '',
        branchName: json["branchName"] ?? '',
        instagramLink: json["instagramLink"] ?? '',
        facebookLink: json["facebookLink"] ?? '',
        websiteLink: json["websiteLink"] ?? '',
        brandLogo: json["brandLogo"] ?? '',
        brandSlogan: json["brandSlogan"] ?? '',
        brandWhatsApp: json["brandWhatsApp"] ?? '',
        menuBackground: json["menuBackground"] ?? '',
        banners: List<BannerModel>.from(
            json["banners"]?.map((x) => BannerModel.fromJson(x)) ?? []),
        catalogs: List<CatalogModel>.from(
            json["catalogs"]?.map((x) => CatalogModel.fromJson(x)) ?? []),
        recommendations: List<RecommendationsModel>.from(json["recommendations"]
                ?.map((x) => RecommendationsModel.fromJson(x)) ??
            []),
      );

  Map<String, dynamic> toJson() => {
        "brandId": brandId,
        "branchId": branchId,
        "brandName": brandName,
        "branchName": branchName,
        "instagramLink": instagramLink,
        "facebookLink": facebookLink,
        "websiteLink": websiteLink,
        "brandLogo": brandLogo,
        "brandSlogan": brandSlogan,
        "brandWhatsApp": brandWhatsApp,
        "menuBackground": menuBackground,
        "banners": List<dynamic>.from(banners.map((x) => x.toJson())),
        "catalogs": List<dynamic>.from(catalogs.map((x) => x.toJson())),
        "recommendations":
            List<dynamic>.from(recommendations.map((x) => x.toJson())),
      };
}
*/