import 'package:equatable/equatable.dart';
import 'package:location/location.dart';
import 'package:weather_app/features/geo/domain/models/location_model.dart';

enum GeoStateStatus {
  init,
  loading,
  success,
  noData,
  noPermissions,
  noInternet
}

class GeoState extends Equatable {
  const GeoState({
    required this.isGeoDataAvailable,
    required this.isNetworkAvailable,
    required this.status,
    this.location,
    this.locationData,
  });

  const GeoState.init()
      : this(
          status: GeoStateStatus.init,
          isGeoDataAvailable: false,
          isNetworkAvailable: false,
        );

  final GeoStateStatus status;
  final bool isGeoDataAvailable;
  final bool isNetworkAvailable;

  final LocationData? locationData;
  final LocationModel? location;

  String get locationInfo =>
      location != null ? '${location?.name}, ${location?.country}' : 'No Data';

  String get city => location != null ? '${location?.name}' : 'No Data';

  bool get showStatusBar =>
      status == GeoStateStatus.loading ||
      status == GeoStateStatus.noData ||
      status == GeoStateStatus.noPermissions ||
      status == GeoStateStatus.noInternet;

  String get statusText {
    switch (status) {
      case GeoStateStatus.loading:
        return 'Loading ...';
      case GeoStateStatus.noData:
        return 'No location data';
      case GeoStateStatus.noPermissions:
        return 'No permissions to get data';
      case GeoStateStatus.noInternet:
        return 'No internet connection';
      default:
        return '';
    }
  }

  GeoState copyWith({
    GeoStateStatus? status,
    bool? isGeoDataActive,
    bool? isNetworkActive,
    LocationModel? location,
    LocationData? locationData,
  }) {
    return GeoState(
      status: status ?? this.status,
      isGeoDataAvailable: isGeoDataActive ?? isGeoDataAvailable,
      isNetworkAvailable: isNetworkActive ?? isNetworkAvailable,
      location: location ?? this.location,
      locationData: locationData ?? this.locationData,
    );
  }

  @override
  List<Object?> get props => [
        status,
        isGeoDataAvailable,
        isNetworkAvailable,
        location,
        locationData,
      ];
}
