import 'package:digital_menu_4urest/models/digital_menu/base_model_banner.dart';
import 'package:digital_menu_4urest/models/digital_menu/base_model_catalog.dart';
import 'package:digital_menu_4urest/models/digital_menu/base_model_delivery_type.dart';
import 'package:digital_menu_4urest/models/digital_menu/base_model_payment_method.dart';
import 'package:digital_menu_4urest/models/digital_menu/base_model_recommendation.dart';

class BaseModelBranch {
  String id;
  String name;
  String normalizedDigitalMenu;
  String digitalMenuLink;
  String qrCodePath;
  String whatsApp;
  List<BaseModelCatalog> catalogs;
  List<BaseModelRecommendation> recommendations;
  List<BaseModelBanner> banners;
  List<BaseModelPaymentMethod> paymentMethods;
  List<BaseModelDeliveryType> deliveryTypes;

  BaseModelBranch({
    this.id = '',
    this.name = '',
    this.normalizedDigitalMenu = '',
    this.digitalMenuLink = '',
    this.qrCodePath = '',
    this.whatsApp = '',
    this.catalogs = const [],
    this.recommendations = const [],
    this.banners = const [],
    this.paymentMethods = const [],
    this.deliveryTypes = const [],
  });

  factory BaseModelBranch.fromJson(Map<String, dynamic> json) =>
      BaseModelBranch(
        id: json["id"] ?? '',
        name: json["name"] ?? '',
        normalizedDigitalMenu: json["normalizedDigitalMenu"] ?? '',
        digitalMenuLink: json["digitalMenuLink"] ?? '',
        qrCodePath: json["qrCodePath"] ?? '',
        whatsApp: json["whatsApp"] ?? '',
        catalogs: List<BaseModelCatalog>.from(
            json["catalogs"].map((x) => BaseModelCatalog.fromJson(x)) ?? []),
        recommendations: List<BaseModelRecommendation>.from(
            json["recommendations"]
                    .map((x) => BaseModelRecommendation.fromJson(x)) ??
                []),
        banners: List<BaseModelBanner>.from(
            json["banners"].map((x) => BaseModelBanner.fromJson(x)) ?? []),
        paymentMethods: List<BaseModelPaymentMethod>.from(json["paymentMethods"]
                .map((x) => BaseModelPaymentMethod.fromJson(x)) ??
            []),
        deliveryTypes: List<BaseModelDeliveryType>.from(json["deliveryTypes"]
                .map((x) => BaseModelDeliveryType.fromJson(x)) ??
            []),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "normalizedDigitalMenu": normalizedDigitalMenu,
        "digitalMenuLink": digitalMenuLink,
        "qrCodePath": qrCodePath,
        "whatsApp": whatsApp,
        "catalogs": List<dynamic>.from(catalogs.map((x) => x.toJson())),
        "recommendations":
            List<dynamic>.from(recommendations.map((x) => x.toJson())),
        "banners": List<dynamic>.from(banners.map((x) => x.toJson())),
        "paymentMethods":
            List<dynamic>.from(paymentMethods.map((x) => x.toJson())),
        "deliveryTypes":
            List<dynamic>.from(deliveryTypes.map((x) => x.toJson())),
      };
}
