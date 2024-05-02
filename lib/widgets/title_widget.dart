import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
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
          const Spacer(),
          Column(
            children: [
              Text(
                GlobalConfigProvider.branchCatalog!.brandSlogan,
                style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1),
              ),
            ],
          )
        ],
      ),
    );
  }
}
