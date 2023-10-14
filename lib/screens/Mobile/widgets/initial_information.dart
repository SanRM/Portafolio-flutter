// ignore: file_names

import 'package:flutter/material.dart';
import 'package:portafolio/services/firebase_service.dart';
import 'package:portafolio/services/pdf_service.dart';
import 'package:portafolio/styles/styles.dart';
// ignore: depend_on_referenced_packages
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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

    return SizedBox(
      key: globalKeyInitialInformation,
      height: widget.height - (widget.height / 5),
      //color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            alignment: Alignment.center,
            //color: Color.fromARGB(255, 255, 121, 255),
            //height: widget.height / 20,
            child: Text(
              'PORTAFOLIO',
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  letterSpacing: 3,
                  fontFamily: principalFontFamily,
                  fontSize: widget.width / 15,
                  color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
          SizedBox(
            //margin: const EdgeInsets.all(15),
            height: widget.height / 4,
            width: widget.width,
            //color: Color.fromARGB(255, 54, 216, 244),
            child: FutureBuilder(
              future: getSection("Información inicial"),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  String principalBanner = snapshot.data?[0]['principalBanner'];

                  return Image.network(principalBanner);
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.onTertiaryContainer,
                    ),
                  );
                }
              },
            ),
          ),
          Container(
            //color: Colors.amber,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            alignment: Alignment.center,
            //height: widget.height / 6,
            child: GradientText(
              'Santiago Rodriguez Morales',
              textAlign: TextAlign.center,
              maxLines: 2,
              colors: principalDegradee,
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontFamily: principalFontFamily,
                  fontSize: widget.height / 25,
                  color: Theme.of(context).colorScheme.secondary),
            ),
          ),
          Container(
            alignment: Alignment.center,
            //color: Color.fromARGB(255, 255, 121, 255),
            height: widget.height / 15,
            child: Text(
              'Desarrollador de software',
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontFamily: principalFontFamily,
                  fontSize: widget.width / 15,
                  color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: widget.width / 6,
              right: widget.width / 6,
            ),
            child: FilledButton.icon(
              style: const ButtonStyle(
                //side: MaterialStatePropertyAll(BorderSide(width: 1, color: Color.fromARGB(255, 44, 187, 192))),
                backgroundColor: MaterialStatePropertyAll(
                  Color.fromARGB(255, 32, 231, 238),
                ),
              ),
              onPressed: () async {
                if (kIsWeb) {
                  PDF().createPDF(saveMethod: 'web');
                } else {
                  PDF().createPDF(saveMethod: 'mobile');
                }
              },
              icon:
                  const Icon(Icons.file_download_outlined, color: primaryBlack),
              label: Container(
                padding: EdgeInsets.all(widget.height / 100),
                alignment: Alignment.center,
                child: Text(
                  'Descargar hoja de vida',
                  style: TextStyle(
                      fontFamily: principalFontFamily,
                      color: primaryBlack,
                      fontWeight: FontWeight.bold,
                      fontSize: widget.height / 55),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                bottom: widget.height / 40, top: widget.height / 40),
            //color: Colors.blue,
            height: widget.height / 5.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  //color: Colors.red,
                  width: widget.width / 200,
                ),
                ClipRRect(
                  child: InkWell(
                    onTap: () async {
                      final Uri url = Uri.parse('https://www.github.com/SanRM');

                      if (!await launchUrl(url,
                          mode: LaunchMode.externalApplication)) {
                        throw Exception('No se pudo cargar $url');
                      }
                    },
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: const Color.fromRGBO(47, 59, 82, 1),
                      ),
                      child: Image.asset('assets/images/github-mark-white.png',
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: InkWell(
                    onTap: () async {
                      final Uri url = Uri.parse(
                          'https://www.linkedin.com/in/santiagorodriguezmorales');

                      if (!await launchUrl(url,
                          mode: LaunchMode.externalApplication)) {
                        throw Exception('No se pudo cargar $url');
                      }
                    },
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromRGBO(1, 120, 180, 1),
                      ),
                      child: Image.asset('assets/images/linkedin.png',
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                Container(
                  //color: Colors.red,
                  width: widget.width / 200,
                ),
              ],
            ),
          ),
          Container(
            //color: Colors.red,
            height: widget.height / 200,
          )
        ],
      ),
    );
  }
}
