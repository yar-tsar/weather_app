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
  final double temp;
  final int humidity;
  final int pressure;
  final int windSpeed;

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
}
