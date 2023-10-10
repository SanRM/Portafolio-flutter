import 'package:flutter/material.dart';
import 'package:portafolio/styles/styles.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:url_launcher/url_launcher.dart';

class CertificateLabels {
  CertificateLabels({required this.snapshot});

  final AsyncSnapshot<List<dynamic>> snapshot;

  List getLabelsList() {
    var labelList = [];

    for (var i = 0; i < snapshot.data!.length; i++) {
      var labelsInLength = snapshot.data?[i]["labels"].length;
      var specificLabel = snapshot.data?[i]["labels"];

      for (var i = 0; i < labelsInLength; i++) {
        labelList.add(specificLabel[i]);
      }
    }
    return labelList.toSet().toList();
  }
}

class CertificatesFilter {
  CertificatesFilter({required this.snapshot});

  //3. Aqui se guarda la información de los proyectos:
  final AsyncSnapshot<List<dynamic>> snapshot;

  //3. Lista de proyectos filtrados según el botón presionado:
  List<CertificateManager> filtroFinal = [];

  List<CertificateManager> getSimilitudes(labelToCompare) {
    //print("Boton presionado: $labelToCompare");

    var listaProyectos = snapshot.data!.length;

    for (var i = 0; i < listaProyectos; i++) {
      //print(snapshot.data?[i]["projectLabels"]);
      //print('');
      var certificateDescription = snapshot.data?[i]["description"];
      var certificateLabels = snapshot.data?[i]["labels"];
      var certificateTitle = snapshot.data?[i]["title"];
      var certificateUrl = snapshot.data?[i]["Url"];

      //print('');

      for (var i = 0; i < certificateLabels.length; i++) {
        //print(labels[i]);
        //print('');

        if (certificateLabels[i] == labelToCompare) {
          filtroFinal.add(
            CertificateManager(
                snapshot: snapshot,
                description: certificateDescription,
                labels: certificateLabels,
                title: certificateTitle,
                url: certificateUrl),
          );
          //print("Hay coincidencias en los proyectos: ${certificateLabels[i]}");
          // print('');
          //print(projectTitle);
        }
      }
    }

    //print(filtroFinal);
    return filtroFinal;
  }
}

class CertificateManager extends StatefulWidget {
  final AsyncSnapshot<List<dynamic>> snapshot;
  final dynamic description;
  final dynamic labels;
  final dynamic title;
  final dynamic url;

  const CertificateManager(
      {super.key,
      required this.snapshot,
      required this.description,
      required this.labels,
      required this.title,
      required this.url});

  @override
  // ignore: no_logic_in_create_state
  State<CertificateManager> createState() => _CertificateManagerState(
      snapshot: snapshot,
      description: description,
      labels: labels,
      title: title,
      url: url);
}

class _CertificateManagerState extends State<CertificateManager> {
  _CertificateManagerState(
      {required this.snapshot,
      required this.description,
      required this.labels,
      required this.title,
      required this.url});

  final AsyncSnapshot<List<dynamic>> snapshot;
  final dynamic description;
  final dynamic labels;
  final dynamic title;
  final dynamic url;

  Color certificateColor = Color.fromARGB(255, 8, 8, 8);
  bool certificateIsHover = false;

  hoverColor(value) {
    setState(
      () {
        certificateIsHover = value;

        if (value == true) {
          certificateColor = Color.fromARGB(255, 126, 236, 255);
        } else {
          certificateColor = Color.fromARGB(255, 8, 8, 8);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.width;

    return InkWell(
      onHover: (value) {
        hoverColor(value);
      },
      onTap: () async {
        final Uri urlToLaunch = Uri.parse(url);

        if (!await launchUrl(urlToLaunch,
            mode: LaunchMode.externalApplication)) {
          throw Exception('No se pudo cargar $urlToLaunch');
        }
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          var containerWidth = constraints.maxWidth;

          return Directionality(
            textDirection: TextDirection.ltr,
            child: Container(
              width: containerWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: certificateColor,
                    blurRadius: certificateIsHover == true ? 0 : 5,
                    offset: Offset(7, 7), // Shadow position
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadiusSecondary),
                child: Container(
                  color: const Color.fromARGB(255, 243, 243, 243),
                  child: Stack(children: [
                    // //2. badge
                    // Positioned(
                    //   right: 1,
                    //   child: Icon(
                    //     Icons.verified,
                    //     color: Color.fromARGB(55, 0, 217, 255),
                    //     size: width / 5,
                    //   ),
                    // ),

                    Column(
                      children: [
                        //Text(url),

                        //2. Certificate title
                        Container(
                          padding: EdgeInsets.only(
                              left: width / 20,
                              right: width / 20,
                              top: height / 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  '$title',
                                  style: TextStyle(
                                      fontFamily: principalFontFamily,
                                      fontWeight: FontWeight.bold,
                                      fontSize: width / 15,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                ),
                              ),
                              Icon(
                                Icons.verified,
                                color: Color.fromARGB(255, 37, 212, 224),
                                size: width / 5,
                              ),
                            ],
                          ),
                        ),

                        //2. Certificate description
                        Container(
                          //color: const Color.fromARGB(255, 7, 255, 40),
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(
                              left: width / 20,
                              right: width / 20,
                              top: height / 50,
                              bottom: height / 50),
                          child: Text(
                            '$description',
                            style: TextStyle(
                                fontFamily: principalFontFamily,
                                fontSize: width / 20,
                                color: primaryBlack),
                          ),
                        ),

                        //2. Certificate labels
                        Container(
                          //color: const Color.fromARGB(255, 7, 143, 255),
                          width: width / 1,
                          padding: EdgeInsets.only(
                            left: width / 20,
                            right: width / 20,
                            bottom: height / 20,
                          ),
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            spacing: width / 30,
                            runSpacing: height / 50,
                            children: List.generate(
                              labels.length,
                              (index) {
                                var project = labels[index];
                                return Chip(
                                  backgroundColor:
                                      const Color.fromARGB(255, 243, 243, 243),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        borderRadiusPrimary),
                                    side: const BorderSide(
                                        width: 1.5,
                                        strokeAlign: 2,
                                        color: primaryBlack),
                                  ),
                                  label: Text(
                                    project,
                                    style: TextStyle(
                                        fontFamily: principalFontFamily,
                                        color: primaryBlack,
                                        fontSize: width / 30),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}