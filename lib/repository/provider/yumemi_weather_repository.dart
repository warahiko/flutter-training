import 'package:flutter_training/repository/provider/yumemi_weather.dart';
import 'package:flutter_training/repository/yumemi_weather_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'yumemi_weather_repository.g.dart';

@riverpod
YumemiWeatherRepository yumemiWeatherRepository(
  YumemiWeatherRepositoryRef ref,
) {
  return YumemiWeatherRepository(
    yumemiWeather: ref.watch(yumemiWeatherProvider),
  );
}
