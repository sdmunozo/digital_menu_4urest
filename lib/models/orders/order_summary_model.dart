import 'dart:math';
import 'package:digital_menu_4urest/models/digital_menu/base_model_delivery_type.dart';
import 'package:digital_menu_4urest/models/digital_menu/base_model_digital_menu.dart';
import 'package:digital_menu_4urest/models/digital_menu/base_model_payment_method.dart';
import 'package:digital_menu_4urest/models/orders/client_model.dart';
import 'package:digital_menu_4urest/models/orders/order_item_model.dart';
import 'package:uuid/uuid.dart';

class OrderSummaryModel {
  String orderSummaryId;
  String orderCode;
  List<OrderItemModel> orderItems;
  double totalAmount;
  DateTime timestamp;
  ClientModel client;
  BaseModelDeliveryType deliveryType;
  BaseModelPaymentMethod paymentMethod;
  String notes;

  OrderSummaryModel({
    String? orderSummaryId,
    required this.orderItems,
    required this.totalAmount,
    required this.timestamp,
    required this.client,
    required this.deliveryType,
    required this.paymentMethod,
    this.notes = '',
  })  : orderSummaryId = orderSummaryId ?? const Uuid().v4(),
        orderCode = _generateOrderCode();

  factory OrderSummaryModel.fromJson(Map<String, dynamic> json) {
    List<OrderItemModel> orderItems = [];
    json['orderItems'].forEach((itemJson) {
      orderItems.add(OrderItemModel.fromJson(itemJson));
    });

    return OrderSummaryModel(
      orderSummaryId: json['orderSummaryId'],
      orderItems: orderItems,
      totalAmount: (json['totalAmount'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp']),
      client: ClientModel.fromJson(json['client']),
      deliveryType: BaseModelDeliveryType.fromJson(json['deliveryType']),
      paymentMethod: BaseModelPaymentMethod.fromJson(json['paymentMethod']),
      notes: json['notes'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> orderItemsJson = [];
    for (var item in orderItems) {
      orderItemsJson.add(item.toJson());
    }

    return {
      'orderSummaryId': orderSummaryId,
      'orderCode': orderCode,
      'orderItems': orderItemsJson,
      'totalAmount': totalAmount,
      'timestamp': timestamp.toIso8601String(),
      'client': client.toJson(),
      'deliveryType': deliveryType.toJson(),
      'paymentMethod': paymentMethod.toJson(),
      'notes': notes,
    };
  }

  void calculateTotalAmount() {
    double total = 0.0;
    for (var item in orderItems) {
      total += item.totalAmount;
    }
    totalAmount = total;
  }

  static String _generateOrderCode() {
    final random = Random();
    int codeLength = 4 + random.nextInt(3); // Generate length between 4 and 6
    String orderCode = '';
    for (int i = 0; i < codeLength; i++) {
      orderCode += random.nextInt(10).toString();
    }
    return orderCode;
  }
}


/*

Respaldo hasta enviar whatsapp sin datos de cliente

import 'dart:math';
import 'package:digital_menu_4urest/models/orders/client_model.dart';
import 'package:digital_menu_4urest/models/orders/delivery_type.dart';
import 'package:digital_menu_4urest/models/orders/order_item_model.dart';
import 'package:digital_menu_4urest/models/orders/payment_method_model.dart';
import 'package:uuid/uuid.dart';

class OrderSummaryModel {
  String orderSummaryId;
  String orderCode;
  List<OrderItemModel> orderItems;
  double totalAmount;
  DateTime timestamp;
  ClientModel client;
  DeliveryTypeModel deliveryType;
  PaymentMethodModel paymentMethod;

  OrderSummaryModel({
    String? orderSummaryId,
    required this.orderItems,
    required this.totalAmount,
    required this.timestamp,
    required this.client,
    required this.deliveryType,
    required this.paymentMethod,
  })  : orderSummaryId = orderSummaryId ?? const Uuid().v4(),
        orderCode = _generateOrderCode();

  factory OrderSummaryModel.fromJson(Map<String, dynamic> json) {
    List<OrderItemModel> orderItems = [];
    json['orderItems'].forEach((itemJson) {
      orderItems.add(OrderItemModel.fromJson(itemJson));
    });

    return OrderSummaryModel(
      orderSummaryId: json['orderSummaryId'],
      orderItems: orderItems,
      totalAmount: (json['totalAmount'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp']),
      client: ClientModel.fromJson(json['client']),
      deliveryType: DeliveryTypeModel.fromJson(json['deliveryType']),
      paymentMethod: PaymentMethodModel.fromJson(json['paymentMethod']),
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> orderItemsJson = [];
    for (var item in orderItems) {
      orderItemsJson.add(item.toJson());
    }

    return {
      'orderSummaryId': orderSummaryId,
      'orderCode': orderCode,
      'orderItems': orderItemsJson,
      'totalAmount': totalAmount,
      'timestamp': timestamp.toIso8601String(),
      'client': client.toJson(),
      'deliveryType': deliveryType.toJson(),
      'paymentMethod': paymentMethod.toJson(),
    };
  }

  void calculateTotalAmount() {
    double total = 0.0;
    for (var item in orderItems) {
      total += item.totalAmount;
    }
    totalAmount = total;
  }

  static String _generateOrderCode() {
    final random = Random();
    int codeLength = (4 + random.nextInt(3));
    String orderCode = '';
    for (int i = 0; i < codeLength; i++) {
      orderCode += random.nextInt(10).toString();
    }
    return orderCode;
  }
}

*/

/*
class OrderSummaryModel {
  String orderSummaryId;
  List<OrderItemModel> orderItems;
  double totalAmount;
  DateTime timestamp;
  ClientModel client;
  DeliveryTypeModel deliveryType;
  PaymentMethodModel paymentMethod;

  OrderSummaryModel({
    String? orderSummaryId,
    required this.orderItems,
    required this.totalAmount,
    required this.timestamp,
    required this.client,
    required this.deliveryType,
    required this.paymentMethod,
  }) : orderSummaryId = orderSummaryId ?? uuid.v4();

  factory OrderSummaryModel.fromJson(Map<String, dynamic> json) {
    List<OrderItemModel> orderItems = [];
    json['orderItems'].forEach((itemJson) {
      orderItems.add(OrderItemModel.fromJson(itemJson));
    });

    return OrderSummaryModel(
      orderSummaryId: json['orderSummaryId'],
      orderItems: orderItems,
      totalAmount: (json['totalAmount'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp']),
      client: ClientModel.fromJson(json['client']),
      deliveryType: DeliveryTypeModel.fromJson(json['deliveryType']),
      paymentMethod: PaymentMethodModel.fromJson(json['paymentMethod']),
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> orderItemsJson = [];
    for (var item in orderItems) {
      orderItemsJson.add(item.toJson());
    }

    return {
      'orderSummaryId': orderSummaryId,
      'orderItems': orderItemsJson,
      'totalAmount': totalAmount,
      'timestamp': timestamp.toIso8601String(),
      'client': client.toJson(),
      'deliveryType': deliveryType.toJson(),
      'paymentMethod': paymentMethod.toJson(),
    };
  }

  void calculateTotalAmount() {
    double total = 0.0;
    for (var item in orderItems) {
      total += item.totalAmount;
    }
    totalAmount = total;
  }
}
*/


/* respaldo hasta antes de solicitar datos del cliente, forma de pago etc

class OrderSummaryModel {
  String orderSummaryId;
  List<OrderItemModel> orderItems;
  double totalAmount;
  DateTime timestamp;


  OrderSummaryModel({
    required this.orderSummaryId,
    required this.orderItems,
    required this.totalAmount,
    required this.timestamp,
  });

  factory OrderSummaryModel.fromJson(Map<String, dynamic> json) {
    List<OrderItemModel> orderItems = [];
    json['orderItems'].forEach((itemJson) {
      orderItems.add(OrderItemModel.fromJson(itemJson));
    });

    return OrderSummaryModel(
      orderSummaryId: json['orderSummaryId'],
      orderItems: orderItems,
      totalAmount: (json['totalAmount'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> orderItemsJson = [];
    for (var item in orderItems) {
      orderItemsJson.add(item.toJson());
    }

    return {
      'orderSummaryId': orderSummaryId,
      'orderItems': orderItemsJson,
      'totalAmount': totalAmount,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  void calculateTotalAmount() {
    double total = 0.0;
    for (var item in orderItems) {
      total += item.totalAmount;
    }
    totalAmount = total;
  }
}

*/