// ignore_for_file: depend_on_referenced_packages, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:portafolio/styles/themes/styles.dart';
import 'package:portafolio/main.dart';
import 'package:provider/provider.dart';

class Header extends StatefulWidget implements PreferredSizeWidget {
  final double height;
  final double width;

  const Header({super.key, required this.height, required this.width});

  @override
  State<Header> createState() => _HeaderState(height, width);

  @override
  Size get preferredSize => Size(width, height);
}

class _HeaderState extends State<Header> {
  final double height;
  final double width;

  _HeaderState(this.height, this.width);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.watch<ThemeProvider>().isDarkMode;

    return Container(
        padding: paddingSymmetricTop,
        height: height / heightDivisorAppBar,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer),
        //color: Colors.red),
        child:
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          TituloMarca(width: width),
          SizedBox(width: width * appbarSpacing),
          ThemeModeButton(width: width, height: height, isDarkMode: isDarkMode),
          ContactButton(
            width: width,
            height: height,
          )
        ]),
      )
    ;
  }
}

class ThemeModeButton extends StatelessWidget {
  const ThemeModeButton({
    super.key,
    required this.width,
    required this.height,
    required this.isDarkMode,
  });

  final double width;
  final double height;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          context.read<ThemeProvider>().toggleTheme();
        },
        customBorder: const CircleBorder(),
        child: Container(
            width: width / 9,
            height: height / 19,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
            child: Icon(
                isDarkMode ? Icons.light_mode : Icons.dark_mode_outlined,
                color: Theme.of(context).colorScheme.onPrimary,
                size: width / 12)
              )
            );
  }
}

class TituloMarca extends StatelessWidget {
  const TituloMarca({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width / 4,
      //color: const Color.fromARGB(255, 7, 123, 255),
      child: Text(
        'Horizon SanTech',
        style: TextStyle(
            fontSize: width / 20,
            color: Theme.of(context).colorScheme.onPrimary),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class ContactButton extends StatelessWidget {
  const ContactButton({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          const BorderRadius.all(Radius.circular(borderRadiusPrimary)),
      child: Container(
        width: width / 3.5,
        height: height / 20,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadiusPrimary),
            color: Theme.of(context).colorScheme.onPrimary),
        child: Center(
            child: Text(
          'Contacto',
          style: TextStyle(fontSize: width / 25, color: Theme.of(context).colorScheme.primary),
        )),
      ),
    );
  }
}
