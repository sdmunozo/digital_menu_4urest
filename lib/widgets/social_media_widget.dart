import 'package:digital_menu_4urest/providers/global_config_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialMediaWidget extends StatelessWidget {
  const SocialMediaWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildCircularButton(FontAwesomeIcons.instagram,
            GlobalConfigProvider.branchCatalog!.instagramLink),
        const SizedBox(width: 20),
        _buildCircularButton(FontAwesomeIcons.facebook,
            GlobalConfigProvider.branchCatalog!.facebookLink),
        const SizedBox(width: 20),
        _buildCircularButton(FontAwesomeIcons.paperclip,
            GlobalConfigProvider.branchCatalog!.websiteLink),
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
