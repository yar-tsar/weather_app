import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/common/domain/models/weather_model.dart';
import 'package:weather_app/features/current/presentation/bloc/current_weather_state.dart';

class CurrentWeatherCubit extends Cubit<CurrentWeatherState> {
  CurrentWeatherCubit() : super(CurrentWeatherState());

  Future<void> fetchWeather(double? latitude, double? longitude) async {
    if (latitude == null || longitude == null) {
      print('ABORT');
      return;
      //TODO: handle error
    }
    Dio dio = Dio();
    Response response = await dio.get(
      'http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&units=metric&appid=c94a899b724d06b8838be780265ffae0',
    );
    final weather = WeatherModel.fromJson(response.data);
    emit(state.copyWith(weather: weather));
  }
}
