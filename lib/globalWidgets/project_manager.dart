import 'package:flutter/material.dart';
import 'package:portafolio/styles/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectFilter {
  ProjectFilter({required this.projects});

  List<ProjectManager> projects = [];
  List<ProjectManager> filtroFinal = [];

  List<ProjectManager> getSimilitudes(labelToCompare) {
    for (var i = 0; i < projects.length; i++) {
      List<String> labels = projects[i].projectLabels;
      var labelsFilter = labels.where((element) {
        return element == labelToCompare;
      }).toList();

      //print('labels: $labels,     labelsFilter: $labelsFilter');

      if (labelsFilter.isEmpty == false) {
        if (labelsFilter[0] == labelToCompare) {
          //print('Hay etiquetas iguales en el proyecto $i');
          print(labelsFilter);

          filtroFinal.add(projects[i]);

          //i = projects.length + 1;
        }
      } else if (labelsFilter.isEmpty == true) {
        //print('No hay etiquetas iguales en el proyecto $i');
      }
    }

    //print('Filtro final: $filtroFinal');
    return filtroFinal;
  }
}

class ProjectManager extends StatefulWidget {
  final Color cardBgColor;
  final String projectTitle;
  final String projectBanner;
  final String projectLink;
  final List<String> projectLabels;
  final String projectDescription;

  const ProjectManager({
    super.key,
    required this.cardBgColor,
    required this.projectTitle,
    required this.projectBanner,
    required this.projectDescription,
    required this.projectLabels,
    required this.projectLink,
  });

  @override
  // ignore: no_logic_in_create_state
  State<ProjectManager> createState() => _ProjectManagerState(
      cardBgColor: cardBgColor,
      projectTitle: projectTitle,
      projectBanner: projectBanner,
      projectLink: projectLink,
      projectDescription: projectDescription,
      projectLabels: projectLabels);
}

class _ProjectManagerState extends State<ProjectManager> {
  _ProjectManagerState({
    required this.cardBgColor,
    required this.projectTitle,
    required this.projectBanner,
    required this.projectDescription,
    required this.projectLabels,
    required this.projectLink,
  });

  final Color cardBgColor;
  final String projectTitle;
  final String projectBanner;
  final String projectDescription;
  final String projectLink;
  final List<String> projectLabels;

  bool? _onPress;

  _onPressAnimation() {
    setState(() {
      _onPress == true ? _onPress = false : _onPress = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(
          left: width / 20, right: width / 20, bottom: height / 20),
      child: InkWell(
        onTap: () {
          _onPressAnimation();
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(255, 8, 8, 8),
                  blurRadius: 5,
                  offset: Offset(2, 2), // Shadow position
                ),
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadiusSecondary),
            child: Container(
              color: const Color.fromARGB(255, 243, 243, 243),
              child: Column(
                children: [
                  AnimatedCrossFade(
                    crossFadeState: _onPress == true
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    sizeCurve: Curves.bounceInOut,
                    duration: const Duration(milliseconds: 50),

                    //10. First Child

                    firstChild: Column(
                      children: [
                        //2. Project banner
                        Container(
                            width: width,
                            height: height / 3,
                            color: cardBgColor,
                            child: projectBanner.isEmpty
                                ? Image.asset(
                                    'assets/illustraciones/Mataura.png',
                                    fit: BoxFit.cover)
                                : Image.asset(projectBanner,
                                    fit: BoxFit.cover)),
                        //2. Project title
                        Container(
                          decoration: const BoxDecoration(
                              border: Border(
                            top: BorderSide(
                                width: 0.5,
                                color: Color.fromARGB(255, 121, 121, 121)),
                          )),
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(
                              horizontal: width / 20, vertical: height / 50),
                          child: Text(projectTitle,
                              style: TextStyle(
                                  fontFamily: principalFontFamily,
                                  fontSize: width / 20,
                                  color:
                                      Theme.of(context).colorScheme.secondary)),
                        ),
                      ],
                    ),
                    secondChild: Column(
                      children: [
                        //2. Project banner
                        Container(
                            width: width,
                            height: height / 3,
                            color: cardBgColor,
                            child: projectBanner.isEmpty
                                ? Image.asset(
                                    'assets/illustraciones/Mataura.png',
                                    fit: BoxFit.cover)
                                : Image.asset(projectBanner,
                                    fit: BoxFit.cover)),

                        //2. Project title
                        Container(
                          decoration: const BoxDecoration(
                              border: Border(
                            top: BorderSide(
                                width: 0.5,
                                color: Color.fromARGB(255, 121, 121, 121)),
                          )),
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(
                              left: width / 20,
                              right: width / 20,
                              top: height / 20),
                          child: Text(projectTitle,
                              style: TextStyle(
                                fontFamily: principalFontFamily,
                                fontWeight: FontWeight.bold,
                                  fontSize: width / 15,
                                  color:
                                      Theme.of(context).colorScheme.secondary)),
                        ),

                        //2. Project description
                        Container(
                          //color: const Color.fromARGB(255, 7, 255, 40),
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(
                              left: width / 20,
                              right: width / 20,
                              top: height / 100,
                              bottom: height / 100),
                          child: Text(projectDescription,
                              style: TextStyle(
                                  fontFamily: principalFontFamily,
                                  fontSize: width / 25,
                                  color: projectBoardDescription)),
                        ),

                        //2. Project labels
                        Container(
                          //color: const Color.fromARGB(255, 7, 143, 255),
                          width: width / 1,
                          padding: EdgeInsets.only(
                            left: width / 20,
                            right: width / 20,
                            top: height / 50,
                            bottom: height / 20,
                          ),
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            spacing: width / 40,
                            runSpacing: height / 30,
                            children: List.generate(
                              projectLabels.length,
                              (index) {
                                var project = projectLabels[
                                    index]; // Cambiado projectLabels[1] a projectLabels[index]
                                return Chip(
                                    backgroundColor: const Color.fromARGB(
                                        255, 243, 243, 243),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          borderRadiusPrimary),
                                      side: const BorderSide(
                                          strokeAlign: 2, color: labelOutline),
                                    ),
                                    label: Text(
                                      project,
                                      style: TextStyle(
                                          fontFamily: principalFontFamily,
                                          color: labelTextColor,
                                          fontSize: width / 30),
                                    ));
                              },
                            ),
                          ),
                        ),

                        //2. Project link button
                        InkWell(
                          onTap: () async {
                            final Uri url = Uri.parse(projectLink);

                            if (!await launchUrl(url)) {
                              throw Exception('No se pudo cargar $url');
                            }
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                                color: principalButton,
                                border: Border(top: BorderSide(width: 0.5))),

                            padding: EdgeInsets.only(
                                left: width / 20,
                                right: width / 20,
                                bottom: height / 25,
                                top: height / 25),
                            //color: Colors.red,
                            width: width,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Ver en Github',
                                    style: TextStyle(
                                        fontFamily: principalFontFamily,
                                        fontSize: width / 20,
                                        color: primaryBlack),
                                  ),
                                  SizedBox(
                                    width: width / 40,
                                  ),
                                  const Icon(Icons.open_in_new)
                                ]),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
