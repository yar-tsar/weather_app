import 'package:weather_app/features/geo/domain/models/location_model.dart';
import 'package:weather_app/features/geo/domain/models/location_params.dart';

abstract class GeoProvider {
  Future<LocationModel?> getGeoData(LocationParams params);
}
