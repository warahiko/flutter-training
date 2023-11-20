import 'package:flutter/material.dart';
import 'package:flutter_training/forecast.dart';
import 'package:flutter_training/forecast_view.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<StatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final YumemiWeather _yumemiWeather = YumemiWeather();
  Forecast? _forecast;

  void _fetchForecast() {
    final newForecast = Forecast.from(_yumemiWeather.fetchSimpleWeather());
    setState(() {
      _forecast = newForecast;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                      onReload: _fetchForecast,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OperationButtonSet extends StatelessWidget {
  const _OperationButtonSet({
    required VoidCallback onReload,
  }) : _onReload = onReload;

  final VoidCallback _onReload;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {},
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
