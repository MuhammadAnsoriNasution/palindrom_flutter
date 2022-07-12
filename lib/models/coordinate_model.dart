class CoordinateModel {
  late String city;
  late double lat;
  late double lng;
  late String country;

  CoordinateModel({
    required this.city,
    required this.lat,
    required this.lng,
    required this.country,
  });

  CoordinateModel.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    lat = double.parse(json['lat']);
    lng = double.parse(json['lng']);
    country = json['country'];
  }
}
