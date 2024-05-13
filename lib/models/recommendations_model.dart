class RecommendationsModel {
  String id;
  String productId;

  RecommendationsModel({
    this.id = '',
    this.productId = '',
  });

  factory RecommendationsModel.fromJson(Map<String, dynamic> json) =>
      RecommendationsModel(
        id: json["id"] ?? '',
        productId: json["productId"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productId": productId,
      };
}
