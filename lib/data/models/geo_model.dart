import '../../../domain/entities/geo_entity.dart';

class GeoModel extends GeoEntity{
  GeoModel(
    {required String lat,
    required String lng,}
  ) : super(lat,lng);

  factory GeoModel.fromJson(Map<String, dynamic> json) {
    return GeoModel(
      lat: json['lat']?.toString() ?? '',
      lng: json['lng']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "lat": lat,
      "lng" : lng,
    };
  }
}
