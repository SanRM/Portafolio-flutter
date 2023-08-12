import 'package:flutter/material.dart';

//2. Estilos globales de la App:

const double containerBorderWidth = 3;
const double borderRadiusPrimary = 50;
const double borderRadiusSecondary = 20;
const double containerWidth = 0.3;
const double containerPadding = 10;

const double heightDivisorAppBar = 7.5;
const double heightDivisorBottomAppBar = 12;
const EdgeInsets paddingSymetric =
    EdgeInsets.symmetric(horizontal: 25, vertical: 25);
const EdgeInsets paddingSymmetricTop =
    EdgeInsets.only(top: 30, left: 25, right: 25);
const EdgeInsets paddingSymetricMiddle = EdgeInsets.only(left: 25, right: 25);
const EdgeInsets paddingAll = EdgeInsets.all(15);
const EdgeInsets projectBoardPadding =
    EdgeInsets.symmetric(horizontal: 30, vertical: 50);

const double sizedBoxWidth = 0.01;

const double appbarSpacing = 0.09;
const double iconAppBarSize = 30;

const double imageScale = 0.03;

//7. Colores
const Color primaryBlack = Color.fromRGBO(27, 33, 48, 1);
const Color primaryLight = Color.fromRGBO(232, 232, 232, 1);
const Color secondary = Color.fromRGBO(41, 41, 41, 1);
const Color secondaryVariation = Color.fromRGBO(70, 70, 70, 1);
const Color tertiary = Color.fromRGBO(151, 217, 255, 1);

//7. ProjectBoard Widget
const Color principalButton = Color.fromRGBO(81, 235, 255, 1);
const Color labelOutline = Color.fromARGB(255, 131, 131, 131);
const Color labelTextColor = Color.fromARGB(255, 82, 82, 82);
const Color projectBoardDescription = Color.fromARGB(255, 82, 82, 82);

//5. Modo claro de la App
class LightTheme {
  static ThemeData themeData = ThemeData().copyWith(
    //6. Estilo Scaffold
    scaffoldBackgroundColor: primaryLight,

    textTheme: const TextTheme(
      bodyMedium: TextStyle(fontWeight: FontWeight.bold),
    ),

    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            overlayColor: const MaterialStatePropertyAll(tertiary),
            backgroundColor: const MaterialStatePropertyAll(primaryLight),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50))))),

    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: primaryLight,
      onPrimary: primaryBlack,
      secondary: secondary,
      onSecondary: Color.fromRGBO(119, 209, 212, 1),
      error: Color.fromRGBO(255, 164, 164, 100),
      onError: Color.fromRGBO(245, 51, 86, 100),
      background: Color.fromRGBO(27, 33, 48, 100),
      onBackground: Color.fromRGBO(27, 33, 48, 100),
      surface: Color.fromRGBO(135, 211, 255, 100),
      onSurface: Color.fromRGBO(0, 77, 112, 100),
      outline: Color.fromRGBO(27, 33, 48, 1),
      primaryContainer: Color.fromRGBO(232, 232, 232, 1),
    ),
  );
}

//3. Modo oscuro de la App
class DarkTheme {
  static ThemeData themeData = ThemeData.light().copyWith(
    scaffoldBackgroundColor: primaryBlack,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: primaryBlack,
      onPrimary: primaryLight,
      secondary: secondary,
      onSecondary: Color.fromRGBO(51, 50, 50, 1),
      error: Color.fromRGBO(255, 164, 164, 100),
      onError: Color.fromRGBO(245, 51, 86, 100),
      background: Color.fromRGBO(27, 33, 48, 100),
      onBackground: Color.fromRGBO(27, 33, 48, 100),
      surface: Color.fromRGBO(135, 211, 255, 100),
      onSurface: Color.fromRGBO(0, 77, 112, 100),
      outline: Color.fromRGBO(27, 33, 48, 1),
      primaryContainer: Color.fromRGBO(27, 33, 48, 1),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}
