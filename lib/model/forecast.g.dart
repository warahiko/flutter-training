// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ForecastImpl _$$ForecastImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$ForecastImpl',
      json,
      ($checkedConvert) {
        final val = _$ForecastImpl(
          weather: $checkedConvert(
              'weather_condition', (v) => $enumDecode(_$WeatherEnumMap, v)),
          maxTemperature: $checkedConvert('max_temperature', (v) => v as int),
          minTemperature: $checkedConvert('min_temperature', (v) => v as int),
        );
        return val;
      },
      fieldKeyMap: const {
        'weather': 'weather_condition',
        'maxTemperature': 'max_temperature',
        'minTemperature': 'min_temperature'
      },
    );

Map<String, dynamic> _$$ForecastImplToJson(_$ForecastImpl instance) =>
    <String, dynamic>{
      'weather_condition': _$WeatherEnumMap[instance.weather]!,
      'max_temperature': instance.maxTemperature,
      'min_temperature': instance.minTemperature,
    };

const _$WeatherEnumMap = {
  Weather.sunny: 'sunny',
  Weather.cloudy: 'cloudy',
  Weather.rainy: 'rainy',
};
