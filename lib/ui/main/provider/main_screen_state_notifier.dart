import 'package:flutter_training/common/provider/date_time.dart';
import 'package:flutter_training/model/forecast.dart';
import 'package:flutter_training/repository/provider/yumemi_weather.dart';
import 'package:flutter_training/ui/main/model/main_screen_state.dart';
import 'package:flutter_training/yumemi_weather_error.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

part 'main_screen_state_notifier.g.dart';

@riverpod
class MainScreenStateNotifier extends _$MainScreenStateNotifier {
  @override
  MainScreenState build() {
    return MainScreenState.init;
  }

  Future<void> fetchWeather() async {
    final Forecast newForecast;
    try {
      newForecast = await ref.read(
        syncFetchWeatherProvider(
          area: 'tokyo',
          dateTime: ref.read(nowDateTimeProvider),
        ).future,
      );
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
