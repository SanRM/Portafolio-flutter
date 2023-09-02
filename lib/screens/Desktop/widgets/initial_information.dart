// ignore: file_names

import 'package:flutter/material.dart';
import 'package:portafolio/styles/styles.dart';
// ignore: depend_on_referenced_packages
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:url_launcher/url_launcher.dart';

GlobalKey globalKeyInitialInformation = GlobalKey(); 

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
    return Container(
      key: globalKeyInitialInformation,
      //padding: EdgeInsets.only(top: height/10),
      //color: Colors.red,
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            //color: Colors.pink,
            width: width / 2.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  //color: const Color.fromARGB(255, 33, 243, 215),
                  alignment: Alignment.center,
                  height: height / 10,
                  child: SelectableText(
                    'PORTAFOLIO',
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontFamily: principalFontFamily,
                      fontSize: height / 15,
                      letterSpacing: 13,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
                Container(
                  //color: Colors.amber,
                  padding: paddingAll,
                  alignment: Alignment.center,
                  //color: Color.fromARGB(255, 54, 105, 244),
                  child: GradientText(
                    'Santiago Rodriguez Morales',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    colors: principalDegradee,
                    style: TextStyle(
                        //overflow: TextOverflow.ellipsis,
                        fontFamily: principalFontFamily,
                        fontSize: height / 15,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: height / 10,
                  //color: Color.fromARGB(255, 255, 121, 255),
                  child: SelectableText(
                    'Desarrollador de software',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: principalFontFamily,
                        fontSize: height / 25,
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
                Container(
                  //color: Colors.blue,
                  width: width / 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipRRect(
                        child: InkWell(
                          onTap: () async {
                            final Uri url =
                                Uri.parse('https://github.com/SanRM');

                            if (!await launchUrl(url)) {
                              throw Exception('No se pudo cargar $url');
                            }
                          },
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            padding: EdgeInsets.all(25),
                            width: width / 12,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color.fromRGBO(47, 59, 82, 1),
                            ),
                            child: Image.asset(
                                'assets/images/github-mark-white.png',
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
                            padding: EdgeInsets.all(25),
                            width: width / 12,
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
          ),
          Container(
            margin: EdgeInsets.all(15),
            height: height / 1.7,
            width: width / 3,
            //color: Color.fromARGB(255, 54, 216, 244),
            child: Image.asset('assets/images/PrincipaImage.png'),
          ),
        ],
      ),
    );
  }
}
