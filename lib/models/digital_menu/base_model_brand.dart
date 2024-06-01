import 'package:digital_menu_4urest/models/digital_menu/base_model_branch.dart';

class BaseModelBrand {
  String id;
  String name;
  String logo;
  String slogan;
  String instagram;
  String facebook;
  String website;
  String menuBackground;
  List<BaseModelBranch> branches;

  BaseModelBrand({
    this.id = '',
    this.name = '',
    this.logo = '',
    this.slogan = '',
    this.instagram = '',
    this.facebook = '',
    this.website = '',
    this.menuBackground = '',
    this.branches = const [],
  });

  factory BaseModelBrand.fromJson(Map<String, dynamic> json) => BaseModelBrand(
        id: json["id"] ?? '',
        name: json["name"] ?? '',
        logo: json["logo"] ?? '',
        slogan: json["slogan"] ?? '',
        instagram: json["instagram"] ?? '',
        facebook: json["facebook"] ?? '',
        website: json["website"] ?? '',
        menuBackground: json["menuBackground"] ?? '',
        branches: List<BaseModelBranch>.from(
            json["branches"].map((x) => BaseModelBranch.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo": logo,
        "slogan": slogan,
        "instagram": instagram,
        "facebook": facebook,
        "website": website,
        "menuBackground": menuBackground,
        "branches": List<dynamic>.from(branches.map((x) => x.toJson())),
      };
}
