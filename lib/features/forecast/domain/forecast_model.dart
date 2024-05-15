import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/common/domain/models/weather_model.dart';

part 'forecast_model.g.dart';

@JsonSerializable()
class ForecastModel {
  ForecastModel({
    required this.date,
    required this.forecast,
  });

  final DateTime date;
  final WeatherModel forecast;

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    return _$ForecastModelFromJson(json);
  }
}
