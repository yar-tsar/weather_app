import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:location/location.dart';
import 'package:weather_app/common/di/locator.dart';
import 'package:weather_app/common/presentation/main_screen.dart';
import 'package:weather_app/features/current_weather/di/injection.dart';
import 'package:weather_app/features/forecast/di/injection.dart';
import 'package:weather_app/features/geo/di/injection.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  locator.registerSingleton<CurrentWeatherInjection>(
    CurrentWeatherInjection(
      serviceLocator: locator,
    ),
  );

  locator.registerSingleton<ForecastInjection>(
    ForecastInjection(
      serviceLocator: locator,
    ),
  );

  locator.registerSingleton<GeoInjection>(
    GeoInjection(
      serviceLocator: locator,
    ),
  );

  locator.registerLazySingleton<Location>(() => Location());
  locator.get<CurrentWeatherInjection>().setup(locator);
  locator.get<ForecastInjection>().setup(locator);
  locator.get<GeoInjection>().setup(locator);

  runApp(const MainScreen());
}
