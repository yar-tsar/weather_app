import 'package:weather_app/common/domain/models/weather_model.dart';
import 'package:weather_app/common/domain/models/weather_params.dart';

abstract class WeatherRepository {
  Future<WeatherModel> fetchWeather(WeatherParams params);
}
