import 'package:digital_menu_4urest/models/digital_menu/base_model_category.dart';

class BaseModelCatalog {
  String id;
  String alias;
  String description;
  String image;
  List<BaseModelCategory> categories;

  BaseModelCatalog({
    this.id = '',
    this.alias = '',
    this.description = '',
    this.image = '',
    this.categories = const [],
  });

  factory BaseModelCatalog.fromJson(Map<String, dynamic> json) =>
      BaseModelCatalog(
        id: json["id"] ?? '',
        alias: json["alias"] ?? '',
        description: json["description"] ?? '',
        image: json["image"] ?? '',
        categories: List<BaseModelCategory>.from(
            json["categories"].map((x) => BaseModelCategory.fromJson(x)) ?? []),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "alias": alias,
        "description": description,
        "image": image,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}
