import 'package:digital_menu_4urest/models/digital_menu/base_model_modifiers_group.dart';

class BaseModelProduct {
  String id;
  String alias;
  String description;
  String image;
  int sort;
  double price;
  List<BaseModelModifiersGroup> modifiersGroups;
  String status;

  BaseModelProduct({
    this.id = '',
    this.alias = '',
    this.description = '',
    this.image = '',
    this.sort = 0,
    this.price = 0.0,
    this.modifiersGroups = const [],
    this.status = 'Active',
  });

  factory BaseModelProduct.fromJson(Map<String, dynamic> json) =>
      BaseModelProduct(
        id: json["id"] ?? '',
        alias: json["alias"] ?? '',
        description: json["description"] ?? '',
        image: json["image"] ?? '',
        sort: json["sort"] ?? 0,
        price: (json["price"] ?? 0.0).toDouble() ?? 0.0,
        modifiersGroups: List<BaseModelModifiersGroup>.from(
            json["modifiersGroups"]
                    ?.map((x) => BaseModelModifiersGroup.fromJson(x)) ??
                []),
        status: json["status"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "alias": alias,
        "description": description,
        "image": image,
        "sort": sort,
        "price": price,
        "modifiersGroups":
            List<dynamic>.from(modifiersGroups.map((x) => x.toJson())),
        "status": status,
      };

  BaseModelProduct copy() => BaseModelProduct(
        id: id,
        alias: alias,
        description: description,
        image: image,
        sort: sort,
        price: price,
        modifiersGroups: List<BaseModelModifiersGroup>.from(
            modifiersGroups.map((group) => group.copy())),
        status: status,
      );
}
