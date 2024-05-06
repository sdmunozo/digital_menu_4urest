import 'package:digital_menu_4urest/models/item_model.dart';
import 'package:digital_menu_4urest/providers/image_provider.dart';
import 'package:flutter/material.dart';

class SectionVerticalItem extends StatelessWidget {
  const SectionVerticalItem({super.key, required this.item});

  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    String modifiersDetails = "";
    if (item.modifiersGroups.isNotEmpty) {
      var firstGroup = item.modifiersGroups.first;
      ItemModel? displayedModifier;

      for (var modifier in firstGroup.modifiers) {
        if (modifier.isDisplayed == 'True') {
          displayedModifier = modifier;
          break;
        }
      }

      var finalModifier = displayedModifier ?? firstGroup.modifiers.first;

      modifiersDetails =
          "${finalModifier.alias} \$${double.parse(finalModifier.price).toStringAsFixed(2)}";
    }

    return Container(
      margin: const EdgeInsets.only(left: 13),
      width: 118,
      height: 200,
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
                image: CustomImageProvider.getNetworkImageIP(item.icon),
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
    );
  }
}
