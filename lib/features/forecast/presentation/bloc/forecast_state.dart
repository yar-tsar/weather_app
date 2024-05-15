import 'package:weather_app/features/forecast/domain/forecast_model.dart';

class ForecastState {
  ForecastState({
    this.forecasts,
  });

  List<ForecastModel>? forecasts;

  ForecastState copyWith({
    List<ForecastModel>? forecasts,
  }) {
    return ForecastState(
      forecasts: forecasts ?? this.forecasts,
    );
  }
}
