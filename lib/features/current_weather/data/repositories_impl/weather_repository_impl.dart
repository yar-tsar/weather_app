import 'package:weather_app/common/domain/models/weather_model.dart';
import 'package:weather_app/features/current_weather/data/providers/weather_api/weather_api_provider.dart';
import 'package:weather_app/features/current_weather/domain/repositories/weather_repository.dart';
import 'package:weather_app/common/domain/models/weather_params.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  WeatherRepositoryImpl({required WeatherApiProvider apiProvider})
      : _apiProvider = apiProvider;
  final WeatherApiProvider _apiProvider;
  @override
  Future<WeatherModel> fetchWeather(WeatherParams params) {
    return _apiProvider.fetchWeather(params);
  }
}
