import 'package:flutter_training/common/provider/date_time.dart';
import 'package:flutter_training/model/forecast.dart';
import 'package:flutter_training/model/weather.dart';
import 'package:flutter_training/repository/provider/yumemi_weather.dart';
import 'package:flutter_training/ui/main/provider/main_screen_state_notifier.dart';
import 'package:flutter_training/yumemi_weather_error.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

import '../../../util/provider_container.dart';
import 'main_screen_state_notifier_test.mocks.dart';

@GenerateMocks([YumemiWeather])
void main() {
  group('fetchForecast()', () {
    test('成功した場合、天気予報結果が渡される', () {
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
      when(mockYumemiWeather.fetchWeather(any)).thenReturn(dummyResponse);

      // https://riverpod.dev/docs/essentials/testing#mocking-providers
      final container = createContainer(
        overrides: [
          nowDateTimeProvider.overrideWithValue(dummyDateTime),
          yumemiWeatherProvider.overrideWithValue(mockYumemiWeather),
        ],
      );
      // https://docs-v2.riverpod.dev/docs/essentials/testing#unit-tests
      // provider が dispose されないように listen
      final subscription =
          container.listen(mainScreenStateNotifierProvider, (_, __) {});

      // Exercise
      container.read(mainScreenStateNotifierProvider.notifier).fetchWeather();

      // Verify
      expect(
        subscription.read().errorMessage,
        null,
      );
      expect(
        subscription.read().forecast,
        expected,
      );
    });
    test('失敗した場合、エラーメッセージが渡される', () {
      // Setup
      final dummyDateTime = DateTime.utc(2023, 11, 30);
      const dummyError = YumemiWeatherError.unknown;
      final expected = YumemiWeatherError.unknown.toMessage();

      final mockYumemiWeather = MockYumemiWeather();
      when(mockYumemiWeather.fetchWeather(any)).thenThrow(dummyError);

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
      container.read(mainScreenStateNotifierProvider.notifier).fetchWeather();

      // Verify
      expect(
        subscription.read().errorMessage,
        expected,
      );
      expect(
        subscription.read().forecast,
        null,
      );
    });
  });
}
