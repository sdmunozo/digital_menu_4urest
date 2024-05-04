import 'package:digital_menu_4urest/models/item_model.dart';

class CategoryModel {
  String id;
  String name;
  String description;
  String icon;
  List<ItemModel> items;
  List<ItemModel> products;
  String sectionType;

  CategoryModel({
    this.id = '',
    this.name = '',
    this.description = '',
    this.icon = '',
    this.items = const [],
    this.products = const [],
    this.sectionType = 'vertical',
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
        sectionType: json.containsKey("sectionType")
            ? json["sectionType"].toString()
            : 'vertical',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "icon": icon,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "sectionType": sectionType,
      };
}


/*import 'package:digital_menu_4urest/models/item_model.dart';

class CategoryModel {
  String id;
  String name;
  String description;
  String icon;
  List<ItemModel> items;
  List<ItemModel> products;
  bool sectionType;

  CategoryModel({
    this.id = '',
    this.name = '',
    this.description = '',
    this.icon = '',
    this.items = const [],
    this.products = const [],
    this.sectionType = true,
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
        sectionType: json.containsKey("sectionType")
            ? json["sectionType"] ?? true
            : true,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "icon": icon,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "sectionType": sectionType,
      };
}

*/