import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:digital_menu_4urest/providers/image_provider.dart';
import 'package:flutter/material.dart';

class Footer4urestWidget extends StatelessWidget {
  final bool isRow;

  const Footer4urestWidget({
    super.key,
    this.isRow = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GlobalConfigProvider.launchUrlLink('https://landing.4urest.mx/');
      },
      child: isRow
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Diseñado por',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 5),
                CustomImageProvider.getImage(
                    CustomImageProvider.png4uRestOriginal,
                    width: 200),
                Image.asset(
                  'assets/tools/logos/4uRestFont-white.png',
                  height: 35,
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Diseñado por',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Image.asset(
                  'assets/tools/logos/4uRestFont-white.png',
                  height: 35,
                ),
              ],
            ),
    );
  }
}
