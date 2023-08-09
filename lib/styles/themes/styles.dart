
import 'package:flutter/material.dart';

//2. Estilos globales de la App:
const double ContainerBorderWidth = 3;
const double ContainerBorderRadius = 50;


//3. Modo oscuro de la App
class DarkTheme {
  static ThemeData themeData = ThemeData.dark().copyWith(
    
    

  );
}

//5. Modo claro de la App
class LightTheme {

  static ThemeData themeData = ThemeData.light().copyWith(

    textTheme: TextTheme(bodyLarge: TextStyle(fontSize: 20, color: Color.fromRGBO(27, 33, 48, 1), fontWeight: FontWeight.bold)),

    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color.fromRGBO(27, 33, 48, 1),
      onPrimary: Color.fromRGBO(221, 130, 130, 1),
      secondary: Color.fromRGBO(0, 54, 94, 100),
      onSecondary: Color.fromRGBO(255, 255, 255, 100),
      error: Color.fromRGBO(255, 164, 164, 100),
      onError: Color.fromRGBO(245, 51, 86, 100),
      background: Color.fromRGBO(27, 33, 48, 100),
      onBackground: Color.fromRGBO(27, 33, 48, 100),
      surface: Color.fromRGBO(135, 211, 255, 100),
      onSurface: Color.fromRGBO(0, 77, 112, 100),
      outline: Color.fromRGBO(27, 33, 48, 1),
      primaryContainer: Colors.transparent,
    ),
    scaffoldBackgroundColor: Color.fromRGBO(232, 232, 232, 1),
    
  );
}