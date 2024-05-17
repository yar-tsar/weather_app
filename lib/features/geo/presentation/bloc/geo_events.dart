import 'package:weather_app/features/geo/presentation/bloc/geo_state.dart';

abstract class GeoEvent {}

class CheckGps extends GeoEvent {}

class CheckNetwork extends GeoEvent {}

class SetNetwork extends GeoEvent {
  SetNetwork({
    required this.isNetworkActive,
    this.status,
  });
  final GeoStateStatus? status;
  final bool isNetworkActive;
}

class GetGeoData extends GeoEvent {}

class GeoInitial extends GeoEvent {}
