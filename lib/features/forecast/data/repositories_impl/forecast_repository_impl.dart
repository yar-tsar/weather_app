import 'package:weather_app/common/domain/models/weather_params.dart';
import 'package:weather_app/features/forecast/data/dtos/forecast_dto.dart';
import 'package:weather_app/features/forecast/data/providers/forecast_api/forecast_api_provider.dart';
import 'package:weather_app/features/forecast/domain/repositories/forecast_repository.dart';

class ForecastRepositoryImpl implements ForecastRepository {
  ForecastRepositoryImpl({
    required ForecastApiProvider apiProvider,
  }) : _forecastApiProvider = apiProvider;

  final ForecastApiProvider _forecastApiProvider;
  @override
  Future<ForecastDto> fetchForecast(WeatherParams params) {
    return _forecastApiProvider.fetchForecast(params);
  }
}
