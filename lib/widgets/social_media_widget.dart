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
        _buildCircularButton(
            iconData: FontAwesomeIcons.instagram,
            url: GlobalConfigProvider.branchCatalog!.brand.instagram,
            origin: "welcome-screen",
            destination: "brand-instagram"),
        const SizedBox(width: 20),
        _buildCircularButton(
            iconData: FontAwesomeIcons.facebook,
            url: GlobalConfigProvider.branchCatalog!.brand.facebook,
            origin: "welcome-screen",
            destination: "brand-facebook"),
        const SizedBox(width: 20),
        _buildCircularButton(
            iconData: FontAwesomeIcons.paperclip,
            url: GlobalConfigProvider.branchCatalog!.brand.website,
            origin: "welcome-screen",
            destination: "brand-link"),
      ],
    );
  }

  Widget _buildCircularButton(
      {required IconData iconData,
      required String url,
      required String origin,
      required String destination}) {
    return GestureDetector(
      onTap: () {
        GlobalConfigProvider.recordClickEventMetric(
          origin: origin,
          clickedElement: "social-media",
          destination: destination,
        );
        GlobalConfigProvider.launchUrlLink(url);
      },
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
