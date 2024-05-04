import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Center(
              child: Text(
                GlobalConfigProvider.branchCatalog!.brandName,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 45, color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                GlobalConfigProvider.branchCatalog!.branchName,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 35, color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
