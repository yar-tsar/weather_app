import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:weather_app/common/di/locator.dart';
import 'package:weather_app/common/presentation/widgets/paged_navigation.dart';
import 'package:weather_app/features/current_weather/domain/use_cases/fetch_weather_use_case.dart';
import 'package:weather_app/features/current_weather/presentation/bloc/current_weather_cubit.dart';
import 'package:weather_app/features/forecast/domain/use_cases/fetch_forecast_use_case.dart';
import 'package:weather_app/features/forecast/presentation/bloc/forecast_cubit.dart';
import 'package:weather_app/features/geo/domain/use_cases/get_geodata_use_case.dart';
import 'package:weather_app/features/geo/presentation/bloc/geo_bloc.dart';

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
            create: (context) => GeoBloc(
              getGeoDataUseCase: locator.get<GetGeoDataUseCase>(),
              location: locator.get<Location>(),
            ),
          ),
          BlocProvider<CurrentWeatherCubit>(
            create: (context) => CurrentWeatherCubit(
              fetchWeatherUseCase: locator.get<FetchWeatherUseCase>(),
            ),
          ),
          BlocProvider<ForecastCubit>(
            create: (context) => ForecastCubit(
              fetchForecastUseCase: locator.get<FetchForecastUseCase>(),
            ),
          ),
        ],
        child: const PagedNavigation(),
      ),
    );
  }
}
