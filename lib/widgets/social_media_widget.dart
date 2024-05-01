import 'package:digital_menu_4urest/models/branch_catalog_model.dart';
import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialMediaWidget extends StatelessWidget {
  final BranchCatalogModel branchCatalogModel;

  const SocialMediaWidget({
    super.key,
    required this.branchCatalogModel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildCircularButton(
            FontAwesomeIcons.instagram, branchCatalogModel.instagramLink),
        const SizedBox(width: 20),
        _buildCircularButton(
            FontAwesomeIcons.facebook, branchCatalogModel.facebookLink),
        const SizedBox(width: 20),
        _buildCircularButton(
            FontAwesomeIcons.paperclip, branchCatalogModel.websiteLink),
      ],
    );
  }

  Widget _buildCircularButton(IconData iconData, String url) {
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
