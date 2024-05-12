import 'package:flutter/material.dart';

class CustomImageProvider {
  static const String png4uRestOriginal = 'assets/tools/logos/WBlue_4uRest.png';
  static const String imageDefault = 'assets/tools/logos/4uRest-DM-3.png';
  static const String imageDefaultBackground =
      'assets/tools/restaurant_background_op.png';
  static const String imageDefaultBackgroundTest =
      'assets/temp/HomeScreen1.PNG';

  static ImageProvider<Object> getNetworkImageIP(String? url) {
    if (url != null && url.isNotEmpty) {
      return NetworkImage(url);
    } else {
      return const AssetImage(imageDefaultBackground);
    }
  }

  static Image getImage(String path, {double? width, double? height}) {
    return Image.asset(
      path,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          imageDefault,
          width: width,
          height: height,
        );
      },
      width: width,
      height: height,
    );
  }
}
