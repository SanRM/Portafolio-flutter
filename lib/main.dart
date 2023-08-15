// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:portafolio/screens/mobile.dart';
import 'package:provider/provider.dart';
import 'package:portafolio/styles/themes/styles.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.watch<ThemeProvider>().isDarkMode;

    return MaterialApp(
      //theme: isDarkMode ? DarkTheme.themeData : LightTheme.themeData,
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        body: AnimatedTheme(
          data: isDarkMode ? DarkTheme.themeData : LightTheme.themeData,
          duration: Duration(microseconds: 1),
          child: Mobile()
        ),
      ),
    );
  }
}

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
