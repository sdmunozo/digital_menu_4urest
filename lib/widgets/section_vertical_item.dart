import 'package:digital_menu_4urest/models/digital_menu/base_model_product.dart';
import 'package:digital_menu_4urest/models/product_model.dart';
import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:digital_menu_4urest/providers/orders/order_summary_controller.dart';
import 'package:digital_menu_4urest/screens/single_item_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SectionVerticalItem extends StatelessWidget {
  const SectionVerticalItem({
    super.key,
    required this.item,
    required this.calledFrom,
  });

  final BaseModelProduct item;
  final String calledFrom;

  @override
  Widget build(BuildContext context) {
    final OrderSummaryController orderController =
        Get.find<OrderSummaryController>();

    String modifiersDetails = "";
    if (item.price > 0) {
      modifiersDetails = "\$${item.price.toStringAsFixed(2)}";
    } else if (item.modifiersGroups.isNotEmpty) {
      var firstGroup = item.modifiersGroups.first;
      var finalModifier = firstGroup.modifiers.first;
      if (finalModifier.price != 0) {
        modifiersDetails =
            "${finalModifier.alias} \$${finalModifier.price.toStringAsFixed(2)}";
      } else {
        modifiersDetails = finalModifier.alias;
      }
    }

    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (BuildContext context) =>
            SingleItemScreen(product: item, calledFrom: calledFrom),
      ),
      child: Container(
        color: GlobalConfigProvider.backgroundColor,
        margin: const EdgeInsets.only(left: 13),
        width: 118,
        height: GlobalConfigProvider.sectionVerticalItemHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Stack(
              children: [
                item.image.isEmpty
                    ? Container(
                        width: 118,
                        height: 118,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: GlobalConfigProvider.backgroundColor
                            //color: Colors.grey.shade300, // Fondo gris claro
                            ),
                        child: Center(
                          child: Icon(
                            Icons.add,
                            //.image_not_supported, // Ícono para imagen no disponible
                            //color: Colors.grey.shade700,
                            color: Colors.grey.shade700,
                            size: 40,
                          ),
                        ),
                      )
                    : Container(
                        width: 118,
                        height: 118,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(item.image),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                Obx(() {
                  int quantityInCart =
                      orderController.getTotalQuantityForProduct(item.id);
                  return Positioned(
                    bottom: 4,
                    right: 4,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          quantityInCart > 0 ? '$quantityInCart' : '+',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),

            /*
            Stack(
              children: [
                Container(
                  width: 118,
                  height: 118,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(item.image),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Obx(() {
                  int quantityInCart =
                      orderController.getTotalQuantityForProduct(item.id);
                  return Positioned(
                    bottom: 4,
                    right: 4,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          quantityInCart > 0 ? '$quantityInCart' : '+',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),*/
            const SizedBox(height: 2),
            Text(
              item.alias,
              textAlign: TextAlign.start,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              modifiersDetails,
              textAlign: TextAlign.start,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/*
class SectionVerticalItem extends StatelessWidget {
  const SectionVerticalItem({
    super.key,
    required this.item,
    required this.calledFrom,
  });

  final ProductModel item;
  final String calledFrom;

  @override
  Widget build(BuildContext context) {
    final OrderSummaryController orderController =
        Get.find<OrderSummaryController>();

    String modifiersDetails = "";
    if (item.modifiersGroups.isNotEmpty) {
      var firstGroup = item.modifiersGroups.first;

      var finalModifier = firstGroup.modifiers.first;
      if (double.parse(finalModifier.price) != 0) {
        modifiersDetails =
            "${finalModifier.alias} \$${double.parse(finalModifier.price).toStringAsFixed(2)}";
      } else {
        modifiersDetails = finalModifier.alias;
      }
    }

    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (BuildContext context) =>
            SingleItemScreen(product: item, calledFrom: calledFrom),
      ),
      child: Container(
        color: GlobalConfigProvider.backgroundColor,
        margin: const EdgeInsets.only(left: 13),
        width: 118,
        height: GlobalConfigProvider.sectionVerticalItemHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Stack(
              children: [
                Container(
                  width: 118,
                  height: 118,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: CustomImageProvider.getNetworkImageIP(item.image),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Obx(() {
                  int quantityInCart =
                      orderController.getTotalQuantityForProduct(item.id);
                  return Positioned(
                    bottom: 4,
                    right: 4,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          quantityInCart > 0 ? '$quantityInCart' : '+',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              item.alias,
              textAlign: TextAlign.start,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              modifiersDetails,
              textAlign: TextAlign.start,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
                fontSize: 14,
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
class SectionVerticalItem extends StatelessWidget {
  const SectionVerticalItem({
    super.key,
    required this.item,
    required this.calledFrom,
  });

  final ProductModel item;
  final String calledFrom;

  @override
  Widget build(BuildContext context) {
    String modifiersDetails = "";
    if (item.modifiersGroups.isNotEmpty) {
      var firstGroup = item.modifiersGroups.first;

      var finalModifier = firstGroup.modifiers.first;
      if (double.parse(finalModifier.price) != 0) {
        modifiersDetails =
            "${finalModifier.alias} \$${double.parse(finalModifier.price).toStringAsFixed(2)}";
      } else {
        modifiersDetails = finalModifier.alias;
      }
    }

    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (BuildContext context) =>
            ShowItemModalWidget(product: item, calledFrom: calledFrom),
      ),
      child: Container(
        color: GlobalConfigProvider.backgroundColor,
        margin: const EdgeInsets.only(left: 13),
        width: 118,
        height: GlobalConfigProvider.sectionVerticalItemHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),
            Container(
              width: 118,
              height: 118,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: CustomImageProvider.getNetworkImageIP(item.image),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              item.alias,
              textAlign: TextAlign.start,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              modifiersDetails,
              textAlign: TextAlign.start,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

*/