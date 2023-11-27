import 'package:flutter_training/date_time_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_weather_request.freezed.dart';
part 'fetch_weather_request.g.dart';

@freezed
class FetchWeatherRequest with _$FetchWeatherRequest {
  const factory FetchWeatherRequest({
    required String area,
    @DateTimeConverter() required DateTime date,
  }) = _FetchWeatherRequest;

  factory FetchWeatherRequest.fromJson(Map<String, dynamic> json) =>
      _$FetchWeatherRequestFromJson(json);
}
