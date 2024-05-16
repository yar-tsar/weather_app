import 'package:jiffy/jiffy.dart';
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

  String get timestamp => weather != null
      ? Jiffy.parseFromMillisecondsSinceEpoch(weather!.timestamp * 1000).Hm
      : '--';

  String get shareMessage =>
      'Hi! I am currently in $temperature, $humidity, $windSpeed, $pressure';

  CurrentWeatherState copyWith({
    WeatherModel? weather,
  }) {
    return CurrentWeatherState(
      weather: weather ?? this.weather,
    );
  }
}
