import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const _waitInMillis = 500;

  @override
  void initState() {
    super.initState();
    unawaited(_transition(context));
  }

  Future<void> _transition(BuildContext context) async {
    await SchedulerBinding.instance.endOfFrame;
    await Future<void>.delayed(
      const Duration(milliseconds: _waitInMillis),
    );

    if (!context.mounted) {
      return;
    }
    // 遷移先から戻るまで待機
    await Navigator.pushNamed(context, '/main');

    if (!context.mounted) {
      return;
    }
    unawaited(_transition(context));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.green,
    );
  }
}
