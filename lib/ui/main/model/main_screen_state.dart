import 'package:flutter_training/model/forecast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_screen_state.freezed.dart';
part 'main_screen_state.g.dart';

@freezed
class MainScreenState with _$MainScreenState {
  const factory MainScreenState({
    required Forecast? forecast,
    required String? errorMessage,
  }) = _MainScreenState;

  factory MainScreenState.fromJson(Map<String, dynamic> json) =>
      _$MainScreenStateFromJson(json);

  static const init = MainScreenState(
    forecast: null,
    errorMessage: null,
  );
}
