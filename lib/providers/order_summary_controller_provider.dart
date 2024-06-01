import 'package:digital_menu_4urest/models/order_product.dart';
import 'package:digital_menu_4urest/models/order_summary.dart';
import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderSummaryControllerProvider extends GetxController {
  var products = <OrderProduct>[].obs;

  double get totalAmount =>
      products.fold(0, (sum, item) => sum + item.totalAmount);

  int get totalProducts =>
      products.fold(0, (sum, item) => sum + item.quantity.value);

  void addProduct(OrderProduct orderProduct) {
    orderProduct.calculateTotalAmount();
    products.add(orderProduct);
    update();
    //printOrderSummary();
    printProducts();
  }

  int getTotalQuantityForProduct(String productId) {
    return products
        .where((p) => p.product.id == productId)
        .fold(0, (sum, item) => sum + item.quantity.value);
  }

  void updateProduct(String orderId, int newQuantity) {
    var product = products.firstWhereOrNull((p) => p.orderProductId == orderId);
    if (product != null) {
      if (newQuantity <= 0) {
        removeProduct(orderId);
      } else {
        product.quantity.value = newQuantity;
        product.calculateTotalAmount();
      }
      update();
      //printOrderSummary();
      printProducts();
    }
  }

  void removeProduct(String orderId) {
    products.removeWhere((p) => p.orderProductId == orderId);
    update();
    //printOrderSummary();
    printProducts();
  }

  OrderSummary getOrderSummary() {
    return OrderSummary(
      products: products.toList(),
      totalAmount: totalAmount,
    );
  }

  void printOrderSummary() {
    OrderSummary summary = getOrderSummary();
    GlobalConfigProvider.logMessage(summary.toString());
  }

  void printProducts() {
    for (var product in products) {
      GlobalConfigProvider.logMessage(
          'Order ID: ${product.orderProductId}, Product ID: ${product.product.id}, Quantity: ${product.quantity.value}, Total Amount: ${product.totalAmount}');
    }
  }

  void printOrderDetails() {
    String message = "Resumen de la Orden:\n";
    for (var product in products) {
      message += "Orden ID: ${product.orderProductId}\n";
      message += "Producto ID: ${product.product.id}\n";
      message += "Nombre del Producto: ${product.product.alias}\n";
      message += "Cantidad: ${product.quantity.value}\n";
      message +=
          "Total del Producto: \$${product.totalAmount.toStringAsFixed(2)}\n";
      message += "Modificadores:\n";
      for (var group in product.product.modifiersGroups) {
        message += "  Grupo: ${group.alias}\n";
        for (var modifier in group.modifiers) {
          message += "    Modificador ID: ${modifier.id}\n";
          message += "    Nombre del Modificador: ${modifier.alias}\n";
          message += "    Precio del Modificador: \$${modifier.price}\n";
        }
      }
      if (product.notes.isNotEmpty) {
        message += "Notas: ${product.notes}\n";
      }
      message += "-----\n";
    }
    double totalAmount =
        products.fold(0.0, (sum, item) => sum + item.totalAmount);
    message += "Total General: \$${totalAmount.toStringAsFixed(2)}\n";

    GlobalConfigProvider.logMessage(message);
    sendWhatsAppMessage(message);
  }

  void sendWhatsAppMessage(String message) async {
    String phoneNumber =
        GlobalConfigProvider.branchCatalog!.brand.branches[0].whatsApp;
    String whatsappUrl =
        "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}";

    // ignore: deprecated_member_use
    if (await canLaunch(whatsappUrl)) {
      // ignore: deprecated_member_use
      await launch(whatsappUrl);
    } else {
      GlobalConfigProvider.logMessage("No se pudo abrir WhatsApp.");
    }
  }
}
