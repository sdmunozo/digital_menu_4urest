import 'package:digital_menu_4urest/models/digital_menu/base_model_product.dart';
import 'package:digital_menu_4urest/models/orders/order_item_model.dart';
import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:digital_menu_4urest/providers/orders/order_summary_controller.dart';
import 'package:digital_menu_4urest/providers/orders/product_controller.dart';
import 'package:digital_menu_4urest/widgets/custom_divider_widget.dart';
import 'package:digital_menu_4urest/widgets/show_item_widgets/product_modifiers_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

class SingleItemScreen extends StatelessWidget {
  const SingleItemScreen(
      {super.key, required this.product, required this.calledFrom});
  final BaseModelProduct product;
  final String calledFrom;

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.put(ProductController());
    final OrderSummaryController orderSummaryController =
        Get.find<OrderSummaryController>();

    productController.initialize(product);

    return Dialog(
      insetPadding: const EdgeInsets.only(top: 20),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Container(
        height: GlobalConfigProvider.maxHeight,
        width: GlobalConfigProvider.maxWidth,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: GlobalConfigProvider.backgroundColor,
        ),
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: product.image.isEmpty
                        ? 30
                        : (GlobalConfigProvider.maxHeight * 0.5),
//expandedHeight: (GlobalConfigProvider.maxHeight * 0.5),
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        product.alias,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          shadows: [
                            const Shadow(
                              color: Colors.white,
                              offset: Offset(0, 0),
                              blurRadius: 20,
                            ),
                          ],
                        ),
                      ),
                      background: product.image.isEmpty
                          ? Container()
                          : Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  child: Container(
                                    height:
                                        (GlobalConfigProvider.maxHeight * 0.5),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(product.image),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.description,
                            style: const TextStyle(
                              color: Color(0xff88888a),
                              fontSize: 14,
                            ),
                          ),
                          if (product.price > 0)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'Precio: \$${product.price}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: CustomDividerWidget(),
                  ),
                  SliverToBoxAdapter(
                    child: ProductModifiersListWidget(
                      product: product,
                      onSelectionChanged: (isValid, summary) {},
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Obx(() => IconButton(
                        icon: const Icon(
                          Icons.remove,
                          size: 30,
                        ),
                        onPressed: productController.quantity.value > 1
                            ? productController.decrementQuantity
                            : null,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Obx(() => Text(productController.quantity.toString())),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.add,
                      size: 30,
                    ),
                    onPressed: productController.incrementQuantity,
                  ),
                  const Spacer(),
                  GetBuilder<ProductController>(
                    id: 'addButton',
                    builder: (controller) {
                      return FittedBox(
                        fit: BoxFit.scaleDown,
                        child: ElevatedButton.icon(
                          onPressed: controller.areAllRequiredGroupsSelected
                              ? () {
                                  var uuid = const Uuid();
                                  BaseModelProduct productCopy = product.copy();

                                  OrderItemModel orderItem = OrderItemModel(
                                    orderItemId: uuid.v4(),
                                    product: productCopy,
                                    notes: productController.notes.value,
                                    quantity: productController.quantity.value,
                                    totalAmount: product.price *
                                        productController.quantity.value,
                                    timestamp: DateTime.now(),
                                  );

                                  orderItem.product.modifiersGroups =
                                      productCopy.modifiersGroups.map((group) {
                                    group.modifiers = group.modifiers
                                        .where((modifier) => productController
                                            .selectedModifiers[group.id]!
                                            .contains(modifier.id))
                                        .toList();
                                    return group;
                                  }).toList();

                                  orderItem.calculateTotalAmount();
                                  orderSummaryController.addProduct(orderItem);
                                  orderSummaryController.printOrderSummary();
                                  Navigator.pop(context);
                                }
                              : null,
                          icon: const Icon(Icons.check, color: Colors.white),
                          label: const Text(
                            'Agregar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 14.0, horizontal: 24.0),
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



/*
class SingleItemScreen extends StatelessWidget {
  const SingleItemScreen(
      {super.key, required this.product, required this.calledFrom});
  final ProductModel product;
  final String calledFrom;

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.put(ProductController());
    final OrderSummaryController orderSummaryController =
        Get.find<OrderSummaryController>();

    productController.initialize(product);

    return Dialog(
      insetPadding: const EdgeInsets.only(top: 20),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Container(
        height: GlobalConfigProvider.maxHeight,
        width: GlobalConfigProvider.maxWidth,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: GlobalConfigProvider.backgroundColor,
        ),
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: (GlobalConfigProvider.maxHeight * 0.5),
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        product.alias,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          shadows: [
                            const Shadow(
                              color: Colors.white,
                              offset: Offset(0, 0),
                              blurRadius: 20,
                            ),
                          ],
                        ),
                      ),
                      background: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            child: Container(
                              height: (GlobalConfigProvider.maxHeight * 0.5),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: CustomImageProvider.getNetworkImageIP(
                                      product.image),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.description,
                            style: const TextStyle(
                              color: Color(0xff88888a),
                              fontSize: 14,
                            ),
                          ),
                          if (product.price.isNotEmpty &&
                              double.tryParse(product.price) != null &&
                              double.parse(product.price) > 0)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                'Precio: \$${product.price}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: CustomDividerWidget(),
                  ),
                  SliverToBoxAdapter(
                    child: ProductModifiersListWidget(
                      product: product,
                      onSelectionChanged: (isValid, summary) {},
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Obx(() => IconButton(
                        icon: const Icon(
                          Icons.remove,
                          size: 30,
                        ),
                        onPressed: productController.quantity.value > 1
                            ? productController.decrementQuantity
                            : null,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Obx(() => Text(productController.quantity.toString())),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.add,
                      size: 30,
                    ),
                    onPressed: productController.incrementQuantity,
                  ),
                  const Spacer(),
                  GetBuilder<ProductController>(
                    id: 'addButton',
                    builder: (controller) {
                      return LayoutBuilder(
                        builder: (context, constraints) {
                          double fontSize =
                              constraints.maxWidth < 350 ? 14 : 16;
                          double verticalPadding =
                              constraints.maxWidth < 350 ? 10 : 14;
                          double horizontalPadding =
                              constraints.maxWidth < 350 ? 16 : 24;

                          return Expanded(
                            child: ElevatedButton.icon(
                              onPressed: controller.areAllRequiredGroupsSelected
                                  ? () {
                                      var uuid = const Uuid();
                                      ProductModel productCopy = product.copy();

                                      OrderItemModel orderItem = OrderItemModel(
                                        orderItemId: uuid.v4(),
                                        product: productCopy,
                                        notes: productController.notes.value,
                                        quantity:
                                            productController.quantity.value,
                                        totalAmount:
                                            double.parse(product.price) *
                                                productController
                                                    .quantity.value,
                                        timestamp: DateTime.now(),
                                      );

                                      orderItem.product.modifiersGroups =
                                          productCopy.modifiersGroups
                                              .map((group) {
                                        group.modifiers = group.modifiers
                                            .where((modifier) =>
                                                productController
                                                    .selectedModifiers[
                                                        group.id]!
                                                    .contains(modifier.id))
                                            .toList();
                                        return group;
                                      }).toList();

                                      orderItem.calculateTotalAmount();
                                      orderSummaryController
                                          .addProduct(orderItem);
                                      orderSummaryController
                                          .printOrderSummary();
                                      Navigator.pop(context);
                                    }
                                  : null,
                              icon:
                                  const Icon(Icons.check, color: Colors.white),
                              label: Text(
                                'Agregar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    vertical: verticalPadding,
                                    horizontal: horizontalPadding),
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/

/* 
class SingleItemScreen extends StatelessWidget {
  const SingleItemScreen(
      {super.key, required this.product, required this.calledFrom});
  final ProductModel product;
  final String calledFrom;

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.put(ProductController());
    final OrderSummaryController orderSummaryController =
        Get.find<OrderSummaryController>();

    productController.initialize(product); // Inicializar con el producto

    return Dialog(
      insetPadding: const EdgeInsets.only(top: 20),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Container(
        height: GlobalConfigProvider.maxHeight,
        width: GlobalConfigProvider.maxWidth,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: GlobalConfigProvider.backgroundColor,
        ),
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: (GlobalConfigProvider.maxHeight * 0.5),
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        product.alias,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          shadows: [
                            const Shadow(
                              color: Colors.white,
                              offset: Offset(0, 0),
                              blurRadius: 20,
                            ),
                          ],
                        ),
                      ),
                      background: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            child: Container(
                              height: (GlobalConfigProvider.maxHeight * 0.5),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: CustomImageProvider.getNetworkImageIP(
                                      product.image),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20),
                      child: Text(
                        product.description,
                        style: const TextStyle(
                          color: Color(0xff88888a),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: CustomDividerWidget(),
                  ),
                  SliverToBoxAdapter(
                    child: ProductModifiersListWidget(
                      product: product,
                      onSelectionChanged: (isValid, summary) {},
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Obx(() => IconButton(
                        icon: const Icon(
                          Icons.remove,
                          size: 30,
                        ),
                        onPressed: productController.quantity.value > 1
                            ? productController.decrementQuantity
                            : null,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Obx(() => Text(productController.quantity.toString())),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.add,
                      size: 30,
                    ),
                    onPressed: productController.incrementQuantity,
                  ),
                  const Spacer(),
                  GetBuilder<ProductController>(
                    id: 'addButton',
                    builder: (controller) {
                      return Expanded(
                        child: ElevatedButton.icon(
                          onPressed: controller.areAllRequiredGroupsSelected
                              ? () {
                                  var uuid = const Uuid();
                                  ProductModel productCopy = product.copy();

                                  OrderItemModel orderItem = OrderItemModel(
                                    orderItemId: uuid.v4(),
                                    product: productCopy,
                                    notes: productController.notes.value,
                                    quantity: productController.quantity.value,
                                    totalAmount: double.parse(product.price) *
                                        productController.quantity.value,
                                    timestamp: DateTime.now(),
                                  );

                                  orderItem.product.modifiersGroups =
                                      productCopy.modifiersGroups.map((group) {
                                    group.modifiers = group.modifiers
                                        .where((modifier) => productController
                                            .selectedModifiers[group.id]!
                                            .contains(modifier.id))
                                        .toList();
                                    return group;
                                  }).toList();

                                  orderSummaryController.addProduct(orderItem);
                                  orderSummaryController.printOrderSummary();

                                  //String orderItemJson = jsonEncode(orderItem.toJson());
                                  //GlobalConfigProvider.logMessage(orderItemJson);
                                  Navigator.pop(context);
                                }
                              : null,
                          icon: const Icon(Icons.check, color: Colors.white),
                          label: const Text(
                            'Agregar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 14.0, horizontal: 24.0),
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


*/