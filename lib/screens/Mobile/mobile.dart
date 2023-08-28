import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portafolio/Responsive/responsive.dart';
import 'package:portafolio/styles/styles.dart';
import 'package:portafolio/screens/Mobile/widgets/initial_information.dart';
import 'package:portafolio/screens/Mobile/widgets/project_board.dart';
import 'package:portafolio/screens/Mobile/widgets/about_me.dart';
import 'package:portafolio/screens/Mobile/widgets/SendMessagePage.dart';
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

  buttonSelected(buttonName) {
    setState(() {
      switch (buttonName) {
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
      }
    });
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

  Container buildAppBarTitle() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildAppName(),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildDarkModeToggle(),
                buildContactButton(),
              ],
            ),
          ),
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
        color: Theme.of(context).colorScheme.onPrimary,
        fontFamily: principalFontFamily,
        fontSize: Responsive(context: context).getDeviceWidth() / 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildDarkModeToggle() {
    bool isDarkMode = context.watch<ThemeProvider>().isDarkMode;

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
      ),
    );
  }

  InkWell buildContactButton() {
    return InkWell(
      customBorder: CircleBorder(),
      onTap: () {
        Scrollable.ensureVisible(globalKeySendMessagePage.currentContext!, duration: Duration(seconds: 1), curve: Curves.easeInOutCubicEmphasized);
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
                InitialInformation(width: width, height: height),
                ProjectBoard(width: width, height: height),
                AboutMe(width: width, height: height),
                SendMessagePage(height: height, width: width),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        height: Responsive(context: context).getDeviceHeight() / 10,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: Responsive(context: context).getDeviceWidth() *
                      sizedBoxWidth),
              buildBottomAppBarButton(
                label: 'Inicio',
                onPressed: () {
                  Scrollable.ensureVisible(globalKeyInitialInformation.currentContext!, duration: Duration(seconds: 1), curve: Curves.easeInOutCubicEmphasized);
                  buttonSelected('Inicio');
                },
                isSelected: _backgroundColorSelected1,
              ),
              buildBottomAppBarButton(
                label: 'Proyectos',
                onPressed: () {
                  Scrollable.ensureVisible(globalKeyProjectBoard.currentContext!, duration: Duration(seconds: 1), curve: Curves.easeInOutCubicEmphasized);
                  buttonSelected('Proyectos');
                },
                isSelected: _backgroundColorSelected2,
              ),
              buildBottomAppBarButton(
                label: 'Sobre mi',
                onPressed: () {
                  Scrollable.ensureVisible(globalKeyAboutMe.currentContext!, duration: Duration(seconds: 1), curve: Curves.easeInOutCubicEmphasized);
                  buttonSelected('Sobre mi');
                },
                isSelected: _backgroundColorSelected3,
              ),
              SizedBox(
                  width: Responsive(context: context).getDeviceWidth() *
                      sizedBoxWidth)
            ],
          ),
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
      splashColor: Color.fromARGB(66, 255, 255, 255),
      highlightColor: Color.fromARGB(66, 255, 255, 255),
      borderRadius: BorderRadius.circular(100),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          color: isSelected ? tertiary : null,
          padding: EdgeInsets.symmetric(
              horizontal: Responsive(context: context).getDeviceWidth() / 50),
          alignment: Alignment.center,
          height: Responsive(context: context).getDeviceHeight() / 20,
          child: Text(
            label,
            style: TextStyle(
              fontSize: Responsive(context: context).getDeviceWidth() / 20,
              color: isSelected
                  ? primaryBlack
                  : Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
