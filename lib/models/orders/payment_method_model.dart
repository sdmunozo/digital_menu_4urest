class PaymentMethodModel {
  String method;

  PaymentMethodModel({
    required this.method,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(
      method: json['method'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'method': method,
    };
  }
}
