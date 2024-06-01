import 'package:digital_menu_4urest/models/order_product.dart';

class OrderSummary {
  List<OrderProduct> products;
  double totalAmount;

  OrderSummary({
    required this.products,
    required this.totalAmount,
  });

  // Método para convertir el resumen de la orden a JSON
  Map<String, dynamic> toJson() => {
        "products": products.map((product) => product.toJson()).toList(),
        "totalAmount": totalAmount,
      };

  // Método para imprimir el resumen de la orden en un formato legible
  @override
  String toString() {
    return 'OrderSummary(products: ${products.map((product) => product.toString()).toList()}, totalAmount: $totalAmount)';
  }
}
