import 'package:digital_menu_4urest/models/branch_catalog_model.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final BranchCatalogModel branchCatalogModel;

  const TitleWidget({
    super.key,
    required this.branchCatalogModel,
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
                  branchCatalogModel.brandName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 45, color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  branchCatalogModel.branchName,
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
                branchCatalogModel.brandSlogan,
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
