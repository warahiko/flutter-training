import 'dart:convert';

import 'package:flutter_training/model/weather.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'forecast.freezed.dart';
part 'forecast.g.dart';

@freezed
class Forecast with _$Forecast {
  const factory Forecast({
    @JsonKey(name: 'weather_condition') required Weather weather,
    required int maxTemperature,
    required int minTemperature,
  }) = _Forecast;

  factory Forecast.fromJson(Map<String, dynamic> json) =>
      _$ForecastFromJson(json);

  factory Forecast.fromJsonString(String json) {
    final decoded = jsonDecode(json) as Map<String, dynamic>?;
    if (decoded == null) {
      throw Exception('Invalid format: $json.');
    }

    return Forecast.fromJson(decoded);
  }
}
