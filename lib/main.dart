import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/current/presentation/bloc/current_weather_cubit.dart';
import 'package:weather_app/features/geo/bloc/geo_bloc.dart';
import 'package:weather_app/common/presentation/main_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

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
        ],
        child: const MainScreen(),
      ),
    );
  }
}
