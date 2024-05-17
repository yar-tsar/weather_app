import 'package:dio/dio.dart';
import 'package:weather_app/common/data/dio_client.dart';
import 'package:weather_app/features/geo/data/providers/geo_provider.dart';
import 'package:weather_app/features/geo/domain/models/location_model.dart';
import 'package:weather_app/features/geo/domain/models/location_params.dart';

class GeoApiProvider implements GeoProvider {
  final dioClient = DioClient('geo');

  @override
  Future<LocationModel?> getGeoData(LocationParams params) async {
    try {
      final result = await dioClient.get(
        '/1.0/reverse',
        queryParameters: {
          'lat': params.latitude,
          'lon': params.longitude,
        },
      );
      if (result.data == null) {
        throw Exception('Unknown Error ${result.statusCode}');
      } else if (result.data is List) {
        if ((result.data as List).isNotEmpty) {
          return LocationModel.fromJson(result.data[0]);
        } else {
          throw Exception('Cannot find location');
        }
      }
      return null;
    } on DioException catch (e) {
      throw Exception((e));
    }
  }
}
