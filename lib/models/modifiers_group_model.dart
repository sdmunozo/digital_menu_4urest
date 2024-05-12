import 'package:digital_menu_4urest/models/item_model.dart';

class ModifiersGroupModel {
  String id;
  String alias;
  String description;
  String image;
  String isSelectable;
  List<ItemModel> modifiers;

  ModifiersGroupModel({
    this.id = '',
    this.alias = '',
    this.description = '',
    this.image = '',
    this.isSelectable = '0',
    this.modifiers = const [],
  });

  factory ModifiersGroupModel.fromJson(Map<String, dynamic> json) =>
      ModifiersGroupModel(
        id: json["id"],
        alias: json["alias"],
        description: json["description"],
        image: json["image"],
        isSelectable: json["isSelectable"],
        modifiers: json["modifiers"] == null
            ? []
            : List<ItemModel>.from(
                json["modifiers"].map((x) => ItemModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "alias": alias,
        "description": description,
        "image": image,
        "isSelectable": isSelectable,
        "modifiers": List<dynamic>.from(modifiers.map((x) => x.toJson())),
      };
}
