class ModifierModel {
  String id;
  String alias;
  String description;
  String status;
  String sort;
  String image;
  String price;

  ModifierModel({
    this.id = '',
    this.alias = '',
    this.description = '',
    this.status = 'Active',
    this.sort = '-1',
    this.image = '',
    this.price = '0',
  });

  factory ModifierModel.fromJson(Map<String, dynamic> json) => ModifierModel(
        id: json["id"],
        alias: json["alias"],
        description: json["description"],
        image: json["image"],
        status: json["status"],
        sort: json["sort"],
        price: (json["price"] ?? "").isEmpty ? "0" : json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "alias": alias,
        "description": description,
        "image": image,
        "status": status,
        "sort": sort,
        "price": price,
      };

  ModifierModel copy() => ModifierModel(
        id: id,
        alias: alias,
        description: description,
        status: status,
        sort: sort,
        image: image,
        price: price,
      );
}


/*class ModifierModel {
  String id;
  String alias;
  String description;
  String status;
  String sort;
  String image;
  String price;

  ModifierModel({
    this.id = '',
    this.alias = '',
    this.description = '',
    this.status = 'Active',
    this.sort = '-1',
    this.image = '',
    this.price = '0',
  });
  factory ModifierModel.fromJson(Map<String, dynamic> json) => ModifierModel(
        id: json["id"],
        alias: json["alias"],
        description: json["description"],
        image: json["image"],
        status: json["status"],
        sort: json["sort"],
        price: (json["price"] ?? "").isEmpty ? "0" : json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "alias": alias,
        "description": description,
        "image": image,
        "status": status,
        "sort": sort,
        "price": price,
      };
}
*/