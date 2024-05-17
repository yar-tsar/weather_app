import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:weather_app/common/presentation/widgets/status_bar.dart';
import 'package:weather_app/common/presentation/widgets/weather_icon.dart';
import 'package:weather_app/features/forecast/presentation/bloc/forecast_cubit.dart';
import 'package:weather_app/features/forecast/presentation/bloc/forecast_state.dart';
import 'package:weather_app/features/forecast/utils/is_same_date_checker.dart';
import 'package:weather_app/features/geo/presentation/bloc/geo_bloc.dart';
import 'package:weather_app/features/geo/presentation/bloc/geo_events.dart';
import 'package:weather_app/features/geo/presentation/bloc/geo_state.dart';

class ForecastScreen extends StatelessWidget {
  const ForecastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeoBloc, GeoState>(
      builder: (context, geoState) {
        return Scaffold(
          backgroundColor: const Color(0xFFF6EDFF),
          appBar: AppBar(
            backgroundColor: const Color(0xFFF6EDFF),
            title: Text(geoState.city),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              //TODO: implement refresh
              context.read<GeoBloc>().add(CheckGps());
              context.read<GeoBloc>().add(GetGeoData());
              context.read<ForecastCubit>().fetchForecast(
                    geoState.locationData?.latitude,
                    geoState.locationData?.longitude,
                  );
            },
            child: BlocBuilder<ForecastCubit, ForecastState>(
              builder: (context, forecastState) {
                return Stack(
                  children: [
                    forecastState.forecasts == null
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: forecastState.forecasts!.length,
                            separatorBuilder: (context, index) {
                              bool isSameDate = isSameDateChecker(
                                current: forecastState.forecasts![index].date,
                                next: forecastState.forecasts![index + 1].date,
                              );

                              return !isSameDate
                                  ? _DaySeparator(
                                      date: forecastState
                                          .forecasts![index + 1].date,
                                    )
                                  : const SizedBox(height: 12);
                            },
                            itemBuilder: (context, index) {
                              bool isSameDate = true;
                              if (index == 0) {
                                isSameDate = isSameDateChecker(
                                  current: Jiffy.now().millisecondsSinceEpoch,
                                  next: forecastState.forecasts![index].date,
                                );
                              }
                              return Column(
                                children: [
                                  if (!isSameDate) ...[
                                    _DaySeparator(
                                      date:
                                          forecastState.forecasts![index].date,
                                    ),
                                  ],
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    height: 100,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFD0BCFF),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(25)),
                                    ),
                                    child: Row(
                                      children: [
                                        WeatherIcon.small(
                                          weatherCondition: forecastState
                                              .forecasts![index]
                                              .weather
                                              .condition,
                                        ),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Spacer(),
                                            Text(
                                              Jiffy
                                                  .parseFromMillisecondsSinceEpoch(
                                                forecastState.forecasts![index]
                                                        .date *
                                                    1000,
                                              ).Hm,
                                              style: const TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              forecastState.forecasts![index]
                                                  .weather.description,
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            const Spacer(),
                                          ],
                                        ),
                                        const Spacer(),
                                        Text(
                                          '${forecastState.forecasts![index].weather.temp.round().toString()}°C',
                                          style: const TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                    Positioned(
                      top: 0,
                      child: StatusBar(
                        visibility: forecastState.showStatusBar,
                        message: forecastState.statusMessage,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _DaySeparator extends StatelessWidget {
  const _DaySeparator({
    required this.date,
  });

  final int date;

  @override
  Widget build(BuildContext context) {
    final Jiffy convertedDate = Jiffy.parseFromMillisecondsSinceEpoch(
      date * 1000,
    );
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            vertical: 12,
          ),
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Color(0xFFD0BCFF),
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          child: Text(
            Jiffy.now().isSame(
              convertedDate,
              unit: Unit.day,
            )
                ? 'Today'
                : convertedDate.EEEE,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}
