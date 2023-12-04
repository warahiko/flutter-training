import 'package:flutter/foundation.dart';
import 'package:flutter_training/model/fetch_weather_request.dart';
import 'package:flutter_training/model/forecast.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class YumemiWeatherRepository {
  YumemiWeatherRepository({
    required YumemiWeather yumemiWeather,
  }) : _yumemiWeather = yumemiWeather;

  final YumemiWeather _yumemiWeather;

  Future<Forecast> syncFetchWeather({
    required String area,
    required DateTime dateTime,
  }) async {
    final requestString = FetchWeatherRequest(
      area: area,
      date: dateTime,
    ).toJsonString();

    final responseString = await compute(
      _yumemiWeather.syncFetchWeather,
      requestString,
    );

    return Forecast.fromJsonString(responseString);
  }
}
