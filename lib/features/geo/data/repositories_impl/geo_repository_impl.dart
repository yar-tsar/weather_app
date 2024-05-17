import 'package:weather_app/features/geo/data/providers/geo_api/geo_api_provider.dart';
import 'package:weather_app/features/geo/domain/models/location_model.dart';
import 'package:weather_app/features/geo/domain/models/location_params.dart';
import 'package:weather_app/features/geo/domain/repositories/geo_repository.dart';

class GeoRepositoryImpl implements GeoRepository {
  GeoRepositoryImpl({required GeoApiProvider apiProvider})
      : _apiProvider = apiProvider;
  final GeoApiProvider _apiProvider;
  @override
  Future<LocationModel?> getGeoData(LocationParams params) async {
    return _apiProvider.getGeoData(params);
  }
}
