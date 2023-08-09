import 'package:flutter/material.dart';
import 'package:portafolio/styles/Responsive/responsive.dart';
import 'package:portafolio/styles/themes/styles.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    Widget body = Responsive(context: context).getDevice();

    bool isDarkMode = false;

    return MaterialApp(
      theme: isDarkMode ? DarkTheme.themeData : LightTheme.themeData,
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: body
    );
  }
}