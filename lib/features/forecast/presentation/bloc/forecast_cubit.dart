import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/common/domain/models/weather_params.dart';
import 'package:weather_app/features/forecast/domain/use_cases/fetch_forecast_use_case.dart';
import 'package:weather_app/features/forecast/presentation/bloc/forecast_state.dart';

class ForecastCubit extends Cubit<ForecastState> {
  ForecastCubit({
    required FetchForecastUseCase fetchForecastUseCase,
  })  : _fetchForecastUseCase = fetchForecastUseCase,
        super(ForecastState());

  final FetchForecastUseCase _fetchForecastUseCase;

  Future<void> fetchForecast(double? latitude, double? longitude) async {
    if (latitude == null || longitude == null) {
      throw Exception('No geo data');
    }

    final forecasts = await _fetchForecastUseCase.call(WeatherParams(
      latitude: latitude,
      longitude: longitude,
      unit: WeatherUnit.metric,
    ));
    emit(state.copyWith(forecasts: forecasts));
  }
}
