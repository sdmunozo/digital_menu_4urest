class BaseModelModifier {
  String id;
  String alias;
  String description;
  String image;
  int sort;
  double price;
  String status;

  BaseModelModifier({
    this.id = '',
    this.alias = '',
    this.description = '',
    this.image = '',
    this.sort = 0,
    this.price = 0.0,
    this.status = 'Active',
  });

  factory BaseModelModifier.fromJson(Map<String, dynamic> json) =>
      BaseModelModifier(
        id: json["id"] ?? '',
        alias: json["alias"] ?? '',
        description: json["description"] ?? '',
        image: json["image"] ?? '',
        sort: json["sort"] ?? '',
        price: (json["price"] ?? 0.0).toDouble() ?? 0.0,
        status: json["status"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "alias": alias,
        "description": description,
        "image": image,
        "sort": sort,
        "price": price,
        "status": status,
      };

  BaseModelModifier copy() => BaseModelModifier(
        id: id,
        alias: alias,
        description: description,
        image: image,
        sort: sort,
        price: price,
        status: status,
      );
}
