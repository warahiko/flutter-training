import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/model/forecast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_screen_state.freezed.dart';

@freezed
class MainScreenState with _$MainScreenState {
  const factory MainScreenState({
    required AsyncValue<Forecast?> forecast,
  }) = _MainScreenState;

  static const init = MainScreenState(
    forecast: AsyncData(null),
  );
}
