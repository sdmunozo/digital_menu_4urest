import 'package:digital_menu_4urest/models/modifiers_group_model.dart';

class ItemModel {
  String id;
  String alias;
  String description;
  String image;
  String price;
  String isDisplayed;
  List<ModifiersGroupModel> modifiersGroups;

  ItemModel({
    this.id = '',
    this.alias = '',
    this.description = '',
    this.image = '',
    this.price = '0',
    this.isDisplayed = 'False',
    this.modifiersGroups = const [],
  });
  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        id: json["id"],
        alias: json["alias"],
        description: json["description"],
        image: json["image"],
        price: (json["price"] ?? "").isEmpty ? "0" : json["price"],
        isDisplayed: json.containsKey("isDisplayed")
            ? json["isDisplayed"].toString()
            : 'False',
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
        "isDisplayed": isDisplayed,
        "modifiersGroups":
            List<dynamic>.from(modifiersGroups.map((x) => x.toJson())),
      };
}
