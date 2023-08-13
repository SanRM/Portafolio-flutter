// ignore: file_names

import 'package:flutter/material.dart';
import 'package:portafolio/styles/themes/styles.dart';
// ignore: depend_on_referenced_packages
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:url_launcher/url_launcher.dart';

class InitialInformation extends StatelessWidget {
  final double width;
  final double height;

  const InitialInformation({
    required this.width,
    required this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: paddingSymetricMiddle,
            child: Container(
              padding: paddingSymetricMiddle,
              width: width,
              height: height / 4,
              //color: Colors.red,
              child: Image.asset('assets/images/PrincipaImage.png'),
            )),
        Padding(
          padding: paddingSymetricMiddle,
          child: Container(
              alignment: Alignment.center,
              width: width,
              height: height / 14,
              //color: const Color.fromARGB(255, 54, 244, 139),
              child: Text('PORTAFOLIO',
                  style: TextStyle(
                      fontSize: width / 15,
                      letterSpacing: 6,
                      color: Theme.of(context).colorScheme.onPrimary))),
        ),
        Padding(
          padding: paddingSymetricMiddle,
          child: Container(
            width: width,
            height: height / 150,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        Padding(
          padding: paddingSymetricMiddle,
          child: Container(
              //color: Colors.amber,
              padding: paddingAll,
              alignment: Alignment.center,
              //color: Color.fromARGB(255, 54, 105, 244),
              child: GradientText(
                'Santiago Rodriguez Morales',
                textAlign: TextAlign.center,
                colors: const [
                  Colors.white,
                  Color.fromARGB(255, 24, 194, 216),
                  Color.fromARGB(255, 23, 164, 207),
                  Color.fromARGB(255, 24, 194, 216),
                  Color.fromARGB(255, 23, 164, 207),
                  Color.fromARGB(255, 24, 194, 216),
                  Colors.white
                ],
                style: TextStyle(
                    fontSize: width / 9,
                    color: Theme.of(context).colorScheme.secondary),
              )),
        ),
        Padding(
          padding: paddingSymetricMiddle,
          child: Container(
              alignment: Alignment.center,
              height: height / 20,
              //color: Color.fromARGB(255, 255, 121, 255),
              child: Text(
                'Desarrollador de software',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: width / 18,
                    color: Theme.of(context).colorScheme.onPrimary),
              )),
        ),
        Padding(
          padding: paddingSymetricMiddle,
          child: SizedBox(
            width: width / 1.5,
            height: height / 5.5,
            //color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ClipRRect(
                  child: InkWell(
                    onTap: () async {
                      final Uri url = Uri.parse('https://github.com/SanRM');

                      if (!await launchUrl(url)) {
                        throw Exception('No se pudo cargar $url');
                      }
                    },
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      width: width / 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromRGBO(47, 59, 82, 1),
                      ),
                      child: Image.asset('assets/images/github-mark-white.png',
                          scale: width / 70),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: InkWell(
                    onTap: () async {
                      final Uri url = Uri.parse(
                          'https://www.linkedin.com/in/santiagorodriguezmorales');

                      if (!await launchUrl(url)) {
                        throw Exception('No se pudo cargar $url');
                      }
                    },
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      width: width / 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromRGBO(1, 120, 180, 1),
                      ),
                      child: Image.asset('assets/images/linkedin.png',
                          scale: width / 40),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
