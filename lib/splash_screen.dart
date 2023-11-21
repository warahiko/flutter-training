import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_training/end_of_frame_listener_mixin.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with EndOfFrameListenerMixin {
  static const _waitInMillis = 500;

  @override
  void onEndOfFrame() {
    unawaited(_transition(context));
  }

  Future<void> _transition(BuildContext context) async {
    await Future<void>.delayed(
      const Duration(milliseconds: _waitInMillis),
    );

    if (!context.mounted) {
      return;
    }
    // 遷移先から戻るまで待機
    await Navigator.pushNamed(context, '/main');

    unawaited(listenEndOfFrame());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
      ),
    );
  }
}
