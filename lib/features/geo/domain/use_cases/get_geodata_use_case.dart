import 'package:weather_app/common/domain/use_cases/use_case.dart';
import 'package:weather_app/features/geo/data/repositories_impl/geo_repository_impl.dart';
import 'package:weather_app/features/geo/domain/models/location_model.dart';
import 'package:weather_app/features/geo/domain/models/location_params.dart';

class GetGeoDataUseCase extends UseCase<LocationParams, LocationModel?> {
  GetGeoDataUseCase({required GeoRepositoryImpl repositoryImpl})
      : _repositoryImpl = repositoryImpl;

  final GeoRepositoryImpl _repositoryImpl;

  @override
  Future<LocationModel?> call(LocationParams params) {
    return _repositoryImpl.getGeoData(params).then((value) => value);
  }
}
