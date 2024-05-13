class BannerModel {
  String id;
  String name;
  String image;

  BannerModel({
    this.id = '',
    this.name = '',
    this.image = '',
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
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
