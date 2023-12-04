import 'package:flutter_training/common/provider/date_time.dart';
import 'package:flutter_training/model/forecast.dart';
import 'package:flutter_training/repository/provider/yumemi_weather.dart';
import 'package:flutter_training/ui/main/model/main_screen_state.dart';
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
    final previous = state.forecast;

    state = state.copyWith(
      forecast: const AsyncLoading<Forecast?>().copyWithPrevious(
        previous,
        isRefresh: false,
      ),
    );

    final Forecast newForecast;
    try {
      newForecast = await ref.read(
        syncFetchWeatherProvider(
          area: 'tokyo',
          dateTime: ref.read(nowDateTimeProvider),
        ).future,
      );
    } on YumemiWeatherError catch (error, stackTrace) {
      state = state.copyWith(
        forecast: AsyncError<Forecast?>(error, stackTrace).copyWithPrevious(
          previous,
          isRefresh: false,
        ),
      );
      return;
    } on Exception catch (error, stackTrace) {
      state = state.copyWith(
        forecast: AsyncError<Forecast?>(error, stackTrace).copyWithPrevious(
          previous,
          isRefresh: false,
        ),
      );
      return;
    }

    state = state.copyWith(
      forecast: AsyncData<Forecast?>(newForecast).copyWithPrevious(
        previous,
        isRefresh: false,
      ),
    );
  }
}
