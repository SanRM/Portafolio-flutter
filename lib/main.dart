import 'package:flutter/material.dart';
import 'package:portafolio/styles/Responsive/responsive.dart';
import 'package:portafolio/styles/themes/styles.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
              // statusBarColor is used to set Status bar color in Android devices.
              statusBarColor: Colors.transparent,
        
              // To make Status bar icons color white in Android devices.
              statusBarIconBrightness: Brightness.dark,
        
              // statusBarBrightness is used to set Status bar icon color in iOS.
              statusBarBrightness: Brightness.dark,
              // Here light means dark icon color for Status bar.
            ));

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