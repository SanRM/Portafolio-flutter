import 'package:flutter/material.dart';
import 'package:portafolio/Responsive/responsive.dart';
//import 'package:portafolio/screens/Desktop/widgets/project_board.dart';
import 'package:portafolio/styles/styles.dart';
import 'package:portafolio/screens/Desktop/widgets/initial_information.dart';

import 'package:provider/provider.dart';
import 'package:portafolio/main.dart';

class Desktop extends StatefulWidget {
  const Desktop({super.key});

  @override
  State<Desktop> createState() => _DesktopState();
}

class _DesktopState extends State<Desktop> {
  final ScrollController _scrollController = ScrollController();

  bool _backgroundColorSelected1 = true;
  bool _backgroundColorSelected2 = false;
  bool _backgroundColorSelected3 = false;

  bool isDarkMode = false;
  double height = 0;
  double width = 0;
  double currentPage = 1;
  bool? pressed;

  buttonBackground(String button) {
    setState(() {
      switch (button) {
        case 'Inicio':
          _backgroundColorSelected1 = true;
          _backgroundColorSelected2 = false;
          _backgroundColorSelected3 = false;
          break;
        case 'Proyectos':
          _backgroundColorSelected1 = false;
          _backgroundColorSelected2 = true;
          _backgroundColorSelected3 = false;
          break;
        case 'Sobre mi':
          _backgroundColorSelected1 = false;
          _backgroundColorSelected2 = false;
          _backgroundColorSelected3 = true;
          break;
        default:
      }
      //print('Proyectos seleccionado');
    });
  }

  scrollToPageFromTop(double pageNumber) {
    _scrollController.animateTo(
      pageNumber * MediaQuery.of(context).size.height, // Altura de cada página
      duration: const Duration(milliseconds: 500), // Duración de la animación
      curve: Curves.easeInOut, // Curva de la animación
    );
  }

  aumentCurrentPage(double increase) {
    setState(() {
      pressed = true;
      //print(pressed);
      if (pressed == true) {
        //print(increase);
        currentPage = increase;
        pressed == false;
        //print('$currentPage, $pressed');
      }
    });
  }

  AppBar buildAppBar() {
    return AppBar(
      toolbarHeight: height / 6,
      elevation: 0,
      titleSpacing: width / 30,
      title: buildAppBarTitle(),
    );
  }

  buildAppName() {
    return Container(
      padding: EdgeInsets.only(left: width/50),
      child: Text(
        'Horizon SanTech',
        textAlign: TextAlign.center,
        overflow: TextOverflow.visible,
        style: TextStyle(
          fontFamily: principalFontFamily,
          fontSize: width / 75,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildDarkModeToggle() {
    return Container(
      padding: EdgeInsets.only(left: width / 100),
      child: Tooltip(
        message: isDarkMode ? 'Cambiar a modo claro' : 'Cambiar a modo oscuro',
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 7, 196, 230),
          Color.fromARGB(255, 63, 158, 236),
        ])),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: () {
            context.read<ThemeProvider>().toggleTheme();
          },
          child: Container(
            //padding: EdgeInsets.only(left: width / 50),
            //color: Colors.red,
            child: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode_outlined,
              color: Theme.of(context).colorScheme.onPrimary,
              size: width / 70,
            ),
          ),
        ),
      ),
    );
  }

  Container buildAppBarTitle() {
    return Container(
      //color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildAppName(),
          Container(
              //color: Colors.red,
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //buildContactButton(),
              navigationButtons()
            ],
          )),
        ],
      ),
    );
  }

  navigationButtons() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: height / 100),
      //color: Colors.red,
      decoration: BoxDecoration(
        //color: Colors.blue,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: Theme.of(context).colorScheme.onPrimary,
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildDarkModeToggle(),
          NavigationButton('Inicio',),
          NavigationButton('Proyectos'),
          NavigationButton('Sobre mi'),
          NavigationButton('Contacto',
              backgroundColor: Color.fromARGB(255, 81, 225, 250),
              textColor: primaryBlack)
        ],
      ),
    );
  }

  NavigationButton(String name, {Color? backgroundColor, Color? textColor}) {
    return Container(
      //color: Colors.yellow,
      padding: EdgeInsets.symmetric(
        horizontal: width / 200,
      ),
      child: InkWell(
        overlayColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.inversePrimary),
        borderRadius: BorderRadius.circular(borderRadiusPrimary),
        onTap: (){
          switch (name) {
            case 'Inicio':
              print('a');
              break;

          case 'Proyectos':
              print('b');
              break;

          case 'Sobre mi':
              print('c');
              break;
          
          case 'Contacto':
              print('d');
              break;

          }
        },
        child: Container(
          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(borderRadiusPrimary)),
          padding: EdgeInsets.all(width / 200),
          alignment: Alignment.center,
          child: Container(
            //color: Colors.blue,
            child: Text(
              name,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: principalFontFamily,
                  fontSize: width / 100,
                  color: textColor),
            ),
          ),
        ),
      ),
    );
  }

  SafeArea buildBody() {
    return SafeArea(
      child: ListView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(
          decelerationRate: ScrollDecelerationRate.normal,
        ),
        children: [
          Column(
            children: [
              InitialInformation(width: width, height: height),
              
              // AboutMe(width: width, height: height),
              // Skills(width: width, height: height),
              // SendMessagePage(height: height, width: width),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    isDarkMode = context.watch<ThemeProvider>().isDarkMode;
    height = Responsive(context: context).getDeviceHeight();
    width = Responsive(context: context).getDeviceWidth();

    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }
  
}
