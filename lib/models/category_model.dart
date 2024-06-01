import 'package:digital_menu_4urest/models/product_model.dart';

class CategoryModel {
  String id;
  String alias;
  String description;
  String image;
  List<ProductModel> items;
  List<ProductModel> products;
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
        items: List<ProductModel>.from(
            json["items"]?.map((x) => ProductModel.fromJson(x)) ?? []),
        products: List<ProductModel>.from(
            json["products"]?.map((x) => ProductModel.fromJson(x)) ?? []),
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
