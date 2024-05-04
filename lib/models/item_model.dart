import 'package:digital_menu_4urest/models/modifiers_group_model.dart';

class ItemModel {
  String id;
  String alias;
  String description;
  String icon;
  String price;
  List<ModifiersGroupModel> modifiersGroups;

  ItemModel({
    this.id = '',
    this.alias = '',
    this.description = '',
    this.icon = '',
    this.price = '0',
    this.modifiersGroups = const [],
  });
  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        id: json["id"],
        alias: json["alias"],
        description: json["description"],
        icon: json["icon"],
        price: (json["price"] ?? "").isEmpty ? "0" : json["price"],
        modifiersGroups: List<ModifiersGroupModel>.from(json["modifiersGroups"]
                ?.map((x) => ModifiersGroupModel.fromJson(x)) ??
            []),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "alias": alias,
        "description": description,
        "icon": icon,
        "price": price,
        "modifiersGroups":
            List<dynamic>.from(modifiersGroups.map((x) => x.toJson())),
      };
}
