import 'package:flutter/material.dart';

class Styles extends StatefulWidget {
  const Styles({super.key});

  @override
  State<Styles> createState() => _StylesState();
}

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
const Color tertiary = Color.fromRGBO(167, 223, 255, 1);
const Color errorFormBorder = Color.fromARGB(255, 255, 88, 138);

//10. Font family

const String principalFontFamily = 'DMSans';

//8. Degradees
List<Color> principalDegradee = [
  Color.fromARGB(255, 24, 194, 216),
  Color.fromARGB(255, 23, 164, 207),
  Color.fromARGB(255, 24, 194, 216),
  Color.fromARGB(255, 23, 164, 207),
  Color.fromARGB(255, 24, 194, 216),
];

List<Color> secondaryDegradee = [
  Color.fromARGB(255, 53, 221, 243),
  Color.fromARGB(255, 42, 199, 247),
  Color.fromARGB(255, 53, 221, 243),
  Color.fromARGB(255, 42, 199, 247),
  Color.fromARGB(255, 53, 221, 243),
];

//7. ProjectBoard Widget
const Color principalButton = Color.fromRGBO(81, 235, 255, 1);
const Color labelOutline = Color.fromARGB(255, 131, 131, 131);
const Color labelTextColor = Color.fromARGB(255, 41, 41, 41);
const Color projectBoardDescription = Color.fromARGB(255, 82, 82, 82);

//5. Modo claro de la App
class LightTheme {
  static ThemeData themeData = ThemeData().copyWith(

    inputDecorationTheme: const InputDecorationTheme(
      floatingLabelAlignment: FloatingLabelAlignment.start,
      counterStyle: TextStyle(fontFamily: principalFontFamily, color: Color.fromARGB(255, 71, 71, 71)),
      labelStyle: TextStyle(fontFamily: principalFontFamily, color: primaryBlack),
      errorStyle: TextStyle(fontFamily: principalFontFamily, color: Color.fromARGB(255, 255, 7, 81)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(width: 2, color: errorFormBorder)),     
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(width: 2, color: errorFormBorder)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(width: 2, color: Color.fromARGB(255, 25, 204, 106))),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(width: 2, color: primaryBlack)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(width: 2, color: primaryBlack)),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(width: 2, color: primaryBlack)),
    ),

    //6. Estilo Scaffold
    scaffoldBackgroundColor: primaryLight,

    textTheme: const TextTheme(
      //displayLarge: TextStyle(fontWeight: FontWeight.bold),
      
      bodyMedium: TextStyle(fontWeight: FontWeight.bold, color: primaryBlack),
      bodyLarge: TextStyle(color: primaryBlack),
      titleMedium: TextStyle(color: primaryBlack)
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.transparent),
        shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
        side: MaterialStatePropertyAll(BorderSide(width: 1.5, color: primaryBlack)),
        textStyle: MaterialStatePropertyAll(TextStyle(fontWeight: FontWeight.bold))
      )
    ),

    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            padding: MaterialStatePropertyAll(paddingAll),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50))))),

    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 32, 238, 159)),
      )
    ),


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
      surface: Color.fromARGB(255, 9, 224, 81),
      onSurface: Color.fromRGBO(0, 77, 112, 100),
      outline: Color.fromRGBO(27, 33, 48, 1),
      primaryContainer: Color.fromRGBO(232, 232, 232, 1),
      inversePrimary: Color.fromRGBO(0, 217, 255, 0.158)
    ),
  );
}

//3. Modo oscuro de la App
class DarkTheme {
  static ThemeData themeData = ThemeData.light().copyWith(
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(fontFamily: principalFontFamily, color: primaryLight),
      counterStyle: TextStyle(fontFamily: principalFontFamily, color: Color.fromARGB(255, 158, 158, 158)),
      errorStyle: TextStyle(fontFamily: principalFontFamily, color: Color.fromARGB(255, 255, 77, 130)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(width: 2, color: errorFormBorder)),     
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(width: 2, color: errorFormBorder)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(width: 2, color: Color.fromARGB(255, 16, 240, 135))),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(width: 2, color: primaryLight)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(width: 2, color: primaryBlack)),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(width: 2, color: primaryBlack)),
    ),

    scaffoldBackgroundColor: primaryBlack,

    textTheme: const TextTheme(
      bodyMedium: TextStyle(fontWeight: FontWeight.bold, color: primaryBlack),
      titleMedium: TextStyle(color: primaryLight)
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.transparent),
        shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
        side: MaterialStatePropertyAll(BorderSide(width: 1.5, color: primaryLight)),
        textStyle: MaterialStatePropertyAll(TextStyle(fontWeight: FontWeight.bold))
      )
    ),

    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50))))),

    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 32, 238, 159)),
      )
    ),

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
      surface: Color.fromARGB(255, 32, 238, 159),
      onSurface: Color.fromRGBO(0, 77, 112, 100),
      outline: Color.fromRGBO(27, 33, 48, 1),
      primaryContainer: Color.fromRGBO(27, 33, 48, 1),
      inversePrimary: Color.fromRGBO(2, 225, 255, 0.176)
    ),
  );
}

class _StylesState extends State<Styles> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}