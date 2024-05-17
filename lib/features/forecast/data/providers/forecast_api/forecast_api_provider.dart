import 'package:dio/dio.dart';
import 'package:weather_app/common/data/dio_client.dart';
import 'package:weather_app/common/domain/models/weather_params.dart';
import 'package:weather_app/features/forecast/data/dtos/forecast_dto.dart';
import 'package:weather_app/features/forecast/data/providers/forecast_provider.dart';

class ForecastApiProvider implements ForecastProvider {
  final dioClient = DioClient('data');

  @override
  Future<ForecastDto> fetchForecast(WeatherParams params) async {
    try {
      final result = await dioClient.get(
        '/2.5/forecast',
        queryParameters: {
          'lat': params.latitude,
          'lon': params.longitude,
          'units': params.unit.name,
        },
      );
      if (result.data == null) {
        throw Exception('Unknown Error ${result.statusCode}');
      }
      return ForecastDto.fromJson(result.data);
    } on DioException catch (e) {
      throw Exception((e));
    }
  }
}
