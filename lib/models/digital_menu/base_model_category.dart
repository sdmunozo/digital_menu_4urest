import 'package:digital_menu_4urest/models/digital_menu/base_model_product.dart';

class BaseModelCategory {
  String id;
  String alias;
  String description;
  String image;
  int sort;
  String sectionType;
  List<BaseModelProduct> products;

  BaseModelCategory({
    this.id = '',
    this.alias = '',
    this.description = '',
    this.image = '',
    this.sort = 0,
    this.sectionType = 'vertical',
    this.products = const [],
  });

  factory BaseModelCategory.fromJson(Map<String, dynamic> json) =>
      BaseModelCategory(
        id: json["id"] ?? '',
        alias: json["alias"] ?? '',
        description: json["description"] ?? '',
        image: json["image"] ?? '',
        sort: json["sort"] ?? '',
        sectionType: json.containsKey("sectionType")
            ? json["sectionType"].toString()
            : 'vertical',
        products: List<BaseModelProduct>.from(
            json["products"].map((x) => BaseModelProduct.fromJson(x)) ?? []),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "alias": alias,
        "description": description,
        "image": image,
        "sort": sort,
        "sectionType": sectionType,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}
