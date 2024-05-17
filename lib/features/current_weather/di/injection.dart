import 'package:weather_app/common/di/locator.dart';
import 'package:weather_app/features/current_weather/data/providers/weather_api/weather_api_provider.dart';
import 'package:weather_app/features/current_weather/data/repositories_impl/weather_repository_impl.dart';
import 'package:weather_app/features/current_weather/domain/use_cases/fetch_weather_use_case.dart';

class CurrentWeatherInjection extends Injection {
  CurrentWeatherInjection({
    required super.serviceLocator,
  });

  @override
  void setup(serviceLocator) {
    serviceLocator.registerSingleton<WeatherApiProvider>(WeatherApiProvider());
    serviceLocator.registerSingleton<WeatherRepositoryImpl>(
      WeatherRepositoryImpl(
        apiProvider: locator<WeatherApiProvider>(),
      ),
    );
    serviceLocator.registerSingleton<FetchWeatherUseCase>(
      FetchWeatherUseCase(
        repositoryImpl: locator<WeatherRepositoryImpl>(),
      ),
    );
  }
}
