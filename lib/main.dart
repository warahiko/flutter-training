import 'package:flutter/material.dart';
import 'package:flutter_training/main_screen.dart';
import 'package:flutter_training/splash_screen.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/splash',
      routes: <String, WidgetBuilder>{
        '/main': (_) => const MainScreen(),
        '/splash': (_) => const SplashScreen(),
      },
    ),
  );
}
