// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_weather_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FetchWeatherRequestImpl _$$FetchWeatherRequestImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$FetchWeatherRequestImpl',
      json,
      ($checkedConvert) {
        final val = _$FetchWeatherRequestImpl(
          area: $checkedConvert('area', (v) => v as String),
          date: $checkedConvert(
              'date', (v) => const DateTimeConverter().fromJson(v as String)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$FetchWeatherRequestImplToJson(
        _$FetchWeatherRequestImpl instance) =>
    <String, dynamic>{
      'area': instance.area,
      'date': const DateTimeConverter().toJson(instance.date),
    };
