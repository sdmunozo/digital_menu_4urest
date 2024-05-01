import 'package:digital_menu_4urest/models/item_model.dart';

class CategoryModel {
  String id;
  String name;
  String description;
  String icon;
  List<ItemModel> items;
  List<ItemModel> products;

  CategoryModel({
    this.id = '',
    this.name = '',
    this.description = '',
    this.icon = '',
    this.items = const [],
    this.products = const [],
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        icon: json["icon"],
        items: List<ItemModel>.from(
            json["items"]?.map((x) => ItemModel.fromJson(x)) ?? []),
        products: List<ItemModel>.from(
            json["products"]?.map((x) => ItemModel.fromJson(x)) ?? []),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "icon": icon,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}
