import 'dart:convert';

import 'package:digital_menu_4urest/models/catalog_model.dart';

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
  String menuBackground;
  List<CatalogModel> catalogs;

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
    this.menuBackground = '',
    this.catalogs = const [],
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
        menuBackground: json["menuBackground"] ?? '',
        catalogs: List<CatalogModel>.from(
            json["catalogs"]?.map((x) => CatalogModel.fromJson(x)) ?? []),
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
        "menuBackground": menuBackground,
        "catalogs": List<dynamic>.from(catalogs.map((x) => x.toJson())),
      };
}
