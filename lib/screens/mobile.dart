import 'package:flutter/material.dart';
import 'package:portafolio/styles/Responsive/responsive.dart';
import 'package:portafolio/styles/themes/styles.dart';
import 'package:portafolio/widgets/initial_information.dart';
import 'package:portafolio/widgets/project_board.dart';
import 'package:portafolio/widgets/about_me.dart';
import 'package:portafolio/widgets/Skills.dart';
import 'package:portafolio/widgets/SendMessagePage.dart';
import 'package:provider/provider.dart';
import 'package:portafolio/main.dart';

class Mobile extends StatefulWidget {
  const Mobile({super.key});

  @override
  State<Mobile> createState() => _MobileState();
}

class _MobileState extends State<Mobile> {
  final ScrollController _scrollController = ScrollController();

  bool _backgroundColorSelected1 = true;
  bool _backgroundColorSelected2 = false;
  bool _backgroundColorSelected3 = false;

  bool isDarkMode = false;
  double height = 0;
  double width = 0;
  double currentPage = 1;
  bool? pressed;

  @override
  Widget build(BuildContext context) {
    isDarkMode = context.watch<ThemeProvider>().isDarkMode;
    height = Responsive(context: context).getDeviceHeight();
    width = Responsive(context: context).getDeviceWidth();

    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
      bottomNavigationBar: buildBottomAppBar(),
    );
  }

  sobreMiColor() {
    setState(() {
      _backgroundColorSelected1 = false;
      _backgroundColorSelected2 = false;
      _backgroundColorSelected3 = true;
      //print('Proyectos seleccionado');
    });
  }

  proyectosColor() {
    setState(() {
      _backgroundColorSelected1 = false;
      _backgroundColorSelected2 = true;
      _backgroundColorSelected3 = false;
      //print('Proyecto seleccionado');
    });
  }

  inicioColor() {
    setState(() {
      _backgroundColorSelected1 = true;
      _backgroundColorSelected2 = false;
      _backgroundColorSelected3 = false;
      //print('Inicio seleccionado');
    });
  }

  scrollToPageFromTop(double pageNumber) {
    _scrollController.animateTo(
      pageNumber * MediaQuery.of(context).size.height, // Altura de cada página
      duration: const Duration(milliseconds: 500), // Duración de la animación
      curve: Curves.easeInOut, // Curva de la animación
    );
  }

  scrollToPageFromBottom(double pageNumber) {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent / pageNumber,
      duration: const Duration(milliseconds: 500), // Duración de la animación
      curve: Curves.easeInOut, // Curva de la animación
    );
  }

  aumentCurrentPage(double increase) {
    setState(() {
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
      toolbarHeight: height / 8,
      elevation: 0,
      title: buildAppBarTitle(),
    );
  }

  Container buildAppBarTitle() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildAppName(),
          Container(
            //color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildDarkModeToggle(),
              buildContactButton(),
            ],
          )),
        ],
      ),
    );
  }

  Text buildAppName() {
    return Text(
      'Horizon \n SanTech',
      textAlign: TextAlign.center,
      overflow: TextOverflow.visible,
      style: TextStyle(
        fontFamily: principalFontFamily,
        fontSize: width / 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildDarkModeToggle() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Tooltip(
            message:
                isDarkMode ? 'Cambiar a modo claro' : 'Cambiar a modo oscuro',
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 7, 196, 230),
                Color.fromARGB(255, 63, 158, 236),
              ]),
            ),
            child: InkWell(
              customBorder: CircleBorder(),
              onTap: () {
                context.read<ThemeProvider>().toggleTheme();
              },
              child: Container(
                width: width / 6,
                height: height / 19,
                child: Icon(
                  isDarkMode ? Icons.light_mode : Icons.dark_mode_outlined,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: width / 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InkWell buildContactButton() {
    return InkWell(
      customBorder: CircleBorder(),
      onTap: () {
        setState(() {
          currentPage = 1.05;
        });
        scrollToPageFromBottom(currentPage);
      },
      child: Container(
        padding: EdgeInsets.all(height / 50),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadiusPrimary),
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        child: Center(
          child: Text(
            'Contacto',
            style: TextStyle(
              fontFamily: principalFontFamily,
              fontSize: width / 25,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
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
              ProjectBoard(width: width, height: height),
              AboutMe(width: width, height: height),
              Skills(width: width, height: height),
              SendMessagePage(height: height, width: width),
            ],
          ),
        ],
      ),
    );
  }

  BottomAppBar buildBottomAppBar() {
    return BottomAppBar(
      height: height / 10,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          border: Border(
            top: BorderSide(
              width: 0,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: width * sizedBoxWidth),
            buildBottomAppBarButton(
              label: 'Inicio',
              onPressed: () {
                setState(() {
                  pressed = true;
                });
                aumentCurrentPage(0);
                scrollToPageFromTop(currentPage);
                inicioColor();
              },
              isSelected: _backgroundColorSelected1,
            ),
            buildBottomAppBarButton(
              label: 'Proyectos',
              onPressed: () {
                setState(() {
                  pressed = true;
                });
                aumentCurrentPage(0.9);
                scrollToPageFromTop(currentPage);
                proyectosColor();
              },
              isSelected: _backgroundColorSelected2,
            ),
            buildBottomAppBarButton(
              label: 'Sobre mi',
              onPressed: () {
                setState(() {
                  pressed = true;
                });
                aumentCurrentPage(currentPage = 1);
                scrollToPageFromBottom(currentPage * 1.7);
                sobreMiColor();
              },
              isSelected: _backgroundColorSelected3,
            ),
            SizedBox(width: width * sizedBoxWidth)
          ],
        ),
      ),
    );
  }

  InkWell buildBottomAppBarButton({
    required String label,
    required VoidCallback onPressed,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: onPressed,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          color: isSelected ? tertiary : null,
          padding: EdgeInsets.symmetric(horizontal: width / 50),
          alignment: Alignment.center,
          height: height / 20,
          child: BottomAppBarButtons(
            width: width,
            height: height,
            label: label,
            bgIsSelected: isSelected,
          ),
        ),
      ),
    );
  }
}

class BottomAppBarButtons extends StatelessWidget {
  const BottomAppBarButtons({
    required this.width,
    required this.height,
    required this.label,
    required this.bgIsSelected,
  });

  final double width;
  final double height;
  final String label;
  final bool bgIsSelected;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: width / 20,
        color: bgIsSelected
            ? primaryBlack
            : Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
