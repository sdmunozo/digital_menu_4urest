class BannerModel {
  String name;
  String link;

  BannerModel({
    this.name = '',
    this.link = '',
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        name: json["name"] ?? '',
        link: json["link"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "link": link,
      };
}
