import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_training/forecast.dart';
import 'package:flutter_training/forecast_view.dart';
import 'package:flutter_training/yumemi_weather_error.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final YumemiWeather _yumemiWeather = YumemiWeather();
  Forecast? _forecast;

  void _fetchForecast() {
    const request = {
      'area': 'tokyo',
      'date': '2023-11-22T00:00:00+09:00',
    };
    final requestString = jsonEncode(request);

    final Forecast newForecast;
    try {
      newForecast = Forecast.from(_yumemiWeather.fetchWeather(requestString));
    } on YumemiWeatherError catch (e) {
      unawaited(_showErrorDialog(e.toMessage()));
      return;
    } on Exception catch (_) {
      const message = '不明なエラーです。';
      unawaited(_showErrorDialog(message));
      return;
    }
    setState(() {
      _forecast = newForecast;
    });
  }

  Future<void> _showErrorDialog(String message) async {
    if (!context.mounted) {
      return;
    }

    return showDialog<void>(
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
  }

  void _close(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.5,
          child: Column(
            children: [
              const Spacer(),
              ForecastView(
                forecast: _forecast,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: _OperationButtonSet(
                    onClose: () => _close(context),
                    onReload: _fetchForecast,
                  ),
                ),
              ),
            ],
          ),
        ),
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
