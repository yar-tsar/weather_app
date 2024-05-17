import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:weather_app/common/presentation/widgets/status_bar.dart';
import 'package:weather_app/features/current_weather/presentation/bloc/current_weather_cubit.dart';
import 'package:weather_app/features/forecast/presentation/bloc/forecast_cubit.dart';
import 'package:weather_app/features/forecast/presentation/forecast_screen.dart';
import 'package:weather_app/features/current_weather/presentation/current_weather_screen.dart';
import 'package:weather_app/features/geo/presentation/bloc/geo_bloc.dart';
import 'package:weather_app/features/geo/presentation/bloc/geo_events.dart';
import 'package:weather_app/features/geo/presentation/bloc/geo_state.dart';

class PagedNavigation extends StatefulWidget {
  const PagedNavigation({super.key});

  @override
  State<PagedNavigation> createState() => _PagedNavigationState();
}

class _PagedNavigationState extends State<PagedNavigation> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(
      initialPage: currentIndex,
    );
    context.read<GeoBloc>().add(CheckGps());
    context.read<GeoBloc>().add(CheckNetwork());
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
    });
  }

  void syncPage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void changePage(int index) {
    setState(() {
      _controller.jumpToPage(index);
      currentIndex = index;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GeoBloc, GeoState>(
      listener: (context, state) {
        if (state.isGeoDataAvailable &&
            state.isNetworkAvailable &&
            state.locationData == null) {
          context.read<GeoBloc>().add(GetGeoData());
        }
        if (state.locationData != null && state.isNetworkAvailable) {
          context.read<CurrentWeatherCubit>().fetchWeather(
                state.locationData?.latitude,
                state.locationData?.longitude,
              );
          context.read<ForecastCubit>().fetchForecast(
                state.locationData?.latitude,
                state.locationData?.longitude,
              );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF6EDFF),
          resizeToAvoidBottomInset: true,
          extendBodyBehindAppBar: true,
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: const Color(0xFFF6EDFF),
            currentIndex: currentIndex,
            onTap: changePage,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.thermostat),
                label: 'Today',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Forecast',
              ),
            ],
          ),
          body: SafeArea(
            child: Stack(
              children: [
                PageView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  onPageChanged: syncPage,
                  controller: _controller,
                  children: const [
                    CurrentWeatherScreen(),
                    ForecastScreen(),
                  ],
                ),
                Positioned(
                  top: 56,
                  child: StatusBar(
                    visibility: state.showStatusBar,
                    message: state.statusText,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
