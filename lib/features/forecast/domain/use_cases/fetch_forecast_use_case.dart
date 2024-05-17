import 'package:weather_app/common/domain/models/weather_params.dart';
import 'package:weather_app/common/domain/use_cases/use_case.dart';
import 'package:weather_app/features/forecast/data/repositories_impl/forecast_repository_impl.dart';
import 'package:weather_app/features/forecast/domain/models/forecast_model.dart';

class FetchForecastUseCase extends UseCase<WeatherParams, List<ForecastModel>> {
  FetchForecastUseCase({
    required ForecastRepositoryImpl repositoryImpl,
  }) : _repositoryImpl = repositoryImpl;

  final ForecastRepositoryImpl _repositoryImpl;
  @override
  Future<List<ForecastModel>> call(WeatherParams params) {
    final result = _repositoryImpl.fetchForecast(params);

    return result.then((value) => value.forecasts);
  }
}
