import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:weather_app/common/presentation/widgets/weather_icon.dart';
import 'package:weather_app/features/current_weather/presentation/bloc/current_weather_cubit.dart';
import 'package:weather_app/features/forecast/presentation/bloc/forecast_cubit.dart';
import 'package:weather_app/features/forecast/presentation/bloc/forecast_state.dart';
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
          appBar: AppBar(
            title: Text(geoState.city),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              //TODO: implement refresh
              context.read<GeoBloc>().add(CheckConnection());
              context.read<GeoBloc>().add(GetGeoData());
              context.read<CurrentWeatherCubit>().fetchWeather(
                    geoState.locationData?.latitude,
                    geoState.locationData?.longitude,
                  );
              context.read<ForecastCubit>().fetchForecast(
                    geoState.locationData?.latitude,
                    geoState.locationData?.longitude,
                  );
            },
            child: BlocBuilder<ForecastCubit, ForecastState>(
              builder: (context, forecastState) {
                return forecastState.forecasts == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.separated(
                        itemCount: forecastState.forecasts!.length,
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  WeatherIcon.small(
                                    weatherCondition: forecastState
                                        .forecasts![index].weather.condition,
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Text(
                                    Jiffy.parseFromMillisecondsSinceEpoch(
                                      forecastState.forecasts![index].date *
                                          1000,
                                    ).j,
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Text(
                                    forecastState
                                        .forecasts![index].weather.description,
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Text(
                                    '${forecastState.forecasts![index].weather.temp.toInt().toString()} °C',
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      );
              },
            ),
          ),
        );
      },
    );
  }
}
