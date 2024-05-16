import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/common/presentation/widgets/paged_navigation.dart';
import 'package:weather_app/features/current/presentation/bloc/current_weather_cubit.dart';
import 'package:weather_app/features/forecast/presentation/bloc/forecast_cubit.dart';
import 'package:weather_app/features/geo/bloc/geo_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<GeoBloc>(
            create: (context) => GeoBloc(),
          ),
          BlocProvider<CurrentWeatherCubit>(
            create: (context) => CurrentWeatherCubit(),
          ),
          BlocProvider<ForecastCubit>(
            create: (context) => ForecastCubit(),
          ),
        ],
        child: const PagedNavigation(),
      ),
    );
  }
}
