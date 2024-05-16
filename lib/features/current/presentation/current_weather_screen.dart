import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/common/presentation/widgets/weather_icon.dart';
import 'package:weather_app/features/current/presentation/bloc/current_weather_cubit.dart';
import 'package:weather_app/features/current/presentation/bloc/current_weather_state.dart';
import 'package:weather_app/features/forecast/presentation/bloc/forecast_cubit.dart';
import 'package:weather_app/features/geo/bloc/geo_bloc.dart';
import 'package:weather_app/features/geo/bloc/geo_events.dart';
import 'package:weather_app/features/geo/bloc/geo_state.dart';

class CurrentWeatherScreen extends StatelessWidget {
  const CurrentWeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeoBloc, GeoState>(
      builder: (context, geoState) {
        return Scaffold(
          backgroundColor: const Color(0xfff6edff),
          appBar: AppBar(
            title: const Text('Today'),
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
            child: BlocBuilder<CurrentWeatherCubit, CurrentWeatherState>(
              builder: (context, weatherState) {
                return ListView(
                  children: [
                    const SizedBox(height: 32),
                    Center(
                      child: weatherState.weather?.condition == null
                          ? const SizedBox(
                              width: 60,
                              height: 60,
                            )
                          : WeatherIcon(
                              weatherCondition:
                                  weatherState.weather!.condition),
                    ),
                    const SizedBox(height: 32),
                    Center(
                      child: Text(
                        geoState.locationInfo,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: weatherState.condition != null
                                  ? '${(weatherState.weather!.description)} '
                                  : '---- ',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: weatherState.temperature,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Humidity: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: weatherState.humidity,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Pressure: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: weatherState.pressure,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Wind speed: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: weatherState.windSpeed,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
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
