class LocationModel {
  LocationModel({
    required this.name,
    required this.country,
  });

  final String name;
  final String country;

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      name: json['name'],
      country: json['country'],
    );
  }
}
