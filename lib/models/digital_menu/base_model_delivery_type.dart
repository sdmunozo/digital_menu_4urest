import 'package:digital_menu_4urest/models/orders/address_model.dart';

class BaseModelDeliveryType {
  String id;
  String type;
  AddressModel? address;

  BaseModelDeliveryType({
    this.id = '',
    required this.type,
    this.address,
  });

  factory BaseModelDeliveryType.fromJson(Map<String, dynamic> json) =>
      BaseModelDeliveryType(
        id: json["id"] ?? '',
        type: json["type"] ?? '',
        address: json['address'] != null
            ? AddressModel.fromJson(json['address'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        'address': address?.toJson(),
      };
}
