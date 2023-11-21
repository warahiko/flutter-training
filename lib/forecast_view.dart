import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_training/forecast.dart';

class ForecastView extends StatelessWidget {
  const ForecastView({
    required Forecast? forecast,
    super.key,
  }) : _forecast = forecast;

  final Forecast? _forecast;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final labelLarge = theme.textTheme.labelLarge!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: _forecast == null
              ? const Placeholder()
              : SvgPicture.asset(_forecast.image),
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
