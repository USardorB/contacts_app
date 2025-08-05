import '../../../domain/entities/user_entity.dart';
import 'address_model.dart';
import 'company_model.dart';
import 'geo_model.dart';

class UserModel extends UserEntity{
  const UserModel({
    required int id,
    required String name,
    required String email,
    required String phone,
     required String website,
   required AddressModel address,
    required  GeoModel geo,
    required CompanyModel company,
  }) : super(id: id,name: name,email: email,phone: phone,website: website,address: address,geo: geo,company: company);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final addressJson = json['address'] ?? {};
    final geoJson = addressJson['geo'] ?? {};
    
    return UserModel(
      id: json['id']?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      website: json['website']?.toString() ?? '',
      address: AddressModel.fromJson(addressJson),
      geo: GeoModel.fromJson(geoJson),
      company: CompanyModel.fromJson(json['company'] ?? {}),
    );
  }

  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'website': website, 
      'address': (address as AddressModel).toJson(),
      'company': (company as CompanyModel).toJson(),
    };
  }
}
