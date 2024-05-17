import 'package:equatable/equatable.dart';
import 'package:jiffy/jiffy.dart';
import 'package:weather_app/common/domain/models/weather_model.dart';

enum CurrentWeatherStateStatus {
  init,
  loading,
  success,
}

class CurrentWeatherState extends Equatable {
  const CurrentWeatherState({
    required this.status,
    this.weather,
  });

  final CurrentWeatherStateStatus status;
  final WeatherModel? weather;

  WeatherCondition? get condition => weather?.condition;

  String get temperature =>
      weather?.temp != null ? '${weather?.temp.round().toString()}°C' : '-- °C';

  String get humidity =>
      weather?.humidity != null ? '${weather?.humidity.toString()} %' : '-- %';

  String get windSpeed => weather?.windSpeed != null
      ? '${weather?.windSpeed.toString()} m/s'
      : '-- m/s';

  String get pressure => weather?.pressure != null
      ? '${weather?.pressure.toString()} hPa'
      : '-- hPa';

  String get timestamp => weather != null
      ? Jiffy.parseFromMillisecondsSinceEpoch(weather!.timestamp * 1000,
              isUtc: true)
          .toLocal()
          .Hm
      : '--';

  String get shareMessage =>
      'Hi! I am currently in $temperature, $humidity, $windSpeed, $pressure';

  bool get showStatusBar => status == CurrentWeatherStateStatus.loading;

  String get statusMessage {
    switch (status) {
      case CurrentWeatherStateStatus.loading:
        return 'Loading ...';
      default:
        return '';
    }
  }

  CurrentWeatherState copyWith({
    CurrentWeatherStateStatus? status,
    WeatherModel? weather,
  }) {
    return CurrentWeatherState(
      status: status ?? this.status,
      weather: weather ?? this.weather,
    );
  }

  @override
  List<Object?> get props => [
        status,
        weather,
      ];
}
