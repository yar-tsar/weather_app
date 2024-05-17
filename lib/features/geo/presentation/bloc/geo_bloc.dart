import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:weather_app/features/geo/domain/models/location_params.dart';
import 'package:weather_app/features/geo/domain/use_cases/get_geodata_use_case.dart';
import 'package:weather_app/features/geo/presentation/bloc/geo_events.dart';
import 'package:weather_app/features/geo/presentation/bloc/geo_state.dart';

class GeoBloc extends Bloc<GeoEvent, GeoState> {
  GeoBloc({
    required GetGeoDataUseCase getGeoDataUseCase,
    required Location location,
  })  : _getGeoDataUseCase = getGeoDataUseCase,
        _location = location,
        super(GeoState.init()) {
    on<CheckConnection>((event, emit) => _checkConnection(event, emit));
    on<GetGeoData>((event, emit) => _getGeoData(event, emit));
  }

  final GetGeoDataUseCase _getGeoDataUseCase;
  final Location _location;

  Future<void> _checkConnection(
      CheckConnection event, Emitter<GeoState> emit) async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    emit(state.copyWith(isGeoDataActive: true));
  }

  Future<void> _getGeoData(GeoEvent event, Emitter<GeoState> emit) async {
    LocationData locationData;
    locationData = await _location.getLocation();

    final result = await _getGeoDataUseCase.call(
      LocationParams(
        latitude: locationData.latitude!,
        longitude: locationData.longitude!,
      ),
    );
    emit(
      state.copyWith(
        location: result,
        locationData: locationData,
      ),
    );
  }
}
