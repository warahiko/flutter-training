import 'package:flutter/material.dart';

class ForecastView extends StatelessWidget {
  const ForecastView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final labelLarge = theme.textTheme.labelLarge!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const AspectRatio(
          aspectRatio: 1,
          child: Placeholder(),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Text(
                '** ℃',
                style: labelLarge.copyWith(
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Text(
                '** ℃',
                style: labelLarge.copyWith(
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
