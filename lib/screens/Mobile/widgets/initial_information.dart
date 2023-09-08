// ignore: file_names

import 'package:flutter/material.dart';
import 'package:portafolio/styles/styles.dart';
// ignore: depend_on_referenced_packages
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:url_launcher/url_launcher.dart';

GlobalKey globalKeyInitialInformation = GlobalKey(); 

class InitialInformation extends StatefulWidget {
  final double width;
  final double height;

  const InitialInformation({
    required this.width,
    required this.height,
    super.key,
  });

  @override
  State<InitialInformation> createState() => InitialInformationState();
}

class InitialInformationState extends State<InitialInformation> {

  @override
  Widget build(BuildContext context) {

    return Container(
      key: globalKeyInitialInformation,
      //color: Colors.red,
      child: Column(
        children: [
          Padding(
            padding: paddingSymetricMiddle,
            child: Container(
              padding: paddingSymetricMiddle,
              width: widget.width,
              height: widget.height / 4,
              //color: Colors.red,
              child: Image.asset('assets/images/PrincipaImage.png'),
            ),
          ),
          Padding(
            padding: paddingSymetricMiddle,
            child: Container(
                alignment: Alignment.center,
                width: widget.width,
                height: widget.height / 14,
                //color: const Color.fromARGB(255, 54, 244, 139),
                child: Text('PORTAFOLIO',
                    style: TextStyle(
                        fontFamily: principalFontFamily,
                        fontSize: widget.width / 15,
                        letterSpacing: 6,
                        color: Theme.of(context).colorScheme.onPrimary))),
          ),
          Padding(
            padding: paddingSymetricMiddle,
            child: Container(
              width: widget.width,
              height: widget.height / 150,
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
                colors: principalDegradee,
                style: TextStyle(
                    fontFamily: principalFontFamily,
                    fontSize: widget.width / 9,
                    color: Theme.of(context).colorScheme.secondary),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            //color: Color.fromARGB(255, 255, 121, 255),
            child: Text(
              'Desarrollador de software',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: principalFontFamily,
                  fontSize: widget.width / 18,
                  color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: widget.height / 20, top: widget.height / 40),
            //color: Colors.blue,
            width: widget.width / 1.5,
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
                      padding: EdgeInsets.all(20),
                      width: widget.width / 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromRGBO(47, 59, 82, 1),
                      ),
                      child: Image.asset('assets/images/github-mark-white.png',
                          fit: BoxFit.cover),
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
                      padding: EdgeInsets.all(20),
                      width: widget.width / 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromRGBO(1, 120, 180, 1),
                      ),
                      child: Image.asset('assets/images/linkedin.png',
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
