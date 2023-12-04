import 'package:flutter/foundation.dart';
import 'package:flutter_training/model/fetch_weather_request.dart';
import 'package:flutter_training/model/forecast.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

part 'yumemi_weather.g.dart';

@riverpod
YumemiWeather yumemiWeather(YumemiWeatherRef ref) => YumemiWeather();

@riverpod
Future<Forecast> syncFetchWeather(
  SyncFetchWeatherRef ref, {
  required String area,
  required DateTime dateTime,
}) async {
  final yumemiWeather = ref.watch(yumemiWeatherProvider);

  final requestString = FetchWeatherRequest(
    area: area,
    date: dateTime,
  ).toJsonString();

  final responseString = await compute(
    yumemiWeather.syncFetchWeather,
    requestString,
  );

  return Forecast.fromJsonString(responseString);
}
