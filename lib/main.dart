import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/ui/main/main_screen.dart';
import 'package:flutter_training/ui/screen.dart';
import 'package:flutter_training/ui/splash/splash_screen.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        initialRoute: Screen.splash.route,
        routes: <String, WidgetBuilder>{
          Screen.main.route: (_) => const MainScreen(),
          Screen.splash.route: (_) => const SplashScreen(),
        },
      ),
    ),
  );
}
