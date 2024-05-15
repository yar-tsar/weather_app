import 'package:weather_app/common/domain/models/weather_model.dart';

class CurrentWeatherState {
  CurrentWeatherState({
    this.weather,
  });

  WeatherModel? weather;

  WeatherCondition? get condition => weather?.condition;

  String get temperature =>
      weather?.temp != null ? '${weather?.temp.toString()} °C' : '-- °C';

  String get humidity =>
      weather?.humidity != null ? '${weather?.humidity.toString()} %' : '-- %';

  String get windSpeed => weather?.windSpeed != null
      ? '${weather?.windSpeed.toString()} m/s'
      : '-- m/s';

  String get pressure => weather?.pressure != null
      ? '${weather?.pressure.toString()} hPa'
      : '-- hPa';

  CurrentWeatherState copyWith({
    WeatherModel? weather,
  }) {
    return CurrentWeatherState(
      weather: weather ?? this.weather,
    );
  }
}
