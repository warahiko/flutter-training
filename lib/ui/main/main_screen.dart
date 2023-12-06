import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/ui/main/provider/main_screen_state_notifier.dart';
import 'package:flutter_training/ui/main/view/forecast_view.dart';
import 'package:flutter_training/yumemi_weather_error.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  void _fetchForecast(WidgetRef ref) {
    unawaited(
      ref.read(mainScreenStateNotifierProvider.notifier).fetchWeather(),
    );
  }

  void _showErrorDialog(
    BuildContext context,
    WidgetRef ref,
    String message,
  ) {
    unawaited(() async {
      if (!context.mounted) {
        return;
      }

      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text('エラー'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(message),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }());
  }

  void _close(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forecast = ref.watch(
      mainScreenStateNotifierProvider.select((value) => value.forecast),
    );

    // build 完了後に発火するように listen
    ref.listen(
      mainScreenStateNotifierProvider.select((value) => value.forecast),
      (_, forecast) {
        if (forecast is! AsyncError) {
          return;
        }

        final errorMessage = switch (forecast.error) {
          final YumemiWeatherError e => e.toMessage(),
          final Exception _ => '不明なエラーです。',
          _ => throw StateError('Invalid'),
        };
        _showErrorDialog(context, ref, errorMessage);
      },
    );

    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: FractionallySizedBox(
              widthFactor: 0.5,
              child: Column(
                children: [
                  const Spacer(),
                  ForecastView(
                    forecast: forecast.valueOrNull,
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 80),
                      child: _OperationButtonSet(
                        onClose: () => _close(context),
                        onReload: () => _fetchForecast(ref),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (forecast.isLoading)
            ColoredBox(
              color: Colors.black54,
              child: Center(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.background,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _OperationButtonSet extends StatelessWidget {
  const _OperationButtonSet({
    required VoidCallback onClose,
    required VoidCallback onReload,
  })  : _onClose = onClose,
        _onReload = onReload;

  final VoidCallback _onClose;
  final VoidCallback _onReload;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: _onClose,
            child: const Text('Close'),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: _onReload,
            child: const Text('Reload'),
          ),
        ),
      ],
    );
  }
}
