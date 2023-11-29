import 'dart:convert';

import 'package:flutter_training/model/forecast.dart';
import 'package:flutter_training/model/weather.dart';
import 'package:test/test.dart';

import '../util/string_ext.dart';

void main() {
  test('Serialize', () {
    // Setup
    const dummy = Forecast(
      weather: Weather.sunny,
      maxTemperature: 40,
      minTemperature: -40,
    );
    final expected = '''
    {
      "weather_condition":"sunny",
      "max_temperature":40,
      "min_temperature":-40
    }'''
        .trimSpace();

    // Exercise
    final result = jsonEncode(dummy.toJson());

    // Verify
    expect(result, expected);
  });

  test('Deserialize', () {
    // Setup
    final dummy = '''
    {
      "weather_condition":"cloudy",
      "max_temperature":25,
      "min_temperature":7,
      "date":"2020-04-01T12:00:00+09:00"
    }'''
        .trimSpace();
    const expected = Forecast(
      weather: Weather.cloudy,
      maxTemperature: 25,
      minTemperature: 7,
    );

    // Exercise
    final result = Forecast.fromJsonString(dummy);

    // Verify
    expect(result, expected);
  });
}
