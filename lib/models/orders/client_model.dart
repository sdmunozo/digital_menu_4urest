import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class ClientModel {
  String clientId;
  String name;
  String phone;

  ClientModel({
    String? clientId,
    required this.name,
    required this.phone,
  }) : clientId = clientId ?? uuid.v4();

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      clientId: json['clientId'],
      name: json['name'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clientId': clientId,
      'name': name,
      'phone': phone,
    };
  }
}
