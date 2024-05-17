import 'package:weather_app/common/di/locator.dart';
import 'package:weather_app/features/geo/data/providers/geo_api/geo_api_provider.dart';
import 'package:weather_app/features/geo/data/repositories_impl/geo_repository_impl.dart';
import 'package:weather_app/features/geo/domain/use_cases/get_geodata_use_case.dart';

class GeoInjection extends Injection {
  GeoInjection({
    required super.serviceLocator,
  });

  @override
  void setup(serviceLocator) {
    serviceLocator.registerSingleton<GeoApiProvider>(GeoApiProvider());
    serviceLocator.registerSingleton<GeoRepositoryImpl>(
      GeoRepositoryImpl(
        apiProvider: locator<GeoApiProvider>(),
      ),
    );
    serviceLocator.registerSingleton<GetGeoDataUseCase>(
      GetGeoDataUseCase(
        repositoryImpl: locator<GeoRepositoryImpl>(),
      ),
    );
  }
}
