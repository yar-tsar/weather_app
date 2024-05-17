import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
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
        super(const GeoState.init()) {
    on<CheckGps>((event, emit) => _checkGpsAvailable(event, emit));
    on<CheckNetwork>((event, emit) => _checkNetwork(event, emit));
    on<SetNetwork>((event, emit) => _setNetwork(event, emit));
    on<GetGeoData>((event, emit) => _getGeoData(event, emit));
  }

  final GetGeoDataUseCase _getGeoDataUseCase;
  final Location _location;
  final Connectivity connectivity = Connectivity();
  final InternetConnectionChecker internetConnectionChecker =
      InternetConnectionChecker.createInstance();

  Future<void> _checkGpsAvailable(
      CheckGps event, Emitter<GeoState> emit) async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        emit(state.copyWith(status: GeoStateStatus.noData));
        return;
      }
    }

    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.grantedLimited ||
          permissionGranted != PermissionStatus.grantedLimited) {
        emit(state.copyWith(status: GeoStateStatus.noPermissions));
        return;
      }
    }

    emit(
      state.copyWith(isGeoDataActive: true),
    );
  }

  Future<void> _checkNetwork(CheckNetwork event, Emitter<GeoState> emit) async {
    connectivity.onConnectivityChanged.listen((event) {
      if (event.contains(ConnectivityResult.mobile) ||
          event.contains(ConnectivityResult.wifi)) {
        add(SetNetwork(
          isNetworkActive: true,
          status: GeoStateStatus.success,
        ));
      } else {
        add(SetNetwork(
          isNetworkActive: false,
          status: GeoStateStatus.noInternet,
        ));
      }
    });
    if (state.location == null) {
      add(GetGeoData());
    }
  }

  Future<void> _setNetwork(SetNetwork event, Emitter<GeoState> emit) async {
    emit(state.copyWith(
      isNetworkActive: event.isNetworkActive,
      status: event.status,
    ));
  }

  Future<void> _getGeoData(GeoEvent event, Emitter<GeoState> emit) async {
    if (!(state.status == GeoStateStatus.noPermissions ||
        !state.isNetworkAvailable ||
        !state.isGeoDataAvailable)) {
      emit(state.copyWith(status: GeoStateStatus.loading));
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
          status: GeoStateStatus.success,
        ),
      );
    }
  }
}
