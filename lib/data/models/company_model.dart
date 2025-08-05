import '../../../domain/entities/company_entity.dart';

class CompanyModel extends CompanyEntity{
  @override
  final String name;
  final String catchPhrase;
  final String bs;

  const CompanyModel({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  }) : super(name: name, catchPhrase: catchPhrase, bs: bs);

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      name: json['name']?.toString() ?? '',
      catchPhrase: json['catchPhrase']?.toString() ?? '',
      bs: json['bs']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "catchPhrase": catchPhrase, "bs": bs};
  }
}
