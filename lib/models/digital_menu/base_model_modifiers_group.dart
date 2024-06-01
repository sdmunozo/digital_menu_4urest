import 'package:digital_menu_4urest/models/digital_menu/base_model_modifier.dart';
import 'package:digital_menu_4urest/models/digital_menu/base_model_product.dart';

class BaseModelModifiersGroup {
  String id;
  String alias;
  String description;
  String image;
  int sort;
  int minModifiers;
  int maxModifiers;
  String status;
  List<BaseModelModifier> modifiers;

  BaseModelModifiersGroup({
    this.id = '',
    this.alias = '',
    this.description = '',
    this.image = '',
    this.sort = 0,
    this.minModifiers = 0,
    this.maxModifiers = 0,
    this.status = 'Active',
    this.modifiers = const [],
  });

  factory BaseModelModifiersGroup.fromJson(Map<String, dynamic> json) =>
      BaseModelModifiersGroup(
        id: json["id"] ?? '',
        alias: json["alias"] ?? '',
        description: json["description"] ?? '',
        image: json["image"] ?? '',
        sort: json["sort"] ?? 0,
        minModifiers: json["minModifiers"] ?? 0,
        maxModifiers: json["maxModifiers"] ?? 0,
        status: json["status"] ?? '',
        modifiers: json["modifiers"] == null
            ? []
            : List<BaseModelModifier>.from(
                json["modifiers"].map((x) => BaseModelModifier.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "alias": alias,
        "description": description,
        "image": image,
        "sort": sort,
        "minModifiers": minModifiers,
        "maxModifiers": maxModifiers,
        "status": status,
        "modifiers": List<dynamic>.from(modifiers.map((x) => x.toJson())),
      };

  BaseModelModifiersGroup copy() => BaseModelModifiersGroup(
        id: id,
        alias: alias,
        description: description,
        image: image,
        status: status,
        sort: sort,
        minModifiers: minModifiers,
        maxModifiers: maxModifiers,
        modifiers: List<BaseModelModifier>.from(
            modifiers.map((modifier) => modifier.copy())),
      );
}
