import 'package:digital_menu_4urest/models/digital_menu/base_model_modifiers_group.dart';
import 'package:digital_menu_4urest/models/modifiers_group_model.dart';
import 'package:uuid/uuid.dart';
import 'package:get/get.dart';

class OrderProductModel {
  String orderId;
  String productId;
  String productName;
  List<BaseModelModifiersGroup> modifiersGroups;
  String notes;
  var quantity = 1.obs;
  double totalAmount;

  OrderProductModel({
    String? orderId,
    this.productId = '',
    this.productName = '',
    List<BaseModelModifiersGroup>? modifiersGroups,
    this.notes = '',
    int quantity = 1,
    this.totalAmount = 0.0,
  })  : orderId = orderId ?? const Uuid().v4(),
        modifiersGroups = modifiersGroups ?? [] {
    this.quantity.value = quantity;
  }

  factory OrderProductModel.fromJson(Map<String, dynamic> json) {
    return OrderProductModel(
      orderId: json["orderId"] ?? const Uuid().v4(),
      productId: json["product_id"] ?? '',
      productName: json["product_name"] ?? '',
      modifiersGroups: (json["modifiersGroups"] as List<dynamic>?)
              ?.map((e) => BaseModelModifiersGroup.fromJson(e))
              .toList() ??
          [],
      notes: json["notes"] ?? '',
      quantity: json["quantity"] ?? 1,
      totalAmount: (json["totalAmount"] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "orderId": orderId,
      "product_id": productId,
      "product_name": productName,
      "modifiersGroups":
          modifiersGroups.map((group) => group.toJson()).toList(),
      "notes": notes,
      "quantity": quantity.value,
      "totalAmount": totalAmount,
    };
  }

  void calculateTotalAmount() {
    double total = 0.0;
    for (var group in modifiersGroups) {
      for (var modifier in group.modifiers) {
        total += modifier.price;
      }
    }
    totalAmount = total * quantity.value;
  }
}

/*

import 'package:digital_menu_4urest/models/product_model.dart';
import 'package:uuid/uuid.dart';
import 'package:get/get.dart';

class OrderProductModel {
  String orderId;
  ProductModel product;
  String notes;
  var quantity = 1.obs;
  double totalAmount;

  OrderProductModel({
    String? orderId,
    required this.product,
    this.notes = '',
    int quantity = 1,
    this.totalAmount = 0.0,
  }) : orderId = orderId ?? const Uuid().v4() {
    this.quantity.value = quantity;
    calculateTotalAmount(); // Recalculate total amount when a new instance is created
  }

  factory OrderProductModel.fromJson(Map<String, dynamic> json) {
    return OrderProductModel(
      orderId: json["orderId"] ?? const Uuid().v4(),
      product: ProductModel.fromJson(json["product"]),
      notes: json["notes"] ?? '',
      quantity: json["quantity"] ?? 1,
      totalAmount: (json["totalAmount"] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "orderId": orderId,
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
  }
}

*/

/*  // Respaldo sin objeto product model

import 'package:digital_menu_4urest/models/modifiers_group_model.dart';
import 'package:uuid/uuid.dart';
import 'package:get/get.dart';

class OrderProductModel {
  String orderId;
  String productId;
  String productName;
  List<ModifiersGroupModel> modifiersGroups;
  String notes;
  var quantity = 1.obs;
  double totalAmount;

  OrderProductModel({
    String? orderId,
    this.productId = '',
    this.productName = '',
    List<ModifiersGroupModel>? modifiersGroups,
    this.notes = '',
    int quantity = 1,
    this.totalAmount = 0.0,
  })  : orderId = orderId ?? const Uuid().v4(),
        modifiersGroups = modifiersGroups ?? [] {
    this.quantity.value = quantity;
  }

  factory OrderProductModel.fromJson(Map<String, dynamic> json) {
    return OrderProductModel(
      orderId: json["orderId"] ?? const Uuid().v4(),
      productId: json["product_id"] ?? '',
      productName: json["product_name"] ?? '',
      modifiersGroups: (json["modifiersGroups"] as List<dynamic>?)
              ?.map((e) => ModifiersGroupModel.fromJson(e))
              .toList() ??
          [],
      notes: json["notes"] ?? '',
      quantity: json["quantity"] ?? 1,
      totalAmount: (json["totalAmount"] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "orderId": orderId,
      "product_id": productId,
      "product_name": productName,
      "modifiersGroups":
          modifiersGroups.map((group) => group.toJson()).toList(),
      "notes": notes,
      "quantity": quantity.value,
      "totalAmount": totalAmount,
    };
  }

  void calculateTotalAmount() {
    double total = 0.0;
    for (var group in modifiersGroups) {
      for (var modifier in group.modifiers) {
        total += double.tryParse(modifier.price) ?? 0.0;
      }
    }
    totalAmount = total * quantity.value;
  }
}

 */