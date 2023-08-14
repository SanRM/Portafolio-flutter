// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
//import 'package:portafolio/components/bottom_app_bar.dart';
import 'package:portafolio/styles/Responsive/responsive.dart';
import 'package:portafolio/styles/themes/styles.dart';
import 'package:portafolio/widgets/initial_information.dart';
import 'package:portafolio/widgets/project_board.dart';
import 'package:provider/provider.dart';
import 'package:portafolio/main.dart';
import 'package:portafolio/widgets/about_me.dart';
import 'package:portafolio/widgets/Skills.dart';

class Mobile extends StatefulWidget {
  const Mobile({super.key});

  @override
  State<Mobile> createState() => _MobileState();
}

class _MobileState extends State<Mobile> {
  final ScrollController _scrollController = ScrollController();

  Color? _color1 = tertiary;
  Color? _color2;
  Color? _color3;
  bool _backgroundColorSelected1 = true;
  bool _backgroundColorSelected2 = false;
  bool _backgroundColorSelected3 = false;

  scrollToPage(double pageNumber) {
    _scrollController.animateTo(
      pageNumber * MediaQuery.of(context).size.height, // Altura de cada página
      duration: const Duration(milliseconds: 500), // Duración de la animación
      curve: Curves.easeInOut, // Curva de la animación
    );
  }

  double currentPage = 0.1;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.watch<ThemeProvider>().isDarkMode;
    double height = Responsive(context: context).getDeviceHeight();
    double width = Responsive(context: context).getDeviceWidth();

    inicioColor() {
      setState(() {
        _backgroundColorSelected1 = true;
        _backgroundColorSelected2 = false;
        _backgroundColorSelected3 = false;
        _color1 = tertiary;
        _color2 = null;
        _color3 = null;
        //print('Inicio seleccionado');
      });
    }

    proyectosColor() {
      setState(() {
        _backgroundColorSelected1 = false;
        _backgroundColorSelected2 = true;
        _backgroundColorSelected3 = false;
        _color1 = null;
        _color2 = tertiary;
        _color3 = null;
        //print('Proyecto seleccionado');
      });
    }

    sobreMiColor() {
      setState(() {
        _backgroundColorSelected1 = false;
        _backgroundColorSelected2 = false;
        _backgroundColorSelected3 = true;
        _color1 = null;
        _color2 = null;
        _color3 = tertiary;
        //print('Proyectos seleccionado');
      });
    }

    //double _currentPage = currentPage;

    _multAumentCurrentPage(increase){
      setState(() {

        if (currentPage > 10) {
          currentPage = currentPage - currentPage;
        } else {
          currentPage = currentPage * increase;
        }

        print(currentPage);
      });
    };

    _SumAumentCurrentPage(increase){
      setState(() {

        if (currentPage > currentPage) {
          currentPage = currentPage;
        } else {
          currentPage = currentPage + increase;
        }

        
        print(currentPage);
      });
    };

    return Scaffold(
        // appBar: Header(height: height, width: width),
        appBar: AppBar(
          toolbarHeight: height / 8,
          elevation: 0,
          title: Container(
            //color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    textAlign: TextAlign.center,
                    'Horizon \n SanTech',
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                        fontSize: width / 25, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  //color: Colors.pink,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: width / 20),
                        child: InkWell(
                            customBorder: CircleBorder(),
                            onTap: () {
                              context.read<ThemeProvider>().toggleTheme();
                            },
                            child: Container(
                                width: width / 9,
                                height: height / 19,
                                child: Icon(
                                    isDarkMode
                                        ? Icons.light_mode
                                        : Icons.dark_mode_outlined,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    size: width / 12))),
                      ),
                      ClipRRect(
                        borderRadius: const BorderRadius.all(
                            Radius.circular(borderRadiusPrimary)),
                        child: Container(
                          padding: EdgeInsets.all(height / 50),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(borderRadiusPrimary),
                              color: Theme.of(context).colorScheme.onPrimary),
                          child: Center(
                              child: Text(
                            'Contacto',
                            style: TextStyle(
                                fontSize: width / 25,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary),
                          )),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: ListView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(
                  decelerationRate: ScrollDecelerationRate.normal),
              children: [
                Column(
                  children: [
                    InitialInformation(width: width, height: height),
                    ProjectBoard(width: width, height: height),
                    AboutMe(width: width, height: height),
                    Skills(width: width, height: height),
                  ],
                ),
              ]),
        ),
        bottomNavigationBar: ClipRRect(
          child: BottomAppBar(
            height: height / 10,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  border: Border(
                      top: BorderSide(
                          width: 0,
                          color: Theme.of(context).colorScheme.onPrimary))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: width * sizedBoxWidth),
                  InkWell(
                      onTap: () {
                        _multAumentCurrentPage(0);
                        scrollToPage(currentPage);
                        inicioColor();
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          color: _color1,
                          padding: EdgeInsets.symmetric(horizontal: width / 50),
                          alignment: Alignment.center,
                          height: height / 20,
                          child: BottomAppBarButtons(
                              width: width,
                              height: height,
                              label: 'Inicio',
                              bgIsSelected: _backgroundColorSelected1),
                        ),
                      )),
                  InkWell(
                      onTap: () {
                        _SumAumentCurrentPage(2);
                       
                        scrollToPage(currentPage);
                        proyectosColor();
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          color: _color2,
                          padding: EdgeInsets.symmetric(horizontal: width / 50),
                          alignment: Alignment.center,
                          height: height / 20,
                          child: BottomAppBarButtons(
                            width: width,
                            height: height,
                            label: 'Proyectos',
                            bgIsSelected: _backgroundColorSelected2,
                          ),
                        ),
                      )),
                  InkWell(
                      onTap: () {
                        _multAumentCurrentPage(2);
                       
                        scrollToPage(currentPage);
                        sobreMiColor();
                      },
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Container(
                            color: _color3,
                            padding:
                                EdgeInsets.symmetric(horizontal: width / 50),
                            alignment: Alignment.center,
                            height: height / 20,
                            child: BottomAppBarButtons(
                              width: width,
                              height: height,
                              label: 'Sobre mi',
                              bgIsSelected: _backgroundColorSelected3,
                            ),
                          ))),
                  SizedBox(width: width * sizedBoxWidth),
                ],
              ),
            ),
          ),
        ));
  }
}


class BottomAppBarButtons extends StatelessWidget {
  const BottomAppBarButtons({
    super.key,
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
              : Theme.of(context).colorScheme.onPrimary),
    );
  }
}
