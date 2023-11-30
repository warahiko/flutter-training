import 'package:flutter_training/common/provider/date_time.dart';
import 'package:flutter_training/model/fetch_weather_request.dart';
import 'package:flutter_training/model/forecast.dart';
import 'package:flutter_training/repository/provider/yumemi_weather.dart';
import 'package:flutter_training/ui/main/model/main_screen_state.dart';
import 'package:flutter_training/yumemi_weather_error.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

part 'main_screen_state_notifier.g.dart';

@riverpod
class MainScreenStateNotifier extends _$MainScreenStateNotifier {
  YumemiWeather get _yumemiWeather => ref.read(yumemiWeatherProvider);

  DateTime get _nowDateTime => ref.read(nowDateTimeProvider);

  @override
  MainScreenState build() {
    return MainScreenState.init;
  }

  void fetchWeather() {
    final requestString = FetchWeatherRequest(
      area: 'tokyo',
      date: _nowDateTime,
    ).toJsonString();

    final Forecast newForecast;
    try {
      final responseString = _yumemiWeather.fetchWeather(requestString);
      newForecast = Forecast.fromJsonString(responseString);
    } on YumemiWeatherError catch (e) {
      state = state.copyWith(errorMessage: e.toMessage());
      return;
    } on Exception catch (_) {
      const message = '不明なエラーです。';
      state = state.copyWith(errorMessage: message);
      return;
    }
    state = state.copyWith(forecast: newForecast);
  }

  void errorMessageShown() {
    state = state.copyWith(errorMessage: null);
  }
}
