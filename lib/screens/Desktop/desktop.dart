import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:portafolio/Responsive/responsive.dart';
import 'package:portafolio/screens/Desktop/widgets/SendMessagePage.dart';
import 'package:portafolio/screens/Desktop/widgets/about_me.dart';
import 'package:portafolio/screens/Desktop/widgets/project_board.dart';
import 'package:portafolio/services/firebase_service.dart';
//import 'package:portafolio/screens/Desktop/widgets/project_board.dart';
import 'package:portafolio/styles/styles.dart';
import 'package:portafolio/screens/Desktop/widgets/initial_information.dart';

import 'package:provider/provider.dart';
import 'package:portafolio/main.dart';

import 'package:blur/blur.dart';

class Desktop extends StatefulWidget {
  const Desktop({super.key});

  @override
  State<Desktop> createState() => _DesktopState();
}

class _DesktopState extends State<Desktop> {
  final ScrollController _scrollController = ScrollController();

  bool isDarkMode = false;
  double height = 0;
  double width = 0;
  double currentPage = 1;
  bool? pressed;

  scrollToPageFromTop(double pageNumber) {
    _scrollController.animateTo(
      pageNumber * MediaQuery.of(context).size.height, // Altura de cada página
      duration: const Duration(milliseconds: 500), // Duración de la animación
      curve: Curves.easeInOut, // Curva de la animación
    );
  }

  logo() {
    return Container(
      alignment: Alignment.center,
      //color: Colors.red,
      height: height / 20,
      width: width / 8,
      //padding: EdgeInsets.only(left: width / 50),
      child: SelectableText(
        'Horizon SanTech',
        textAlign: TextAlign.center,
        //overflow: TextOverflow.visible,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
          fontFamily: principalFontFamily,
          fontSize: width / 75,
          fontWeight: FontWeight.bold,
        ),
      ),
    ).frosted(
      blur: 15,
      frostColor: isDarkMode ? primaryBlack : primaryLight,
      borderRadius: BorderRadius.circular(100),
    );
  }

  Widget buildDarkModeToggle() {
    return Container(
      padding: EdgeInsets.only(left: width / 100),
      child: InkWell(
        overlayColor: MaterialStatePropertyAll(
            Theme.of(context).colorScheme.inversePrimary),
        customBorder: const CircleBorder(),
        onTap: () {
          context.read<ThemeProvider>().toggleTheme();
        },
        child: Container(
          height: height / 20,
          //padding: EdgeInsets.only(left: width / 50),
          //color: Colors.red,
          child: Icon(
            isDarkMode ? Icons.light_mode : Icons.dark_mode_outlined,
            color: Theme.of(context).colorScheme.onPrimary,
            size: width / 70,
          ),
        ),
      ),
    );
  }

  Container buildAppBar() {
    return Container(
      height: height / 13,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.symmetric(horizontal: width / 50),
      //color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          logo(),
          navigationButtons(),
        ],
      ),
    );
  }

  navigationButtons() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: height / 100),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildDarkModeToggle(),
            NavigationButton(
              'Inicio',
              textColor: Theme.of(context).colorScheme.onPrimary,
            ),
            NavigationButton(
              'Proyectos',
              textColor: Theme.of(context).colorScheme.onPrimary,
            ),
            NavigationButton(
              'Sobre mi',
              textColor: Theme.of(context).colorScheme.onPrimary,
            ),
            NavigationButton(
              'Contacto',
              backgroundColor: Color.fromARGB(255, 81, 225, 250),
              textColor: primaryBlack,
            ),
          ],
        )).frosted(
      blur: 15,
      frostColor: isDarkMode ? primaryBlack : primaryLight,
      borderRadius: BorderRadius.circular(100),
    );
  }

  NavigationButton(String name, {Color? backgroundColor, Color? textColor}) {
    return Container(
      //color: const Color.fromARGB(118, 255, 235, 59),
      padding: EdgeInsets.symmetric(
        horizontal: width / 200,
      ),
      child: InkWell(
        overlayColor: MaterialStatePropertyAll(isDarkMode
            ? Color.fromARGB(33, 255, 255, 255)
            : Color.fromARGB(20, 0, 0, 0)),
        borderRadius: BorderRadius.circular(borderRadiusPrimary),
        onTap: () {
          switch (name) {
            case 'Inicio':
              //print('Inicio');
              _scrollController.animateTo(
                height - (height / 0.95),
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
              break;

            case 'Proyectos':
              _scrollController.animateTo(
                //height * 1,
                height * 0.940,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
              //print('Proyectos');
              break;

            case 'Sobre mi':
              //print('Sobre mi');
              _scrollController.animateTo(
                _scrollController.position.maxScrollExtent / 1.51,
                duration: const Duration(
                    milliseconds: 500), // Duración de la animación
                curve: Curves.easeInOut, // Curva de la animación
              );
              break;

            case 'Contacto':
              //print('Contacto');
              _scrollController.animateTo(
                _scrollController.position.maxScrollExtent / 0.99,
                duration: const Duration(
                    milliseconds: 500), // Duración de la animación
                curve: Curves.easeInOut, // Curva de la animación
              );
              break;
          }
        },
        child: Container(
          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(borderRadiusPrimary)),
          //padding: EdgeInsets.all(width / 200),
          height: height / 20,
          width: width / 20,
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
              FutureBuilder(
                future: getProjects(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ProjectBoard(snapshot: snapshot, width: width, height: height);
                  } else {
                    return Center(child: CircularProgressIndicator(color: Color.fromARGB(137, 0, 141, 151),), );
                  }
                  
                },
              ),
              AboutMe(width: width, height: height),
              SendMessagePage(height: height, width: width),
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
      body: Stack(
        children: [
          buildBody(),
          buildAppBar(),
        ],
      ),
    );
  }
}