import 'package:digital_menu_4urest/models/item_model.dart';
import 'package:digital_menu_4urest/providers/image_provider.dart';
import 'package:flutter/material.dart';

class SectionHorizontalItem extends StatelessWidget {
  const SectionHorizontalItem({
    super.key,
    required this.item,
  });

  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    String modifiersDetails = "";
    if (item.modifiersGroups.isNotEmpty &&
        item.modifiersGroups.first.modifiers.isNotEmpty) {
      for (var modifier in item.modifiersGroups.first.modifiers) {
        if (modifiersDetails.isNotEmpty) {
          modifiersDetails += " - ";
        }
        modifiersDetails +=
            "${modifier.alias} \$${double.parse(modifier.price).toStringAsFixed(2)}";
      }
    }

    return SizedBox(
      height: 120,
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
          ],
        ),
      ),
    );
  }
}
