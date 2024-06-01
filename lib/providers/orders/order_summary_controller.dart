// ignore_for_file: use_build_context_synchronously

import 'package:digital_menu_4urest/models/digital_menu/base_model_delivery_type.dart';
import 'package:digital_menu_4urest/models/digital_menu/base_model_digital_menu.dart';
import 'package:digital_menu_4urest/models/digital_menu/base_model_payment_method.dart';
import 'package:digital_menu_4urest/models/orders/address_model.dart';
import 'package:digital_menu_4urest/models/orders/client_model.dart';
//import 'package:digital_menu_4urest/models/orders/delivery_type.dart';
import 'package:digital_menu_4urest/models/orders/order_summary_model.dart';
//import 'package:digital_menu_4urest/models/orders/payment_method_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:open_share_plus/open.dart';
import 'package:uuid/uuid.dart';
import 'package:digital_menu_4urest/models/orders/order_item_model.dart';

class OrderSummaryController extends GetxController {
  Rx<OrderSummaryModel> orderSummary = OrderSummaryModel(
    orderSummaryId: const Uuid().v4(),
    orderItems: [],
    totalAmount: 0.0,
    timestamp: DateTime.now(),
    client: ClientModel(name: '', phone: ''),
    deliveryType: BaseModelDeliveryType(type: ''),
    paymentMethod: BaseModelPaymentMethod(method: ''),
  ).obs;

  var totalAmount = 0.0.obs;
  var totalProducts = 0.obs;

  void addProduct(OrderItemModel orderItem) {
    orderSummary.value.orderItems.add(orderItem);
    orderSummary.value.calculateTotalAmount();
    _updateTotals();
    orderSummary.refresh();
  }

  void updateProductQuantity(String orderItemId, int newQuantity) {
    try {
      var item = orderSummary.value.orderItems.firstWhere(
        (element) => element.orderItemId == orderItemId,
      );

      if (newQuantity <= 0) {
        orderSummary.value.orderItems.remove(item);
      } else {
        item.quantity = newQuantity;
        item.calculateTotalAmount();
      }

      _updateTotals();
      orderSummary.refresh();
    } catch (e) {
      GlobalConfigProvider.logMessage(
          "Item with orderItemId $orderItemId not found.");
    }
  }

  void removeProduct(String orderItemId) {
    orderSummary.value.orderItems
        .removeWhere((item) => item.orderItemId == orderItemId);
    _updateTotals();
    orderSummary.refresh();
  }

  void printOrderSummary() {
    String summary = 'Resumen de la orden:\n';
    for (var item in orderSummary.value.orderItems) {
      summary +=
          'Producto: ${item.product.alias}, Cantidad: ${item.quantity}, Total: \$${item.totalAmount.toStringAsFixed(2)}\n';
    }
    summary +=
        'Monto Total: \$${orderSummary.value.totalAmount.toStringAsFixed(2)}';
    GlobalConfigProvider.logMessage(summary);
  }

  int getTotalQuantityForProduct(String productId) {
    int totalQuantity = 0;
    for (var item in orderSummary.value.orderItems) {
      if (item.product.id == productId) {
        totalQuantity += item.quantity;
      }
    }
    return totalQuantity;
  }

  void _updateTotals() {
    double newTotalAmount = 0.0;
    for (var item in orderSummary.value.orderItems) {
      newTotalAmount += item.totalAmount;
    }
    totalAmount.value = newTotalAmount;

    int newTotalProducts = 0;
    for (var item in orderSummary.value.orderItems) {
      newTotalProducts += item.quantity;
    }
    totalProducts.value = newTotalProducts;
  }

  Future<void> sendOrderSummaryToWhatsApp(BuildContext context) async {
    String? clientName = await _promptForInput(context, 'Nombre del cliente');
    if (clientName == null) return;
    if (!Get.isRegistered<OrderSummaryController>()) return;

    String? clientPhone =
        await _promptForInput(context, 'Teléfono del cliente');
    if (clientPhone == null) return;
    if (!Get.isRegistered<OrderSummaryController>()) return;

    orderSummary.value.client.name = clientName;
    orderSummary.value.client.phone = clientPhone;

    BaseModelPaymentMethod? paymentMethod =
        await _promptForPaymentMethod(context);
    if (paymentMethod == null) return;
    if (!Get.isRegistered<OrderSummaryController>()) return;

    orderSummary.value.paymentMethod = paymentMethod;

    BaseModelDeliveryType? deliveryType = await _promptForDeliveryType(context);
    if (deliveryType == null) return;
    if (!Get.isRegistered<OrderSummaryController>()) return;

    orderSummary.value.deliveryType = deliveryType;

    String phoneNumber =
        GlobalConfigProvider.branchCatalog!.brand.branches[0].whatsApp;
    String message = generateOrderSummaryMessage();
    Open.whatsApp(whatsAppNumber: phoneNumber, text: message);
  }

  Future<String?> _promptForInput(BuildContext context, String label) async {
    TextEditingController controller = TextEditingController();
    String? result = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(label),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: label),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop(controller.text);
              },
            ),
          ],
        );
      },
    );
    if (!Get.isRegistered<OrderSummaryController>()) return null;
    return result;
  }

  Future<BaseModelPaymentMethod?> _promptForPaymentMethod(
      BuildContext context) async {
    List<BaseModelPaymentMethod> methods =
        GlobalConfigProvider.branchCatalog?.brand.branches[0].paymentMethods ??
            [];

    BaseModelPaymentMethod? result = await showDialog<BaseModelPaymentMethod>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Método de pago'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: methods.map((method) {
              return ListTile(
                title: Text(method.method),
                onTap: () {
                  Navigator.of(context).pop(method);
                },
              );
            }).toList(),
          ),
        );
      },
    );
    return result;
  }

  Future<BaseModelDeliveryType?> _promptForDeliveryType(
      BuildContext context) async {
    List<BaseModelDeliveryType> deliveryTypes =
        GlobalConfigProvider.branchCatalog?.brand.branches[0].deliveryTypes ??
            [];

    BaseModelDeliveryType? result = await showDialog<BaseModelDeliveryType>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tipo de entrega'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: deliveryTypes.map((type) {
              return ListTile(
                title: Text(type.type),
                onTap: () {
                  Navigator.of(context).pop(type);
                },
              );
            }).toList(),
          ),
        );
      },
    );

    if (result != null && result.type == 'A domicilio') {
      AddressModel? address = await _promptForAddress(context);
      if (address == null) return null;
      return BaseModelDeliveryType(type: 'A domicilio', address: address);
    } else {
      return result;
    }
  }

  Future<AddressModel?> _promptForAddress(BuildContext context) async {
    TextEditingController streetController = TextEditingController();
    TextEditingController neighborhoodController = TextEditingController();
    TextEditingController interiorNumberController = TextEditingController();
    TextEditingController exteriorNumberController = TextEditingController();
    TextEditingController referenceController = TextEditingController();
    TextEditingController cityController = TextEditingController();
    TextEditingController zipCodeController = TextEditingController();

    AddressModel? result = await showDialog<AddressModel>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Dirección de entrega'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: streetController,
                  decoration: const InputDecoration(hintText: 'Calle'),
                ),
                TextField(
                  controller: neighborhoodController,
                  decoration:
                      const InputDecoration(hintText: 'Colonia/Avenida/Barrio'),
                ),
                TextField(
                  controller: interiorNumberController,
                  decoration:
                      const InputDecoration(hintText: 'Número Interior'),
                ),
                TextField(
                  controller: exteriorNumberController,
                  decoration:
                      const InputDecoration(hintText: 'Número Exterior'),
                ),
                TextField(
                  controller: referenceController,
                  decoration: const InputDecoration(hintText: 'Referencia'),
                ),
                TextField(
                  controller: cityController,
                  decoration: const InputDecoration(hintText: 'Ciudad'),
                ),
                TextField(
                  controller: zipCodeController,
                  decoration: const InputDecoration(hintText: 'Código Postal'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop(AddressModel(
                  street: streetController.text,
                  neighborhood: neighborhoodController.text,
                  interiorNumber: interiorNumberController.text,
                  exteriorNumber: exteriorNumberController.text,
                  reference: referenceController.text,
                  city: cityController.text,
                  zipCode: zipCodeController.text,
                ));
              },
            ),
          ],
        );
      },
    );
    return result;
  }

  /*

  Future<DeliveryTypeModel?> _promptForDeliveryType(
      BuildContext context) async {
    List<DeliveryTypeModel> deliveryTypes =
        GlobalConfigProvider.branchCatalog?.deliveryTypes ?? [];

    DeliveryTypeModel? result = await showDialog<DeliveryTypeModel>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tipo de entrega'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: deliveryTypes.map((type) {
              return ListTile(
                title: Text(type.type),
                onTap: () {
                  Navigator.of(context).pop(type);
                },
              );
            }).toList(),
          ),
        );
      },
    );
    return result;
  }

  */

/*
  Future<PaymentMethodModel?> _promptForPaymentMethod(
      BuildContext context) async {
    List<PaymentMethodModel> methods = [
      PaymentMethodModel(method: 'Transferencia'),
      PaymentMethodModel(method: 'Efectivo'),
      PaymentMethodModel(method: 'Tarjeta'),
    ];

    PaymentMethodModel? result = await showDialog<PaymentMethodModel>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Método de pago'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: methods.map((method) {
              return ListTile(
                title: Text(method.method),
                onTap: () {
                  Navigator.of(context).pop(method);
                },
              );
            }).toList(),
          ),
        );
      },
    );
    if (!Get.isRegistered<OrderSummaryController>()) return null;
    return result;
  }

  Future<DeliveryTypeModel?> _promptForDeliveryType(
      BuildContext context) async {
    List<String> deliveryTypes = ['Para llevar', 'A domicilio'];

    String? selectedType = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tipo de entrega'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: deliveryTypes.map((type) {
              return ListTile(
                title: Text(type),
                onTap: () {
                  Navigator.of(context).pop(type);
                },
              );
            }).toList(),
          ),
        );
      },
    );

    if (!Get.isRegistered<OrderSummaryController>()) return null;
    if (selectedType == null) return null;

    if (selectedType == 'A domicilio') {
      AddressModel? address = await _promptForAddress(context);
      if (!Get.isRegistered<OrderSummaryController>()) return null;
      if (address == null) return null;

      return DeliveryTypeModel(type: 'A domicilio', address: address);
    } else {
      return DeliveryTypeModel(type: 'Para llevar');
    }
  }

  */

  /*

  Future<AddressModel?> _promptForAddress(BuildContext context) async {
    TextEditingController streetController = TextEditingController();
    TextEditingController neighborhoodController = TextEditingController();
    TextEditingController interiorNumberController = TextEditingController();
    TextEditingController exteriorNumberController = TextEditingController();
    TextEditingController referenceController = TextEditingController();
    TextEditingController cityController = TextEditingController();
    TextEditingController zipCodeController = TextEditingController();

    AddressModel? result = await showDialog<AddressModel>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Dirección de entrega'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: streetController,
                decoration: const InputDecoration(hintText: 'Calle'),
              ),
              TextField(
                controller: neighborhoodController,
                decoration:
                    const InputDecoration(hintText: 'Colonia/Avenida/Barrio'),
              ),
              TextField(
                controller: interiorNumberController,
                decoration: const InputDecoration(hintText: 'Número Interior'),
              ),
              TextField(
                controller: exteriorNumberController,
                decoration: const InputDecoration(hintText: 'Número Exterior'),
              ),
              TextField(
                controller: referenceController,
                decoration: const InputDecoration(hintText: 'Referencia'),
              ),
              TextField(
                controller: cityController,
                decoration: const InputDecoration(hintText: 'Ciudad'),
              ),
              TextField(
                controller: zipCodeController,
                decoration: const InputDecoration(hintText: 'Código Postal'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop(AddressModel(
                  street: streetController.text,
                  neighborhood: neighborhoodController.text,
                  interiorNumber: interiorNumberController.text,
                  exteriorNumber: exteriorNumberController.text,
                  reference: referenceController.text,
                  city: cityController.text,
                  zipCode: zipCodeController.text,
                ));
              },
            ),
          ],
        );
      },
    );
    if (!Get.isRegistered<OrderSummaryController>()) return null;
    return result;
  }

  */

  String generateOrderSummaryMessage() {
    String message = '*🍔 Resumen de la orden 🍟*\n\n';
    message += '*Código de pedido*: ${orderSummary.value.orderCode}\n\n';
    for (var item in orderSummary.value.orderItems) {
      message += '📦 *Producto*: *${item.product.alias}*\n';
      message += '🔢 *Cantidad*: ${item.quantity}\n';
      if (item.product.modifiersGroups.isNotEmpty) {
        for (var group in item.product.modifiersGroups) {
          if (group.modifiers.isNotEmpty) {
            message += '🔹 *${group.alias}*: ';
            message +=
                group.modifiers.map((modifier) => modifier.alias).join(', ');
            message += '\n';
          }
        }
      }
      if (item.notes.isNotEmpty) {
        message += '📝 *Notas*: ${item.notes}\n';
      }
      message += '💵 *Total*: \$${item.totalAmount.toStringAsFixed(2)}\n\n';
    }
    message +=
        '*💰 Monto Total*: \$${orderSummary.value.totalAmount.toStringAsFixed(2)}\n\n';
    message += '*👤 Cliente*: ${orderSummary.value.client.name}\n';
    message += '*📞 Teléfono*: ${orderSummary.value.client.phone}\n';
    message +=
        '*💳 Método de pago*: ${orderSummary.value.paymentMethod.method}\n';
    message +=
        '*🚚 Tipo de entrega*: ${orderSummary.value.deliveryType.type}\n';
    if (orderSummary.value.deliveryType.type == 'A domicilio' &&
        orderSummary.value.deliveryType.address != null) {
      var address = orderSummary.value.deliveryType.address!;
      message +=
          '*📍 Dirección*: ${address.street}, ${address.neighborhood}, No. Int. ${address.interiorNumber}, No. Ext. ${address.exteriorNumber}, Ref: ${address.reference}, ${address.city}, CP: ${address.zipCode}\n';
    }
    if (orderSummary.value.notes.isNotEmpty) {
      message += '📝 *Notas Generales*: ${orderSummary.value.notes}\n';
    }
    return message;
  }
}



/*

class OrderSummaryController extends GetxController {
  Rx<OrderSummaryModel> orderSummary = OrderSummaryModel(
    orderSummaryId: const Uuid().v4(),
    orderItems: [],
    totalAmount: 0.0,
    timestamp: DateTime.now(),
    client: ClientModel(name: '', phone: ''),
    deliveryType: DeliveryTypeModel(type: ''),
    paymentMethod: PaymentMethodModel(method: ''),
  ).obs;

  var totalAmount = 0.0.obs;
  var totalProducts = 0.obs;

  void addProduct(OrderItemModel orderItem) {
    orderSummary.value.orderItems.add(orderItem);
    orderSummary.value.calculateTotalAmount();
    _updateTotals();
    orderSummary.refresh();
  }

  void updateProductQuantity(String orderItemId, int newQuantity) {
    try {
      var item = orderSummary.value.orderItems.firstWhere(
        (element) => element.orderItemId == orderItemId,
      );

      if (newQuantity <= 0) {
        orderSummary.value.orderItems.remove(item);
      } else {
        item.quantity = newQuantity;
        item.calculateTotalAmount();
      }

      _updateTotals();
      orderSummary.refresh();
    } catch (e) {
      GlobalConfigProvider.logMessage(
          "Item with orderItemId $orderItemId not found.");
    }
  }

  void removeProduct(String orderItemId) {
    orderSummary.value.orderItems
        .removeWhere((item) => item.orderItemId == orderItemId);
    _updateTotals();
    orderSummary.refresh();
  }

  void printOrderSummary() {
    String summary = 'Resumen de la orden:\n';
    for (var item in orderSummary.value.orderItems) {
      summary +=
          'Producto: ${item.product.alias}, Cantidad: ${item.quantity}, Total: \$${item.totalAmount.toStringAsFixed(2)}\n';
    }
    summary +=
        'Monto Total: \$${orderSummary.value.totalAmount.toStringAsFixed(2)}';
    GlobalConfigProvider.logMessage(summary);
  }

  int getTotalQuantityForProduct(String productId) {
    int totalQuantity = 0;
    for (var item in orderSummary.value.orderItems) {
      if (item.product.id == productId) {
        totalQuantity += item.quantity;
      }
    }
    return totalQuantity;
  }

  void _updateTotals() {
    double newTotalAmount = 0.0;
    for (var item in orderSummary.value.orderItems) {
      newTotalAmount += item.totalAmount;
    }
    totalAmount.value = newTotalAmount;

    int newTotalProducts = 0;
    for (var item in orderSummary.value.orderItems) {
      newTotalProducts += item.quantity;
    }
    totalProducts.value = newTotalProducts;
  }

  Future<void> sendOrderSummaryToWhatsApp(BuildContext context) async {
    String? clientName = await _promptForInput(context, 'Nombre del cliente');
    if (clientName == null) return;
    if (!Get.isRegistered<OrderSummaryController>()) return;

    String? clientPhone =
        await _promptForInput(context, 'Teléfono del cliente');
    if (clientPhone == null) return;
    if (!Get.isRegistered<OrderSummaryController>()) return;

    orderSummary.value.client.name = clientName;
    orderSummary.value.client.phone = clientPhone;

    PaymentMethodModel? paymentMethod = await _promptForPaymentMethod(context);
    if (paymentMethod == null) return;
    if (!Get.isRegistered<OrderSummaryController>()) return;

    orderSummary.value.paymentMethod = paymentMethod;

    DeliveryTypeModel? deliveryType = await _promptForDeliveryType(context);
    if (deliveryType == null) return;
    if (!Get.isRegistered<OrderSummaryController>()) return;

    orderSummary.value.deliveryType = deliveryType;

    String phoneNumber = GlobalConfigProvider.branchCatalog!.brandWhatsApp;
    String message = generateOrderSummaryMessage();
    Open.whatsApp(whatsAppNumber: phoneNumber, text: message);
  }

  Future<String?> _promptForInput(BuildContext context, String label) async {
    TextEditingController controller = TextEditingController();
    String? result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(label),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: label),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop(controller.text);
              },
            ),
          ],
        );
      },
    );
    if (!Get.isRegistered<OrderSummaryController>()) return null;
    return result;
  }

  Future<PaymentMethodModel?> _promptForPaymentMethod(
      BuildContext context) async {
    List<PaymentMethodModel> methods = [
      PaymentMethodModel(method: 'Transferencia'),
      PaymentMethodModel(method: 'Efectivo'),
      PaymentMethodModel(method: 'Tarjeta'),
    ];

    PaymentMethodModel? result = await showDialog<PaymentMethodModel>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Método de pago'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: methods.map((method) {
              return ListTile(
                title: Text(method.method),
                onTap: () {
                  Navigator.of(context).pop(method);
                },
              );
            }).toList(),
          ),
        );
      },
    );
    if (!Get.isRegistered<OrderSummaryController>()) return null;
    return result;
  }

  Future<DeliveryTypeModel?> _promptForDeliveryType(
      BuildContext context) async {
    List<String> deliveryTypes = ['Para llevar', 'A domicilio'];

    String? selectedType = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tipo de entrega'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: deliveryTypes.map((type) {
              return ListTile(
                title: Text(type),
                onTap: () {
                  Navigator.of(context).pop(type);
                },
              );
            }).toList(),
          ),
        );
      },
    );

    if (!Get.isRegistered<OrderSummaryController>()) return null;
    if (selectedType == null) return null;

    if (selectedType == 'A domicilio') {
      AddressModel? address = await _promptForAddress(context);
      if (!Get.isRegistered<OrderSummaryController>()) return null;
      if (address == null) return null;

      return DeliveryTypeModel(type: 'A domicilio', address: address);
    } else {
      return DeliveryTypeModel(type: 'Para llevar');
    }
  }

  Future<AddressModel?> _promptForAddress(BuildContext context) async {
    TextEditingController streetController = TextEditingController();
    TextEditingController neighborhoodController = TextEditingController();
    TextEditingController interiorNumberController = TextEditingController();
    TextEditingController exteriorNumberController = TextEditingController();
    TextEditingController referenceController = TextEditingController();
    TextEditingController cityController = TextEditingController();
    TextEditingController zipCodeController = TextEditingController();

    AddressModel? result = await showDialog<AddressModel>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Dirección de entrega'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: streetController,
                decoration: const InputDecoration(hintText: 'Calle'),
              ),
              TextField(
                controller: neighborhoodController,
                decoration:
                    const InputDecoration(hintText: 'Colonia/Avenida/Barrio'),
              ),
              TextField(
                controller: interiorNumberController,
                decoration: const InputDecoration(hintText: 'Número Interior'),
              ),
              TextField(
                controller: exteriorNumberController,
                decoration: const InputDecoration(hintText: 'Número Exterior'),
              ),
              TextField(
                controller: referenceController,
                decoration: const InputDecoration(hintText: 'Referencia'),
              ),
              TextField(
                controller: cityController,
                decoration: const InputDecoration(hintText: 'Ciudad'),
              ),
              TextField(
                controller: zipCodeController,
                decoration: const InputDecoration(hintText: 'Código Postal'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop(AddressModel(
                  street: streetController.text,
                  neighborhood: neighborhoodController.text,
                  interiorNumber: interiorNumberController.text,
                  exteriorNumber: exteriorNumberController.text,
                  reference: referenceController.text,
                  city: cityController.text,
                  zipCode: zipCodeController.text,
                ));
              },
            ),
          ],
        );
      },
    );
    if (!Get.isRegistered<OrderSummaryController>()) return null;
    return result;
  }

  String generateOrderSummaryMessage() {
    String message = '*🍔 Resumen de la orden 🍟*\n\n';
    message += '*Código de pedido*: ${orderSummary.value.orderCode}\n\n';
    for (var item in orderSummary.value.orderItems) {
      message += '📦 *Producto*: *${item.product.alias}*\n';
      message += '🔢 *Cantidad*: ${item.quantity}\n';
      if (item.product.modifiersGroups.isNotEmpty) {
        for (var group in item.product.modifiersGroups) {
          if (group.modifiers.isNotEmpty) {
            message += '🔹 *${group.alias}*: ';
            message +=
                group.modifiers.map((modifier) => modifier.alias).join(', ');
            message += '\n';
          }
        }
      }
      if (item.notes.isNotEmpty) {
        message += '📝 *Notas*: ${item.notes}\n';
      }
      message += '💵 *Total*: \$${item.totalAmount.toStringAsFixed(2)}\n\n';
    }
    message +=
        '*💰 Monto Total*: \$${orderSummary.value.totalAmount.toStringAsFixed(2)}\n\n';
    message += '*👤 Cliente*: ${orderSummary.value.client.name}\n';
    message += '*📞 Teléfono*: ${orderSummary.value.client.phone}\n';
    message +=
        '*💳 Método de pago*: ${orderSummary.value.paymentMethod.method}\n';
    message +=
        '*🚚 Tipo de entrega*: ${orderSummary.value.deliveryType.type}\n';
    if (orderSummary.value.deliveryType.type == 'A domicilio' &&
        orderSummary.value.deliveryType.address != null) {
      var address = orderSummary.value.deliveryType.address!;
      message +=
          '*📍 Dirección*: ${address.street}, ${address.neighborhood}, No. Int. ${address.interiorNumber}, No. Ext. ${address.exteriorNumber}, Ref: ${address.reference}, ${address.city}, CP: ${address.zipCode}\n';
    }
    if (orderSummary.value.notes.isNotEmpty) {
      message += '📝 *Notas Generales*: ${orderSummary.value.notes}\n';
    }
    return message;
  }
}


 */