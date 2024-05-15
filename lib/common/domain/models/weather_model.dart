import 'package:json_annotation/json_annotation.dart';

part 'weather_model.g.dart';

enum WeatherCondition {
  clearSky,
  fewClouds,
  scatteredClouds,
  brokenClouds,
  showerRain,
  rain,
  thunderstorm,
  snow,
  mist,
}

@JsonSerializable()
class WeatherModel {
  WeatherModel({
    required this.condition,
    required this.temp,
    required this.humidity,
    required this.pressure,
    required this.windSpeed,
  });

  final WeatherCondition condition;
  final double temp;
  final int humidity;
  final int pressure;
  final double windSpeed;

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return _$WeatherModelFromJson(json);
  }
}
