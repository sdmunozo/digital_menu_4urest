import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:flutter/material.dart';

class SloganWidget extends StatelessWidget {
  const SloganWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          GlobalConfigProvider.branchCatalog!.brand.slogan,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 25,
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}
