// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'main_screen_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MainScreenStateImpl _$$MainScreenStateImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$MainScreenStateImpl',
      json,
      ($checkedConvert) {
        final val = _$MainScreenStateImpl(
          forecast: $checkedConvert(
              'forecast',
              (v) => v == null
                  ? null
                  : Forecast.fromJson(v as Map<String, dynamic>)),
          errorMessage: $checkedConvert('error_message', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {'errorMessage': 'error_message'},
    );

Map<String, dynamic> _$$MainScreenStateImplToJson(
        _$MainScreenStateImpl instance) =>
    <String, dynamic>{
      'forecast': instance.forecast,
      'error_message': instance.errorMessage,
    };
