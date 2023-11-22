import 'package:flutter/material.dart';
import 'package:flutter_training/forecast.dart';
import 'package:flutter_training/forecast_view.dart';
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
    final newForecast = Forecast.from(_yumemiWeather.fetchSimpleWeather());
    setState(() {
      _forecast = newForecast;
    });
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
