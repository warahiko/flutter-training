import 'package:flutter/material.dart';
import 'package:flutter_training/main_screen.dart';
import 'package:flutter_training/splash_screen.dart';
import 'package:flutter_training/ui/screen.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: Screen.splash.route,
      routes: <String, WidgetBuilder>{
        Screen.main.route: (_) => const MainScreen(),
        Screen.splash.route: (_) => const SplashScreen(),
      },
    ),
  );
}
