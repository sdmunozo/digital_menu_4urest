class BaseModelBanner {
  String id;
  String name;
  String image;

  BaseModelBanner({
    this.id = '',
    this.name = '',
    this.image = '',
  });

  factory BaseModelBanner.fromJson(Map<String, dynamic> json) =>
      BaseModelBanner(
        id: json["id"] ?? '',
        name: json["name"] ?? '',
        image: json["image"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
      };
}
