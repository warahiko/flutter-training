import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/common/provider/date_time.dart';
import 'package:flutter_training/model/forecast.dart';
import 'package:flutter_training/model/weather.dart';
import 'package:flutter_training/repository/provider/yumemi_weather.dart';
import 'package:flutter_training/ui/main/provider/main_screen_state_notifier.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

import '../../../util/provider_container.dart';
import 'main_screen_state_notifier_test.mocks.dart';

@GenerateMocks([YumemiWeather])
void main() {
  group('fetchForecast()', () {
    test('成功した場合、天気予報結果が渡される', () async {
      // Setup
      final dummyDateTime = DateTime.utc(2023, 11, 30);
      const dummyResponse = '''
      {
        "weather_condition": "sunny",
        "max_temperature": 25,
        "min_temperature": 14
      }''';
      const expected = Forecast(
        weather: Weather.sunny,
        maxTemperature: 25,
        minTemperature: 14,
      );

      final mockYumemiWeather = MockYumemiWeather();
      when(mockYumemiWeather.syncFetchWeather(any)).thenReturn(dummyResponse);

      // https://riverpod.dev/docs/essentials/testing#mocking-providers
      final container = createContainer(
        overrides: [
          nowDateTimeProvider.overrideWithValue(dummyDateTime),
          yumemiWeatherProvider.overrideWithValue(mockYumemiWeather),
        ],
      );
      // https://riverpod.dev/docs/essentials/testing#unit-tests
      // provider が dispose されないように listen
      final subscription =
          container.listen(mainScreenStateNotifierProvider, (_, __) {});

      // Exercise
      await container
          .read(mainScreenStateNotifierProvider.notifier)
          .fetchWeather();

      // Verify
      expect(
        subscription.read().forecast,
        isA<AsyncData<Forecast?>>()
            .having((it) => it.value, 'forecast', expected),
      );
    });
    test('失敗した場合、エラーメッセージが渡される', () async {
      // Setup
      final dummyDateTime = DateTime.utc(2023, 11, 30);
      const dummyError = YumemiWeatherError.unknown;
      const expected = YumemiWeatherError.unknown;

      final mockYumemiWeather = MockYumemiWeather();
      when(mockYumemiWeather.syncFetchWeather(any)).thenThrow(dummyError);

      // https://riverpod.dev/docs/essentials/testing#mocking-providers
      final container = createContainer(
        overrides: [
          nowDateTimeProvider.overrideWithValue(dummyDateTime),
          yumemiWeatherProvider.overrideWithValue(mockYumemiWeather),
        ],
      );
      final subscription =
          container.listen(mainScreenStateNotifierProvider, (_, __) {});

      // Exercise
      await container
          .read(mainScreenStateNotifierProvider.notifier)
          .fetchWeather();

      // Verify
      expect(
        subscription.read().forecast,
        isA<AsyncError<Forecast?>>()
            .having((it) => it.error, 'error', expected),
      );
    });
  });
}
