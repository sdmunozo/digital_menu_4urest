import 'dart:convert';

import 'package:digital_menu_4urest/models/digital_menu/base_model_brand.dart';

BaseModelDigitalMenu baseModelDigitalMenuFromJson(String str) =>
    BaseModelDigitalMenu.fromJson(json.decode(str));

String baseModelDigitalMenuToJson(BaseModelDigitalMenu data) =>
    json.encode(data.toJson());

class BaseModelDigitalMenu {
  BaseModelBrand brand;

  BaseModelDigitalMenu({
    required this.brand,
  });

  factory BaseModelDigitalMenu.fromJson(Map<String, dynamic> json) =>
      BaseModelDigitalMenu(
        brand: BaseModelBrand.fromJson(json["brand"]),
      );

  Map<String, dynamic> toJson() => {
        "brand": brand.toJson(),
      };
}
