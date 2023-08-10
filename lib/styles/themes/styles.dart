import 'package:flutter/material.dart';


//2. Estilos globales de la App:

const double containerBorderWidth = 3;
const double containerBorderRadius = 50;
const double containerWidth = 0.3;
const double containerPadding = 10;

const double heightDivisor = 13;
const EdgeInsets paddingSymetric = EdgeInsets.symmetric(horizontal: 25, vertical: 25); 
const EdgeInsets paddingSymmetricTop = EdgeInsets.only(top: 30, left: 25, right:  25); 
const EdgeInsets paddingSymetricMiddle = EdgeInsets.only(left: 25, right:  25); 
const EdgeInsets paddingAll = EdgeInsets.all(15); 

const double sizedBoxWidth = 0.01;

const double appbarSpacing = 0.09;
const double iconAppBarSize = 30;

const double imageScale = 0.03;

//3. Modo oscuro de la App
class DarkTheme {
  static ThemeData themeData = ThemeData.dark().copyWith();
}

//5. Modo claro de la App
class LightTheme {
  
  static ThemeData themeData = ThemeData.light().copyWith(
    //6. Estilo Scaffold
    scaffoldBackgroundColor: Color.fromRGBO(232, 232, 232, 1),

    textTheme: const TextTheme(

        bodyLarge: TextStyle(
            fontSize: 20,
            color: Color.fromRGBO(27, 33, 48, 1),
            fontWeight: FontWeight.bold
            ),
            
        bodyMedium: TextStyle(            
            fontSize: 15,
            color: Color.fromRGBO(27, 33, 48, 1),
            fontWeight: FontWeight.bold
            ),

        titleMedium: TextStyle(            
            fontSize: 20,
            color: Color.fromRGBO(254, 254, 255, 1),
            fontWeight: FontWeight.bold
            ),

        titleLarge: TextStyle(
            fontSize: 40,
            color: Color.fromRGBO(27, 33, 48, 1),
            fontWeight: FontWeight.bold,
            letterSpacing: 6            
        ),

        titleSmall: TextStyle(
            fontSize: 50,
            color: Color.fromARGB(255, 0, 183, 255),
            fontWeight: FontWeight.bold,
            
        )     

    ),

    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color.fromRGBO(27, 33, 48, 1),
      onPrimary: Color.fromRGBO(255, 255, 255, 1),
      secondary: Color.fromRGBO(0, 54, 94, 100),
      onSecondary: Color.fromRGBO(51, 50, 50, 1),
      error: Color.fromRGBO(255, 164, 164, 100),
      onError: Color.fromRGBO(245, 51, 86, 100),
      background: Color.fromRGBO(27, 33, 48, 100),
      onBackground: Color.fromRGBO(27, 33, 48, 100),
      surface: Color.fromRGBO(135, 211, 255, 100),
      onSurface: Color.fromRGBO(0, 77, 112, 100),
      outline: Color.fromRGBO(27, 33, 48, 1),
      primaryContainer: Colors.transparent,
    ),

  );
}
