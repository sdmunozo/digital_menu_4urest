import 'package:digital_menu_4urest/models/modifiers_group_model.dart';

class ProductModel {
  String id;
  String alias;
  String description;
  String image;
  String price;
  List<ModifiersGroupModel> modifiersGroups;

  ProductModel({
    this.id = '',
    this.alias = '',
    this.description = '',
    this.image = '',
    this.price = '0',
    this.modifiersGroups = const [],
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        alias: json["alias"],
        description: json["description"],
        image: json["image"],
        price: (json["price"] ?? "").isEmpty ? "0" : json["price"],
        modifiersGroups: List<ModifiersGroupModel>.from(json["modifiersGroups"]
                ?.map((x) => ModifiersGroupModel.fromJson(x)) ??
            []),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "alias": alias,
        "description": description,
        "image": image,
        "price": price,
        "modifiersGroups":
            List<dynamic>.from(modifiersGroups.map((x) => x.toJson())),
      };

  ProductModel copy() => ProductModel(
        id: id,
        alias: alias,
        description: description,
        image: image,
        price: price,
        modifiersGroups: List<ModifiersGroupModel>.from(
            modifiersGroups.map((group) => group.copy())),
      );
}



/*import 'package:digital_menu_4urest/models/modifiers_group_model.dart';

class ProductModel {
  String id;
  String alias;
  String description;
  String image;
  String price;
  List<ModifiersGroupModel> modifiersGroups;

  ProductModel({
    this.id = '',
    this.alias = '',
    this.description = '',
    this.image = '',
    this.price = '0',
    this.modifiersGroups = const [],
  });
  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        alias: json["alias"],
        description: json["description"],
        image: json["image"],
        price: (json["price"] ?? "").isEmpty ? "0" : json["price"],
        modifiersGroups: List<ModifiersGroupModel>.from(json["modifiersGroups"]
                ?.map((x) => ModifiersGroupModel.fromJson(x)) ??
            []),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "alias": alias,
        "description": description,
        "image": image,
        "price": price,
        "modifiersGroups":
            List<dynamic>.from(modifiersGroups.map((x) => x.toJson())),
      };
}

*/