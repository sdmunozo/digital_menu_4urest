import 'package:digital_menu_4urest/models/orders/address_model.dart';

class DeliveryTypeModel {
  String type;
  AddressModel? address;

  DeliveryTypeModel({
    required this.type,
    this.address,
  });

  factory DeliveryTypeModel.fromJson(Map<String, dynamic> json) {
    return DeliveryTypeModel(
      type: json['type'],
      address: json['address'] != null
          ? AddressModel.fromJson(json['address'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'address': address?.toJson(),
    };
  }
}
