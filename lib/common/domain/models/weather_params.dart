enum WeatherUnit {
  standard,
  metric,
  imperial;

  String get unit => name;
}

class WeatherParams {
  final double latitude;
  final double longitude;
  final WeatherUnit unit;
  WeatherParams({
    required this.latitude,
    required this.longitude,
    required this.unit,
  });
}
