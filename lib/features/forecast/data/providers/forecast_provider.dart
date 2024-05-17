import 'package:weather_app/common/domain/models/weather_params.dart';
import 'package:weather_app/features/forecast/data/dtos/forecast_dto.dart';

abstract class ForecastProvider {
  Future<ForecastDto> fetchForecast(WeatherParams params);
}
