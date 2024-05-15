import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:weather_app/features/geo/domain/location_model.dart';
import 'package:weather_app/features/geo/bloc/geo_events.dart';
import 'package:weather_app/features/geo/bloc/geo_state.dart';

class GeoBloc extends Bloc<GeoEvent, GeoState> {
  GeoBloc() : super(GeoState.init()) {
    on<CheckConnection>((event, emit) => _checkConnection(event, emit));
    on<GetGeoData>((event, emit) => _getGeoData(event, emit));
  }

  Future<void> _checkConnection(
      CheckConnection event, Emitter<GeoState> emit) async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    emit(state.copyWith(isGeoDataActive: true));
  }

  Future<void> _getGeoData(GeoEvent event, Emitter<GeoState> emit) async {
    Location location = Location()..changeSettings();
    LocationData locationData;
    locationData = await location.getLocation();
    Dio dio = Dio();
    Response response = await dio.get(
      'https://api.openweathermap.org/geo/1.0/reverse?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=c94a899b724d06b8838be780265ffae0',
    );
    final result =
        (response.data as List).map((e) => LocationModel.fromJson(e)).toList();
    emit(
      state.copyWith(
        location: result.first,
      ),
    );
  }
}
