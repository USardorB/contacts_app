import 'address_entity.dart';
import 'company_entity.dart';
import 'geo_entity.dart';

class UserEntity {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String? website;
  final AddressEntity? address;
  final CompanyEntity? company;
  final GeoEntity? geo;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.website,
    this.address,
    this.company,
    this.geo,
  });
}
