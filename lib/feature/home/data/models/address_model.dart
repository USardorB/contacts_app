import '../../domain/entities/address_entity.dart';
import 'geo_model.dart';

class AddressModel extends AddressEntity{
  const AddressModel({
    required super.street,
    required super.suite,
    required super.city,   
    required super.zipcode,
    required GeoModel super.geo,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      street: json['street']?.toString() ?? '',
      suite: json['suite']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      zipcode: json['zipcode']?.toString() ?? '',
      geo: GeoModel.fromJson(json['geo'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "street": street,
      "suite": suite,
      "city": city,
      "zipcode": zipcode,
      "geo": (geo as GeoModel).toJson(),
    };
  }
}
