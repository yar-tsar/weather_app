import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:weather_app/common/presentation/widgets/status_bar.dart';
import 'package:weather_app/common/presentation/widgets/weather_icon.dart';
import 'package:weather_app/features/current_weather/presentation/bloc/current_weather_cubit.dart';
import 'package:weather_app/features/current_weather/presentation/bloc/current_weather_state.dart';
import 'package:weather_app/features/geo/presentation/bloc/geo_bloc.dart';
import 'package:weather_app/features/geo/presentation/bloc/geo_events.dart';
import 'package:weather_app/features/geo/presentation/bloc/geo_state.dart';

class CurrentWeatherScreen extends StatelessWidget {
  const CurrentWeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeoBloc, GeoState>(
      builder: (context, geoState) {
        return Scaffold(
          backgroundColor: const Color(0xFFF6EDFF),
          appBar: AppBar(
            backgroundColor: const Color(0xFFF6EDFF),
            title: const Text('Today'),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              context.read<GeoBloc>().add(CheckGps());
              context.read<GeoBloc>().add(CheckNetwork());
              context.read<GeoBloc>().add(GetGeoData());
            },
            child: BlocBuilder<CurrentWeatherCubit, CurrentWeatherState>(
              builder: (context, weatherState) {
                return Stack(
                  children: [
                    ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      children: [
                        const SizedBox(height: 32),
                        Center(
                          child: weatherState.weather?.condition == null
                              ? const SizedBox(
                                  height: 220,
                                )
                              : WeatherIcon(
                                  weatherCondition:
                                      weatherState.weather!.condition,
                                ),
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: Text(
                            weatherState.weather?.description ?? '',
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Center(
                          child: Text(
                            geoState.locationInfo,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: Text(
                            weatherState.temperature,
                            style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        _WeatherParameter(
                          icon: Icons.air,
                          data: weatherState.windSpeed,
                          message: 'Wind speed',
                        ),
                        const SizedBox(height: 12),
                        _WeatherParameter(
                          icon: Icons.water_drop,
                          data: weatherState.humidity,
                          message: 'Humidity',
                        ),
                        const SizedBox(height: 12),
                        _WeatherParameter(
                          icon: Icons.waves,
                          data: weatherState.pressure,
                          message: 'Pressure',
                        ),
                        const SizedBox(height: 32),
                        Center(
                          child: Text(
                            'Last update ${weatherState.timestamp}',
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: weatherState.weather == null
                              ? null
                              : () {
                                  Share.share(
                                    weatherState.shareMessage,
                                  );
                                },
                          child: const Center(
                            child: Text(
                              'Share my weather',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                    Positioned(
                      top: 0,
                      child: StatusBar(
                        visibility: weatherState.showStatusBar &&
                            !geoState.showStatusBar,
                        message: weatherState.statusMessage,
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

class _WeatherParameter extends StatelessWidget {
  const _WeatherParameter({
    required this.icon,
    required this.data,
    required this.message,
  });

  final IconData icon;
  final String data;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      height: 65,
      decoration: const BoxDecoration(
        color: Color(0xFFD0BCFF),
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      child: Row(
        children: [
          const SizedBox(width: 8),
          Container(
              width: 35,
              height: 35,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: Icon(icon)),
          const SizedBox(width: 8),
          Text(
            message,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            data,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
