class BaseModelPaymentMethod {
  String id;
  String method;

  BaseModelPaymentMethod({
    this.id = '',
    this.method = '',
  });

  factory BaseModelPaymentMethod.fromJson(Map<String, dynamic> json) =>
      BaseModelPaymentMethod(
        id: json["id"] ?? '',
        method: json["method"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "method": method,
      };
}
