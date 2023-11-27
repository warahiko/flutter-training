import 'dart:convert';

import 'package:flutter_training/weather.dart';

class Forecast {
  const Forecast({
    required this.weather,
    required this.maxTemperature,
    required this.minTemperature,
  });

  factory Forecast.from(String jsonString) {
    final decoded = jsonDecode(jsonString) as Map<String, dynamic>;

    return Forecast(
      weather: Weather.from(decoded['weather_condition'] as String),
      minTemperature: decoded['min_temperature'] as int,
      maxTemperature: decoded['max_temperature'] as int,
    );
  }

  final Weather weather;
  final int maxTemperature;
  final int minTemperature;
}
