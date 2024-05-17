import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/common/domain/models/weather_params.dart';
import 'package:weather_app/features/current_weather/domain/use_cases/fetch_weather_use_case.dart';
import 'package:weather_app/features/current_weather/presentation/bloc/current_weather_state.dart';

class CurrentWeatherCubit extends Cubit<CurrentWeatherState> {
  CurrentWeatherCubit({required FetchWeatherUseCase fetchWeatherUseCase})
      : _fetchWeatherUseCase = fetchWeatherUseCase,
        super(
          CurrentWeatherState(),
        );

  final FetchWeatherUseCase _fetchWeatherUseCase;
  Future<void> fetchWeather(double? latitude, double? longitude) async {
    if (latitude == null || longitude == null) {
      throw Exception('No geo data');
    }

    final weather = await _fetchWeatherUseCase.call(WeatherParams(
      latitude: latitude,
      longitude: longitude,
      unit: WeatherUnit.metric,
    ));
    emit(state.copyWith(weather: weather));
  }
}
