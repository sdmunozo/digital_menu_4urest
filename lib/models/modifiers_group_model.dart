import 'package:digital_menu_4urest/models/modifier_model.dart';

class ModifiersGroupModel {
  String id;
  String alias;
  String description;
  String image;
  String status;
  String sort;
  String minModifiers;
  String maxModifiers;
  List<ModifierModel> modifiers;

  ModifiersGroupModel({
    this.id = '',
    this.alias = '',
    this.description = '',
    this.image = '',
    this.status = 'Active',
    this.sort = '-1',
    this.minModifiers = '-1',
    this.maxModifiers = '-1',
    this.modifiers = const [],
  });

  factory ModifiersGroupModel.fromJson(Map<String, dynamic> json) =>
      ModifiersGroupModel(
        id: json["id"],
        alias: json["alias"],
        description: json["description"],
        image: json["image"],
        status: json["status"],
        sort: json["sort"],
        minModifiers: json["minModifiers"],
        maxModifiers: json["maxModifiers"],
        modifiers: json["modifiers"] == null
            ? []
            : List<ModifierModel>.from(
                json["modifiers"].map((x) => ModifierModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "alias": alias,
        "description": description,
        "image": image,
        "status": status,
        "sort": sort,
        "minModifiers": minModifiers,
        "maxModifiers": maxModifiers,
        "modifiers": List<dynamic>.from(modifiers.map((x) => x.toJson())),
      };

  ModifiersGroupModel copy() => ModifiersGroupModel(
        id: id,
        alias: alias,
        description: description,
        image: image,
        status: status,
        sort: sort,
        minModifiers: minModifiers,
        maxModifiers: maxModifiers,
        modifiers: List<ModifierModel>.from(
            modifiers.map((modifier) => modifier.copy())),
      );
}


/*import 'package:digital_menu_4urest/models/modifier_model.dart';

class ModifiersGroupModel {
  String id;
  String alias;
  String description;
  String image;
  String status;
  String sort;
  String minModifiers;
  String maxModifiers;
  List<ModifierModel> modifiers;

  ModifiersGroupModel({
    this.id = '',
    this.alias = '',
    this.description = '',
    this.image = '',
    this.status = 'Active',
    this.sort = '-1',
    this.minModifiers = '-1',
    this.maxModifiers = '-1',
    this.modifiers = const [],
  });

  factory ModifiersGroupModel.fromJson(Map<String, dynamic> json) =>
      ModifiersGroupModel(
        id: json["id"],
        alias: json["alias"],
        description: json["description"],
        image: json["image"],
        status: json["status"],
        sort: json["sort"],
        minModifiers: json["minModifiers"],
        maxModifiers: json["maxModifiers"],
        modifiers: json["modifiers"] == null
            ? []
            : List<ModifierModel>.from(
                json["modifiers"].map((x) => ModifierModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "alias": alias,
        "description": description,
        "image": image,
        "status": status,
        "sort": sort,
        "minModifiers": minModifiers,
        "maxModifiers": maxModifiers,
        "modifiers": List<dynamic>.from(modifiers.map((x) => x.toJson())),
      };
}

*/