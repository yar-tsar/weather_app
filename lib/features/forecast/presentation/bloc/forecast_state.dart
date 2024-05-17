import 'package:equatable/equatable.dart';
import 'package:weather_app/features/forecast/domain/models/forecast_model.dart';

enum ForecastStateStatus {
  init,
  loading,
  success,
}

class ForecastState extends Equatable {
  const ForecastState({
    required this.status,
    this.forecasts,
  });

  final ForecastStateStatus status;
  final List<ForecastModel>? forecasts;

  bool get showStatusBar => status == ForecastStateStatus.loading;

  String get statusMessage {
    switch (status) {
      case ForecastStateStatus.loading:
        return 'Loading ...';
      default:
        return '';
    }
  }

  ForecastState copyWith({
    ForecastStateStatus? status,
    List<ForecastModel>? forecasts,
  }) {
    return ForecastState(
      status: status ?? this.status,
      forecasts: forecasts ?? this.forecasts,
    );
  }

  @override
  List<Object?> get props => [
        status,
        forecasts,
      ];
}
