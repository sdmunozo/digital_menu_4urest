class BaseModelRecommendation {
  String id;
  String productId;

  BaseModelRecommendation({
    this.id = '',
    this.productId = '',
  });

  factory BaseModelRecommendation.fromJson(Map<String, dynamic> json) =>
      BaseModelRecommendation(
        id: json["id"] ?? '',
        productId: json["productId"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productId": productId,
      };
}
