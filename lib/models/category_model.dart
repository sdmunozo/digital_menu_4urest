import 'package:digital_menu_4urest/models/item_model.dart';

class CategoryModel {
  String id;
  String alias;
  String description;
  String image;
  List<ItemModel> items;
  List<ItemModel> products;
  String sectionType;

  CategoryModel({
    this.id = '',
    this.alias = '',
    this.description = '',
    this.image = '',
    this.items = const [],
    this.products = const [],
    this.sectionType = 'vertical',
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        alias: json["alias"],
        description: json["description"],
        image: json["image"],
        items: List<ItemModel>.from(
            json["items"]?.map((x) => ItemModel.fromJson(x)) ?? []),
        products: List<ItemModel>.from(
            json["products"]?.map((x) => ItemModel.fromJson(x)) ?? []),
        sectionType: json.containsKey("sectionType")
            ? json["sectionType"].toString()
            : 'vertical',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "alias": alias,
        "description": description,
        "image": image,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "sectionType": sectionType,
      };
}
