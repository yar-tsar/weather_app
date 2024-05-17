import 'package:location/location.dart';
import 'package:weather_app/features/geo/domain/models/location_model.dart';

class GeoState {
  GeoState({
    required this.isGeoDataActive,
    required this.isNetworkActive,
    this.location,
    this.locationData,
  });

  GeoState.init() : this(isGeoDataActive: false, isNetworkActive: false);

  bool isGeoDataActive;
  bool isNetworkActive;

  LocationData? locationData;
  LocationModel? location;

  String get locationInfo =>
      location != null ? '${location?.name}, ${location?.country}' : 'No Data';

  String get city => location != null ? '${location?.name}' : 'No Data';

  GeoState copyWith({
    bool? isGeoDataActive,
    bool? isNetworkActive,
    LocationModel? location,
    LocationData? locationData,
  }) {
    return GeoState(
      isGeoDataActive: isGeoDataActive ?? this.isGeoDataActive,
      isNetworkActive: isNetworkActive ?? this.isNetworkActive,
      location: location ?? this.location,
      locationData: locationData ?? this.locationData,
    );
  }
}
