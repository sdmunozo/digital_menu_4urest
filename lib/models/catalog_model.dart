import 'package:digital_menu_4urest/models/category_model.dart';

class CatalogModel {
  String id;
  String alias;
  String description;
  String image;
  List<CategoryModel> categories;

  CatalogModel({
    this.id = '',
    this.alias = '',
    this.description = '',
    this.image = '',
    this.categories = const [],
  });

  factory CatalogModel.fromJson(Map<String, dynamic> json) => CatalogModel(
        id: json["id"],
        alias: json["alias"],
        description: json["description"],
        image: json["image"],
        categories: List<CategoryModel>.from(
            json["categories"]?.map((x) => CategoryModel.fromJson(x)) ?? []),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "alias": alias,
        "description": description,
        "image": image,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}
