import 'package:weather_app/common/domain/models/weather_model.dart';
import 'package:weather_app/common/domain/use_cases/use_case.dart';
import 'package:weather_app/features/current_weather/data/repositories_impl/weather_repository_impl.dart';
import 'package:weather_app/common/domain/models/weather_params.dart';

class FetchWeatherUseCase extends UseCase<WeatherParams, WeatherModel> {
  FetchWeatherUseCase({
    required WeatherRepositoryImpl repositoryImpl,
  }) : _repositoryImpl = repositoryImpl;

  final WeatherRepositoryImpl _repositoryImpl;
  @override
  Future<WeatherModel> call(WeatherParams params) {
    return _repositoryImpl.fetchWeather(params);
  }
}
