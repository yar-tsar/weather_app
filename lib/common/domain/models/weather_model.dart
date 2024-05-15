enum WeatherCondition {
  clearSky,
  fewClouds,
  scatteredClouds,
  brokenClouds,
  showerRain,
  rain,
  thunderstorm,
  snow,
  mist;
}

class WeatherModel {
  WeatherModel({
    required this.condition,
    required this.temp,
    required this.humidity,
    required this.pressure,
    required this.windSpeed,
  });

  final WeatherCondition condition;
  final num temp;
  final int humidity;
  final int pressure;
  final num windSpeed;

  String get description => weatherDescription(condition);

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final condition = weatherCondition(json['weather'][0]['description']);
    return WeatherModel(
      condition: condition,
      temp: json['main']['temp'],
      pressure: json['main']['pressure'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'],
    );
  }

  static WeatherCondition weatherCondition(String condition) {
    switch (condition) {
      case 'clear sky':
        return WeatherCondition.clearSky;
      case 'few clouds':
        return WeatherCondition.fewClouds;
      case 'scattered clouds':
        return WeatherCondition.scatteredClouds;
      case 'broken clouds':
        return WeatherCondition.brokenClouds;
      case 'shower rain':
        return WeatherCondition.showerRain;
      case 'rain':
        return WeatherCondition.rain;
      case 'thunderstorm':
        return WeatherCondition.thunderstorm;
      case 'snow':
        return WeatherCondition.snow;
      case 'mist':
        return WeatherCondition.mist;
      default:
        return WeatherCondition.clearSky;
    }
  }

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
}
