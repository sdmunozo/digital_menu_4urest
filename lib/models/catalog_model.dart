import 'package:digital_menu_4urest/models/category_model.dart';

class CatalogModel {
  String id;
  String name;
  String description;
  String icon;
  List<CategoryModel> categories;

  CatalogModel({
    this.id = '',
    this.name = '',
    this.description = '',
    this.icon = '',
    this.categories = const [],
  });

  factory CatalogModel.fromJson(Map<String, dynamic> json) => CatalogModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        icon: json["icon"],
        categories: List<CategoryModel>.from(
            json["categories"]?.map((x) => CategoryModel.fromJson(x)) ?? []),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "icon": icon,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}
