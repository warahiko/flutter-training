import 'package:flutter/material.dart';
import 'package:flutter_training/forecast_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: FractionallySizedBox(
            widthFactor: 0.5,
            child: Column(
              children: [
                Spacer(),
                ForecastView(),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(top: 80),
                    child: _OperationButtonSet(),
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
  const _OperationButtonSet();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: (){},
            child: const Text('Close'),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: (){},
            child: const Text('Reload'),
          ),
        ),
      ],
    );
  }
}
