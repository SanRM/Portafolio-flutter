// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portafolio/Responsive/responsive.dart';
import 'package:portafolio/screens/Mobile/widgets/certificate_board.dart';
import 'package:portafolio/services/firebase_service.dart';
import 'package:portafolio/styles/styles.dart';
import 'package:portafolio/screens/Mobile/widgets/initial_information.dart';
import 'package:portafolio/screens/Mobile/widgets/project_board.dart';
import 'package:portafolio/screens/Mobile/widgets/about_me.dart';
import 'package:portafolio/screens/Mobile/widgets/send_message_page.dart';
import 'package:provider/provider.dart';
import 'package:portafolio/main.dart';

class Mobile extends StatefulWidget {
  const Mobile({super.key});

  @override
  State<Mobile> createState() => MobileState();
}

class MobileState extends State<Mobile> {
  final ScrollController _scrollController = ScrollController();

  bool _backgroundColorSelected1 = true;
  bool _backgroundColorSelected2 = false;
  bool _backgroundColorSelected3 = false;
  bool _backgroundColorSelected4 = false;

  scrollTo(widget) {
    Scrollable.ensureVisible(
      widget.currentContext!,
      duration: const Duration(
        seconds: 1,
      ),
      curve: Curves.easeInOutCubicEmphasized,
    );
  }

  buttonSelected(buttonName) {
    setState(
      () {
        switch (buttonName) {
          case 'Inicio':
            _backgroundColorSelected1 = true;
            _backgroundColorSelected2 = false;
            _backgroundColorSelected3 = false;
            _backgroundColorSelected4 = false;
            break;

          case 'Proyectos':
            _backgroundColorSelected1 = false;
            _backgroundColorSelected2 = true;
            _backgroundColorSelected3 = false;
            _backgroundColorSelected4 = false;
            break;

          case 'Sobre mi':
            _backgroundColorSelected1 = false;
            _backgroundColorSelected2 = false;
            _backgroundColorSelected4 = false;
            _backgroundColorSelected3 = true;
            break;

          case 'Certificados':
            _backgroundColorSelected1 = false;
            _backgroundColorSelected2 = false;
            _backgroundColorSelected4 = true;
            _backgroundColorSelected3 = false;
            break;
        }
      },
    );
  }

  AppBar buildAppBar() {
    bool isDarkMode = context.watch<ThemeProvider>().isDarkMode;
    return AppBar(
      systemOverlayStyle:
          isDarkMode ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      backgroundColor: Colors.transparent,
      toolbarHeight: Responsive(context: context).getDeviceHeight() / 10,
      elevation: 0,
      title: buildAppBarTitle(),
    );
  }

  Row buildAppBarTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildAppName(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildDarkModeToggle(),
            buildContactButton(),
          ],
        ),
      ],
    );
  }

  Text buildAppName() {
    return Text(
      'Horizon \n SanTech',
      textAlign: TextAlign.center,
      overflow: TextOverflow.visible,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onPrimary,
        fontFamily: principalFontFamily,
        fontSize: Responsive(context: context).getDeviceWidth() / 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildDarkModeToggle() {
    bool isDarkMode = context.watch<ThemeProvider>().isDarkMode;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Tooltip(
          message:
              isDarkMode ? 'Cambiar a modo claro' : 'Cambiar a modo oscuro',
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 7, 196, 230),
              Color.fromARGB(255, 63, 158, 236),
            ]),
          ),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () {
              context.read<ThemeProvider>().toggleTheme();
            },
            child: SizedBox(
              width: Responsive(context: context).getDeviceWidth() / 6,
              height: Responsive(context: context).getDeviceHeight() / 19,
              child: Icon(
                isDarkMode ? Icons.light_mode : Icons.dark_mode_outlined,
                color: Theme.of(context).colorScheme.onPrimary,
                size: Responsive(context: context).getDeviceWidth() / 12,
              ),
            ),
          ),
        ),
      ],
    );
  }

  InkWell buildContactButton() {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: () {
        scrollTo(globalKeySendMessagePage);
      },
      child: Container(
        padding:
            EdgeInsets.all(Responsive(context: context).getDeviceHeight() / 50),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadiusPrimary),
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        child: Center(
          child: Text(
            'Contacto',
            style: TextStyle(
              fontFamily: principalFontFamily,
              fontSize: Responsive(context: context).getDeviceWidth() / 25,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = Responsive(context: context).getDeviceWidth();
    double height = Responsive(context: context).getDeviceHeight();

    return Scaffold(
      appBar: buildAppBar(),
      body: SafeArea(
        child: ListView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(
            decelerationRate: ScrollDecelerationRate.normal,
          ),
          children: [
            Column(
              children: [
                InitialInformation(
                  width: width,
                  height: height,
                ),
                FutureBuilder(
                  future: getSection("Lista de proyectos"),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ProjectBoard(
                        snapshot: snapshot,
                        width: width,
                        height: height,
                      );
                    } else {
                      return Padding(
                        padding: EdgeInsets.only(bottom: height / 20),
                        child: SizedBox(
                          width: width / 100,
                          height: height / 65,
                          child: const CircularProgressIndicator(
                            strokeWidth: 3,
                            color: Color.fromARGB(137, 0, 141, 151),
                          ),
                        ),
                      );
                    }
                  },
                ),
                AboutMe(
                  width: width,
                  height: height,
                ),
                FutureBuilder(
                  future: getSection("Certificados"),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      //print(snapshot.data);
                      return CertificatesBoard(
                          snapshot: snapshot, width: width, height: height);
                    } else {
                      return Padding(
                        padding: EdgeInsets.only(
                            top: height / 20, bottom: height / 20),
                        child: CircularProgressIndicator(
                          color:
                              Theme.of(context).colorScheme.onTertiaryContainer,
                        ),
                      );
                    }
                  },
                ),
                SendMessagePage(height: height, width: width),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        height: Responsive(context: context).getDeviceHeight() / 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width:
                  Responsive(context: context).getDeviceWidth() * sizedBoxWidth,
            ),
            buildBottomAppBarButton(
              label: 'Inicio',
              iconSelected: Icons.home_filled,
              onPressed: () {
                buttonSelected('Inicio');
                scrollTo(globalKeyInitialInformation);
              },
              isSelected: _backgroundColorSelected1,
            ),
            buildBottomAppBarButton(
              label: 'Proyectos',
              iconSelected: Icons.handyman_rounded,
              onPressed: () {
                buttonSelected('Proyectos');
                scrollTo(globalKeyProjectBoard);
              },
              isSelected: _backgroundColorSelected2,
            ),
            buildBottomAppBarButton(
              label: 'Sobre mi',
              iconSelected: Icons.person,
              onPressed: () {
                buttonSelected('Sobre mi');
                scrollTo(globalKeyAboutMe);
              },
              isSelected: _backgroundColorSelected3,
            ),
            buildBottomAppBarButton(
              label: 'Certificados',
              iconSelected: Icons.verified,
              onPressed: () {
                buttonSelected('Certificados');
                scrollTo(globalKeyCertificatesBoard);
              },
              isSelected: _backgroundColorSelected4,
            ),
            SizedBox(
                width: Responsive(context: context).getDeviceWidth() *
                    sizedBoxWidth)
          ],
        ),
      ),
    );
  }

  InkWell buildBottomAppBarButton({
    required IconData iconSelected,
    required String label,
    required VoidCallback onPressed,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: onPressed,
      splashColor: const Color.fromARGB(66, 255, 255, 255),
      highlightColor: const Color.fromARGB(66, 255, 255, 255),
      borderRadius: BorderRadius.circular(100),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          color: isSelected ? tertiary : null,
          padding: EdgeInsets.symmetric(
              horizontal: Responsive(context: context).getDeviceWidth() / 50),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconSelected,
                size: 20,
                color: isSelected
                    ? primaryBlack
                    : Theme.of(context).colorScheme.onPrimary,
              ),
              Text(
                label,
                style: TextStyle(
                  fontFamily: principalFontFamily,
                  fontSize: Responsive(context: context).getDeviceWidth() / 25,
                  color: isSelected
                      ? primaryBlack
                      : Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
