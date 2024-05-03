import 'package:digital_menu_4urest/models/item_model.dart';

class ModifiersGroupModel {
  String id;
  String alias;
  String description;
  String icon;
  String isSelectable;
  List<ItemModel> modifiers;

  ModifiersGroupModel({
    this.id = '',
    this.alias = '',
    this.description = '',
    this.icon = '',
    this.isSelectable = '0',
    this.modifiers = const [],
  });

  factory ModifiersGroupModel.fromJson(Map<String, dynamic> json) =>
      ModifiersGroupModel(
        id: json["id"],
        alias: json["alias"],
        description: json["description"],
        icon: json["icon"],
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
        "icon": icon,
        "isSelectable": isSelectable,
        "modifiers": List<dynamic>.from(modifiers.map((x) => x.toJson())),
      };
}
