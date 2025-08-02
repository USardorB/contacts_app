import '../../domain/entities/address_entity.dart';
import 'geo_model.dart';

class AddressModel extends AddressEntity{
  const AddressModel({
    required String street,
    required String suite,
    required String city,   
    required String zipcode,
    required GeoModel geo,
  }) : super(street: street, suite: suite, city: city, zipcode: zipcode, geo: geo);

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      street: json['street'],
      suite: json['suite'],
      city: json['city'],
      zipcode: json['zipcode'],
      geo: GeoModel.fromJson(json['geo']),
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
