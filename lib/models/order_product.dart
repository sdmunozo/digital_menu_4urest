import 'package:digital_menu_4urest/models/digital_menu/base_model_product.dart';
import 'package:uuid/uuid.dart';
import 'package:get/get.dart';

class OrderProduct {
  String orderProductId;
  BaseModelProduct product;
  String notes;
  var quantity = 1.obs;
  double totalAmount;

  OrderProduct({
    String? orderProductId,
    required this.product,
    this.notes = '',
    int quantity = 1,
    this.totalAmount = 0.0,
  }) : orderProductId = orderProductId ?? const Uuid().v4() {
    this.quantity.value = quantity;
  }

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      orderProductId: json["orderProductId"] ?? const Uuid().v4(),
      product: BaseModelProduct.fromJson(json["product"]),
      notes: json["notes"] ?? '',
      quantity: json["quantity"] ?? 1,
      totalAmount: (json["totalAmount"] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "orderProductId": orderProductId,
      "product": product.toJson(),
      "notes": notes,
      "quantity": quantity.value,
      "totalAmount": totalAmount,
    };
  }

  void calculateTotalAmount() {
    double total = product.price;
    for (var group in product.modifiersGroups) {
      for (var modifier in group.modifiers) {
        total += modifier.price;
      }
    }
    totalAmount = total * quantity.value;
  }
}

/*import 'package:digital_menu_4urest/models/product_model.dart';
import 'package:uuid/uuid.dart';
import 'package:get/get.dart';

class OrderProduct {
  String orderProductId;
  ProductModel product;
  String notes;
  var quantity = 1.obs;
  double totalAmount;

  OrderProduct({
    String? orderProductId,
    required this.product,
    this.notes = '',
    int quantity = 1,
    this.totalAmount = 0.0,
  }) : orderProductId = orderProductId ?? const Uuid().v4() {
    this.quantity.value = quantity;
  }

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      orderProductId: json["orderProductId"] ?? const Uuid().v4(),
      product: ProductModel.fromJson(json["product"]),
      notes: json["notes"] ?? '',
      quantity: json["quantity"] ?? 1,
      totalAmount: (json["totalAmount"] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "orderProductId": orderProductId,
      "product": product.toJson(),
      "notes": notes,
      "quantity": quantity.value,
      "totalAmount": totalAmount,
    };
  }

  void calculateTotalAmount() {
    double total = double.tryParse(product.price) ?? 0.0;
    for (var group in product.modifiersGroups) {
      for (var modifier in group.modifiers) {
        total += double.tryParse(modifier.price) ?? 0.0;
      }
    }
    totalAmount = total * quantity.value;
    print("Total amount calculated: $totalAmount");
  }
}

*/

/*
  void calculateTotalAmount() {
    double total = double.tryParse(product.price) ?? 0.0;
    for (var group in product.modifiersGroups) {
      for (var modifier in group.modifiers) {
        total += double.tryParse(modifier.price) ?? 0.0;
      }
    }
    totalAmount = total * quantity.value;
  }
*/