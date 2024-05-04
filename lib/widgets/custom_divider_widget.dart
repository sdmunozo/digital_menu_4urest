import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:flutter/material.dart';

class CustomDividerWidget extends StatelessWidget {
  const CustomDividerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2),
      child: Container(
        width: GlobalConfigProvider.maxWidth,
        height: 1,
        decoration: BoxDecoration(
          color: const Color.fromARGB(45, 136, 136, 138),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
