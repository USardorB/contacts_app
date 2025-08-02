import '../../domain/entities/user_entity.dart';
import 'address_model.dart';
import 'company_model.dart';
import 'geo_model.dart';

class UserModel extends UserEntity{
  const UserModel({
    required int id,
    required String name,
    required String email,
    required String phone,
    String? website,
    AddressModel? address,
    GeoModel? geo,
    CompanyModel? company,
  }) : super(id: id,name: name,email: email,phone: phone,website: website,address: address,geo: geo,company: company);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      website: json['website'],
      address: AddressModel.fromJson(
        json['address'],
      ),
      geo: GeoModel.fromJson(json['address']['geo']),
      company: CompanyModel.fromJson(json['company']),
      
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
