import 'package:weather_app/features/forecast/domain/models/forecast_model.dart';

class ForecastDto {
  final List<ForecastModel> forecasts;
  ForecastDto({required this.forecasts});

  factory ForecastDto.fromJson(Map<String, dynamic> json) {
    List<ForecastModel> forecastList = [];
    for (var item in json['list']) {
      forecastList.add(ForecastModel.fromJson(item));
    }
    return ForecastDto(forecasts: forecastList);
  }
}
