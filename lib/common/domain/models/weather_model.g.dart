// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) => WeatherModel(
      condition: $enumDecode(_$WeatherConditionEnumMap, json['condition']),
      temp: (json['temp'] as num).toDouble(),
      humidity: (json['humidity'] as num).toInt(),
      pressure: (json['pressure'] as num).toInt(),
      windSpeed: (json['windSpeed'] as num).toDouble(),
    );

Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) =>
    <String, dynamic>{
      'condition': _$WeatherConditionEnumMap[instance.condition]!,
      'temp': instance.temp,
      'humidity': instance.humidity,
      'pressure': instance.pressure,
      'windSpeed': instance.windSpeed,
    };

const _$WeatherConditionEnumMap = {
  WeatherCondition.clearSky: 'clearSky',
  WeatherCondition.fewClouds: 'fewClouds',
  WeatherCondition.scatteredClouds: 'scatteredClouds',
  WeatherCondition.brokenClouds: 'brokenClouds',
  WeatherCondition.showerRain: 'showerRain',
  WeatherCondition.rain: 'rain',
  WeatherCondition.thunderstorm: 'thunderstorm',
  WeatherCondition.snow: 'snow',
  WeatherCondition.mist: 'mist',
};
