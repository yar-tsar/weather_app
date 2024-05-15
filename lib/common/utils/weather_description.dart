import 'package:weather_app/common/domain/models/weather_model.dart';

weatherDescription(WeatherCondition condition) {
  switch (condition) {
    case WeatherCondition.clearSky:
      return 'Clear sky';
    case WeatherCondition.fewClouds:
      return 'Few clouds';
    case WeatherCondition.scatteredClouds:
      return 'Scattered clouds';
    case WeatherCondition.brokenClouds:
      return 'Broken clouds';
    case WeatherCondition.showerRain:
      return 'Shower rain';
    case WeatherCondition.rain:
      return 'Rain';
    case WeatherCondition.thunderstorm:
      return 'Thunderstorm';
    case WeatherCondition.snow:
      return 'Snow';
    case WeatherCondition.mist:
      return 'Mist';
    default:
      return 'No data';
  }
}
