import 'package:weather_app/common/di/locator.dart';
import 'package:weather_app/features/forecast/data/providers/forecast_api/forecast_api_provider.dart';
import 'package:weather_app/features/forecast/data/repositories_impl/forecast_repository_impl.dart';
import 'package:weather_app/features/forecast/domain/use_cases/fetch_forecast_use_case.dart';

class ForecastInjection extends Injection {
  ForecastInjection({
    required super.serviceLocator,
  });

  @override
  void setup(serviceLocator) {
    serviceLocator
        .registerSingleton<ForecastApiProvider>(ForecastApiProvider());
    serviceLocator.registerSingleton<ForecastRepositoryImpl>(
      ForecastRepositoryImpl(
        apiProvider: locator<ForecastApiProvider>(),
      ),
    );
    serviceLocator.registerSingleton<FetchForecastUseCase>(
      FetchForecastUseCase(
        repositoryImpl: locator<ForecastRepositoryImpl>(),
      ),
    );
  }
}
