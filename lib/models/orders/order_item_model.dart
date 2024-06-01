import 'package:digital_menu_4urest/models/digital_menu/base_model_product.dart';
import 'package:digital_menu_4urest/models/product_model.dart';

class OrderItemModel {
  String orderItemId;
  BaseModelProduct product;
  String notes;
  int quantity;
  double totalAmount;
  DateTime timestamp;

  OrderItemModel({
    required this.orderItemId,
    required this.product,
    required this.notes,
    required this.quantity,
    required this.totalAmount,
    required this.timestamp,
  });

  void calculateTotalAmount() {
    double sum = product.price;
    for (var group in product.modifiersGroups) {
      for (var modifier in group.modifiers) {
        sum += modifier.price;
      }
    }
    totalAmount = sum * quantity;
  }

  Map<String, dynamic> toJson() {
    return {
      'orderItemId': orderItemId,
      'product': product.toJson(),
      'notes': notes,
      'quantity': quantity,
      'totalAmount': totalAmount,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  static OrderItemModel fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      orderItemId: json['orderItemId'],
      product: BaseModelProduct.fromJson(json['product']),
      notes: json['notes'],
      quantity: json['quantity'],
      totalAmount: json['totalAmount'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}


/* RESPALDO HASTA ANTES DE WHATSAPP

class OrderItemModel {
  String orderItemId;
  ProductModel product;
  String notes;
  int quantity;
  double totalAmount;
  DateTime timestamp;

  OrderItemModel({
    required this.orderItemId,
    required this.product,
    required this.notes,
    required this.quantity,
    required this.totalAmount,
    required this.timestamp,
  });

  void calculateTotalAmount() {
    double sum = double.parse(product.price);
    for (var group in product.modifiersGroups) {
      for (var modifier in group.modifiers) {
        sum += double.parse(modifier.price);
      }
    }
    totalAmount = sum * quantity;
  }

  Map<String, dynamic> toJson() {
    return {
      'orderItemId': orderItemId,
      'product': product.toJson(),
      'notes': notes,
      'quantity': quantity,
      'totalAmount': totalAmount,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  static OrderItemModel fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      orderItemId: json['orderItemId'],
      product: ProductModel.fromJson(json['product']),
      notes: json['notes'],
      quantity: json['quantity'],
      totalAmount: json['totalAmount'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}


 */