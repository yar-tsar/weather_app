import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/common/domain/models/weather_model.dart';

class WeatherIcon extends StatelessWidget {
  const WeatherIcon({
    required this.weatherCondition,
    super.key,
  });

  final WeatherCondition weatherCondition;

  @override
  Widget build(BuildContext context) {
    final icon = switch (weatherCondition) {
      WeatherCondition.clearSky => 'clear_sky_d.svg',
      WeatherCondition.fewClouds => 'few_clouds_d.svg',
      WeatherCondition.scatteredClouds => 'scattered_clouds_d.svg',
      WeatherCondition.brokenClouds => 'broken_clouds_d.svg',
      WeatherCondition.showerRain => 'shower_rain_d.svg',
      WeatherCondition.rain => 'rain_d.svg',
      WeatherCondition.thunderstorm => 'thunderstorm_d.svg',
      WeatherCondition.snow => 'snow_d.svg',
      WeatherCondition.mist => 'mist_d.svg',
    };

    return SizedBox(
      width: 220,
      height: 220,
      child: SvgPicture.asset(
        'assets/weather_icons/day/$icon',
      ),
    );
  }
}
