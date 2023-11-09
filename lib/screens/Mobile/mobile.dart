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
  int selectedIndex = 0;

  scrollTo(widget) {
    Scrollable.ensureVisible(
      widget.currentContext!,
      duration: const Duration(
        seconds: 1,
      ),
      curve: Curves.easeInOutCubicEmphasized,
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).colorScheme.primary,
          selectedFontSize: 15,
          unselectedFontSize: 12,
          iconSize: 30,
          currentIndex: selectedIndex,
          elevation: 0,
          unselectedItemColor: Theme.of(context).colorScheme.onPrimary,
          selectedItemColor: Theme.of(context).colorScheme.onSurface,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.handyman_rounded),
              label: 'Proyectos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Sobre mi',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.verified),
              label: 'Certificados',
            ),
          ],
          onTap: (int newIndex) {
            setState(
              () {
                selectedIndex = newIndex;
              },
            );
            switch (selectedIndex) {
              case 0:
                scrollTo(globalKeyInitialInformation);
                break;
              case 1:
                scrollTo(globalKeyProjectBoard);
                break;
              case 2:
                scrollTo(globalKeyAboutMe);
                break;
              case 3:
                scrollTo(globalKeyCertificatesBoard);
                break;
            }
          },
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
