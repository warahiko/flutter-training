import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

/// yumemi_weather で用いられる日時形式に変換する JsonConverter
///
/// 形式例
/// - 2020-04-01T12:00:00+09:00
/// 参照
/// - https://yumemi-inc.github.io/flutter-training-template/file-___home_runner_work_flutter-training-template_flutter-training-template_packages_yumemi_weather_lib_src_yumemi_weather_base/YumemiWeather/fetchWeather.html
class DateTimeConverter implements JsonConverter<DateTime, String> {
  const DateTimeConverter();

  // DateTime#toIso8601String() はマイクロ秒まで出力されるため用いない
  // タイムゾーンは intl では未実装のため自前で追加する
  // see: https://api.flutter.dev/flutter/intl/DateFormat-class.html
  static final DateFormat dateFormatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss");

  static final NumberFormat timeFormatter = NumberFormat('00');

  @override
  DateTime fromJson(String json) {
    // DateFormat#parse() では UTC とローカルのタイムゾーン以外対応できない
    // DateTime.parse() はタイムゾーンを考慮した上で UTC に変更する
    return DateTime.parse(json);
  }

  @override
  String toJson(DateTime object) {
    final dateTimeStr = dateFormatter.format(object);
    final timeZoneStr = _toTimeZoneString(object.timeZoneOffset);
    return '$dateTimeStr$timeZoneStr';
  }

  String _toTimeZoneString(Duration offset) {
    final inMinutes = offset.inMinutes.abs();

    if (inMinutes == 0) {
      return 'Z';
    }

    final sign = offset.isNegative ? '-' : '+';

    final hours = timeFormatter.format(inMinutes ~/ Duration.minutesPerHour);
    final minutes = timeFormatter.format(inMinutes % Duration.minutesPerHour);

    return '$sign$hours:$minutes';
  }
}
