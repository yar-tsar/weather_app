import 'package:dio/dio.dart';
import 'package:weather_app/common/data/dio_client.dart';
import 'package:weather_app/common/domain/models/weather_model.dart';
import 'package:weather_app/features/current_weather/data/providers/weather_provider.dart';
import 'package:weather_app/common/domain/models/weather_params.dart';

class WeatherApiProvider implements WeatherProvider {
  final dioClient = DioClient('data');

  @override
  Future<WeatherModel> fetchWeather(WeatherParams params) async {
    try {
      final result = await dioClient.get(
        '/2.5/weather',
        queryParameters: {
          'lat': params.latitude,
          'lon': params.longitude,
          'units': params.unit.name,
        },
      );
      if (result.data == null) {
        throw Exception('Unknown Error ${result.statusCode}');
      }
      return WeatherModel.fromJson(result.data);
    } on DioException catch (e) {
      throw Exception((e));
    }
  }
}
