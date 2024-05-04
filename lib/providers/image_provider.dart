import 'package:flutter/material.dart';

class CustomImageProvider {
  static const String png4uRestOriginal = 'assets/tools/logos/WBlue_4uRest.png';
  static String imageDefault = 'assets/tools/logos/4uRest-DM-3.png';
  static String imageDefaultBackground =
      'assets/tools/restaurant_background_op.png';
  static String imageDefaultBackgroundTest = 'assets/temp/HomeScreen3.PNG';

  static ImageProvider<Object> getNetworkImageIP(String? url) {
    //return AssetImage(imageDefaultBackgroundTest);
    if (url != null && url.isNotEmpty) {
      return NetworkImage(url);
    } else {
      return AssetImage(imageDefaultBackground);
    }
  }

  static Image getImage(String path, {double? width, double? height}) {
    return Image.asset(
      path,
      errorBuilder: (context, error, stackTrace) {
        return Image(
          image: AssetImage(imageDefault),
          width: width,
          height: height,
        );
      },
      width: width,
      height: height,
    );
  }

  static Image getNetworkImage(String? url, {double? width, double? height}) {
    if (url != null && url.isNotEmpty) {
      return Image.network(
        url,
        width: width,
        height: height,
        errorBuilder: (context, error, stackTrace) {
          return Image(
            image: AssetImage(imageDefault),
            width: width,
            height: height,
          );
        },
      );
    } else {
      return Image.asset(
        imageDefault,
        width: width,
        height: height,
      );
    }
  }
}
