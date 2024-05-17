import 'package:weather_app/common/domain/models/weather_model.dart';

class ForecastModel {
  ForecastModel({
    required this.date,
    required this.weather,
  });

  final int date;
  final WeatherModel weather;

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    return ForecastModel(
      date: json['dt'],
      weather: WeatherModel.fromJson(json),
    );
  }
}
