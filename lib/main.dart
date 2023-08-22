// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:portafolio/screens/mobile.dart';
import 'package:provider/provider.dart';
import 'package:portafolio/styles/themes/styles.dart';
import 'package:portafolio/styles/Responsive/responsive.dart';

//firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
  
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
          //child: Responsive(context: context).getDevice()
          child: Mobile(),
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
