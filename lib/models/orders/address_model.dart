class AddressModel {
  String street;
  String neighborhood; // Colonia / Avenida / Barrio
  String interiorNumber;
  String exteriorNumber;
  String reference;
  String city;
  String zipCode;

  AddressModel({
    required this.street,
    required this.neighborhood,
    required this.interiorNumber,
    required this.exteriorNumber,
    required this.reference,
    required this.city,
    required this.zipCode,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      street: json['street'],
      neighborhood: json['neighborhood'],
      interiorNumber: json['interiorNumber'],
      exteriorNumber: json['exteriorNumber'],
      reference: json['reference'],
      city: json['city'],
      zipCode: json['zipCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'neighborhood': neighborhood,
      'interiorNumber': interiorNumber,
      'exteriorNumber': exteriorNumber,
      'reference': reference,
      'city': city,
      'zipCode': zipCode,
    };
  }
}



/* Modelo hasta antes de capturar direccion completa

class AddressModel {
  String street;
  String city;
  String state;
  String zipCode;
  String country;

  AddressModel({
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      street: json['street'],
      city: json['city'],
      state: json['state'],
      zipCode: json['zipCode'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'country': country,
    };
  }
}


*/