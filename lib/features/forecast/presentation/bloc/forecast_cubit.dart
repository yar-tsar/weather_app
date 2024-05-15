import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/forecast/data/forecast_dto.dart';
import 'package:weather_app/features/forecast/presentation/bloc/forecast_state.dart';

class ForecastCubit extends Cubit<ForecastState> {
  ForecastCubit() : super(ForecastState());

  Future<void> fetchForecast(double? latitude, double? longitude) async {
    if (latitude == null || longitude == null) {
      print('ABORT');
      return;
      //TODO: handle error
    }
    Dio dio = Dio();
    Response response = await dio.get(
      'http://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&units=metric&appid=c94a899b724d06b8838be780265ffae0',
    );
    final forecast = ForecastDto.fromJson(response.data);
    emit(state.copyWith(forecasts: forecast.forecasts));
  }
}
