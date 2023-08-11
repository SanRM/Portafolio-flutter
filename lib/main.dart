// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portafolio/styles/Responsive/responsive.dart';
import 'package:portafolio/styles/themes/styles.dart';
import 'components/Header.dart';

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
    Widget body = Responsive(context: context).getDevice();
    double height = Responsive(context: context).getDeviceHeight();
    double width = Responsive(context: context).getDeviceWidth();

    bool isDarkMode = context.watch<ThemeProvider>().isDarkMode;

    return MaterialApp(
        theme: isDarkMode ? DarkTheme.themeData : LightTheme.themeData,
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: Scaffold(
          appBar: Header(height: height, width: width),
          body: body,
        ));
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
