import 'package:digital_menu_4urest/providers/image_provider.dart';
import 'package:flutter/material.dart';

class SectionVerticalItem extends StatelessWidget {
  const SectionVerticalItem({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
  });

  final String image;
  final String description;
  final String title;
  final String price;

  @override
  Widget build(BuildContext context) {
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
                image: CustomImageProvider.getNetworkImageIP(image),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            textAlign: TextAlign.start,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "MX\$${double.parse(price).toStringAsFixed(2)}",
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
