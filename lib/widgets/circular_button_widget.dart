import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:flutter/material.dart';

class CircularButtonWidget extends StatelessWidget {
  final IconData iconData;
  final String url;
  const CircularButtonWidget(
      {super.key, required this.iconData, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => GlobalConfigProvider.launchUrlLink(url),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blueGrey.withOpacity(0.6),
        ),
        child: Icon(
          iconData,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
