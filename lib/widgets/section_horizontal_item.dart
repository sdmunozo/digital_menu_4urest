import 'package:digital_menu_4urest/models/digital_menu/base_model_digital_menu.dart';
import 'package:digital_menu_4urest/models/digital_menu/base_model_product.dart';
import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:digital_menu_4urest/providers/orders/order_summary_controller.dart';
import 'package:digital_menu_4urest/screens/single_item_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SectionHorizontalItem extends StatelessWidget {
  const SectionHorizontalItem({
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
    } else if (item.modifiersGroups.isNotEmpty &&
        item.modifiersGroups.first.modifiers.isNotEmpty) {
      for (var modifier in item.modifiersGroups.first.modifiers) {
        if (modifiersDetails.isNotEmpty) {
          modifiersDetails += " - ";
        }
        if (modifier.price != 0) {
          modifiersDetails +=
              "${modifier.alias} \$${modifier.price.toStringAsFixed(2)}";
        } else {
          modifiersDetails += modifier.alias;
        }
      }
    }

/*
    String modifiersDetails = "";
    if (item.modifiersGroups.isNotEmpty &&
        item.modifiersGroups.first.modifiers.isNotEmpty) {
      for (var modifier in item.modifiersGroups.first.modifiers) {
        if (modifiersDetails.isNotEmpty) {
          modifiersDetails += " - ";
        }
        if (double.parse(modifier.price) != 0) {
          modifiersDetails +=
              "${modifier.alias} \$${double.parse(modifier.price).toStringAsFixed(2)}";
        } else {
          modifiersDetails += modifier.alias;
        }
      }
    }*/

    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (BuildContext context) => SingleItemScreen(
          product: item,
          calledFrom: calledFrom,
        ),
      ),
      child: Container(
        color: GlobalConfigProvider.backgroundColor,
        child: SizedBox(
          height: GlobalConfigProvider.sectionHorizontalItemHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          item.alias,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2, right: 15),
                        child: Text(
                          item.description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xff88888a),
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Text(
                        modifiersDetails,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Align(
                  alignment: Alignment.topCenter,
                  child: Stack(
                    children: [
                      Container(
                        width: item.image.isEmpty ? 40 : 118,
                        height: 118,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: item.image.isEmpty
                              ? null
                              : DecorationImage(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




/*
class SectionHorizontalItem extends StatelessWidget {
  const SectionHorizontalItem({
    super.key,
    required this.item,
    required this.calledFrom,
  });

  final ProductModel item;
  final String calledFrom;

  @override
  Widget build(BuildContext context) {
    String modifiersDetails = "";
    if (item.modifiersGroups.isNotEmpty &&
        item.modifiersGroups.first.modifiers.isNotEmpty) {
      for (var modifier in item.modifiersGroups.first.modifiers) {
        if (modifiersDetails.isNotEmpty) {
          modifiersDetails += " - ";
        }
        if (double.parse(modifier.price) != 0) {
          modifiersDetails +=
              "${modifier.alias} \$${double.parse(modifier.price).toStringAsFixed(2)}";
        } else {
          modifiersDetails += modifier.alias;
        }
      }
    }

    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (BuildContext context) => ShowItemModalWidget(
          product: item,
          calledFrom: calledFrom,
        ),
      ),
      child: Container(
        color: GlobalConfigProvider.backgroundColor,
        child: SizedBox(
          height: GlobalConfigProvider.sectionHorizontalItemHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Row(
              children: [
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        item.alias,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2, right: 15),
                      child: Text(
                        item.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xff88888a),
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Text(
                      modifiersDetails,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                )),
                const SizedBox(
                  width: 8,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 118,
                    height: 118,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image:
                            CustomImageProvider.getNetworkImageIP(item.image),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

*/