import 'package:yumemi_weather/yumemi_weather.dart';

extension YumemiWeatherErrorExt on YumemiWeatherError {
  String toMessage() => switch (this) {
        YumemiWeatherError.invalidParameter => '無効なパラメータです。',
        YumemiWeatherError.unknown => '不明なエラーです。',
      };
}
