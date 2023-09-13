import 'package:flutter/material.dart';
import 'package:portafolio/styles/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectLabels {
  ProjectLabels({required this.snapshot});

  final AsyncSnapshot<List<dynamic>> snapshot;

  List getLabelsList() {
    var labelList = [];

    for (var i = 0; i < snapshot.data!.length; i++) {
      var labelsInLength = snapshot.data?[i]["projectLabels"].length;
      var specificLabel = snapshot.data?[i]["projectLabels"];

      for (var i = 0; i < labelsInLength; i++) {
        labelList.add(specificLabel[i]);
      }
    }
    return labelList.toSet().toList();
  }
}

class ProjectFilter {
  ProjectFilter({required this.snapshot});

  //3. Aqui se guarda la información de los proyectos:
  final AsyncSnapshot<List<dynamic>> snapshot;

  //3. Lista de proyectos filtrados según el botón presionado:
  List<ProjectManager> filtroFinal = [];

  List<ProjectManager> getSimilitudes(labelToCompare) {
    //print("Boton presionado: $labelToCompare");

    var listaProyectos = snapshot.data!.length;

    for (var i = 0; i < listaProyectos; i++) {
      //print(snapshot.data?[i]["projectLabels"]);
      //print('');
      var cardBgColor = snapshot.data?[i]["cardBgColor"];
      var projectBanner = snapshot.data?[i]["projectBanner"];
      var projectDescription = snapshot.data?[i]["projectDescription"];
      var projectLabels = snapshot.data?[i]["projectLabels"];
      var projectLinks = snapshot.data?[i]["projectLinks"];
      var projectTitle = snapshot.data?[i]["projectTitle"];

      //print('');

      for (var i = 0; i < projectLabels.length; i++) {
        //print(labels[i]);
        //print('');

        if (projectLabels[i] == labelToCompare) {
          filtroFinal.add(
            ProjectManager(
              snapshot: snapshot,
              cardBgColor: cardBgColor,
              projectBanner: projectBanner,
              description: projectDescription,
              labels: projectLabels,
              projectLinks: projectLinks,
              title: projectTitle,
            ),
          );
          // print("Hay coincidencias en los proyectos: $projectTitle");
          // print('');
          //print(projectTitle);
        }
      }
    }

    //print(filtroFinal);
    return filtroFinal;
  }
}

class ProjectManager extends StatefulWidget {
  final AsyncSnapshot<List<dynamic>> snapshot;
  final dynamic cardBgColor;
  final dynamic projectBanner;
  final dynamic description;
  final dynamic labels;
  final dynamic projectLinks;
  final dynamic title;

  const ProjectManager({
    super.key,
    required this.snapshot,
    required this.cardBgColor,
    required this.projectBanner,
    required this.description,
    required this.labels,
    required this.projectLinks,
    required this.title,
  });

  @override
  // ignore: no_logic_in_create_state
  State<ProjectManager> createState() => _ProjectManagerState(
        snapshot: snapshot,
        cardBgColor: cardBgColor,
        projectBanner: projectBanner,
        description: description,
        labels: labels,
        projectLinks: projectLinks,
        title: title,
      );
}

class _ProjectManagerState extends State<ProjectManager> {
  _ProjectManagerState({
    required this.snapshot,
    required this.cardBgColor,
    required this.projectBanner,
    required this.description,
    required this.labels,
    required this.projectLinks,
    required this.title,
  });

  final AsyncSnapshot<List<dynamic>> snapshot;
  final dynamic cardBgColor;
  final dynamic projectBanner;
  final dynamic description;
  final dynamic labels;
  final dynamic projectLinks;
  final dynamic title;

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

    Color cardColor = Color(cardBgColor).withOpacity(1);

    final originalCardBgColor = HSLColor.fromColor(cardColor);
    final finalCardBgColor =
        originalCardBgColor.withLightness(0.2.clamp(0.0, 1.0)).toColor();


    return InkWell(
      onTap: () {
        _onPressAnimation();
      },
      child: Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 8, 8, 8),
              blurRadius: 5,
              offset: Offset(2, 2), // Shadow position
            ),
          ],
        ),
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
                        //color: Color("157"),
                        color: cardColor,
                        
                        child: projectBanner != ''
                            ? projectBanner == "default"
                                ? Image.asset(
                                    'assets/illustraciones/Mataura.png',
                                    fit: BoxFit.cover)
                                : Image.network(projectBanner,
                                    fit: BoxFit.cover)
                            : const Center(
                                child: CircularProgressIndicator(),
                              ),
                      ),
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
                        child: Text('$title',
                            style: TextStyle(
                                fontFamily: principalFontFamily,
                                fontSize: width / 15,
                                color:
                                    Theme.of(context).colorScheme.secondary)),
                      ),
                    ],
                  ),

                  //10. Second Child

                  secondChild: Column(
                    children: [
                      //2. Project banner
                      Container(
                        width: width,
                        height: height / 2.5,
                        color: cardColor,
                        child: projectBanner == "default"
                            ? Image.asset('assets/illustraciones/Mataura.png',
                                fit: BoxFit.cover)
                            : Image.network(projectBanner, fit: BoxFit.cover),
                      ),

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
                            top: height / 40),
                        child: Text('$title',
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
                            top: height / 50,
                            bottom: height / 50),
                        child: Text('$description',
                            style: TextStyle(
                                fontFamily: principalFontFamily,
                                fontSize: width / 20,
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
                          spacing: width / 50,
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
                      Column(
                        children: List.generate(
                          projectLinks.length,
                          (index) {
                            var linkName = projectLinks[index]["name"];
                            var linkURL = projectLinks[index]["url"];

                            return InkWell(
                              highlightColor: Colors.blue,
                              focusColor: Colors.blue,
                              overlayColor:
                                  const MaterialStatePropertyAll(Colors.blue),
                              hoverColor: Colors.blue,
                              splashColor: Colors.blue,
                              onTap: () async {
                                final Uri url = Uri.parse(linkURL);

                                if (!await launchUrl(url)) {
                                  throw Exception('No se pudo cargar $url');
                                }
                              },
                              
                              child: Container(
                                decoration: BoxDecoration(
                                  color: cardColor,
                                  border: const Border(top: BorderSide(width: 1, color: primaryBlack)),
                                ),

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
                                    Flexible(
                                      child: Text(
                                        '$linkName',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: principalFontFamily,
                                            fontSize: width / 15,
                                            color: finalCardBgColor),
                                      ),
                                    ),
                                    SizedBox(
                                      width: width / 40,
                                    ),
                                    Icon(
                                      Icons.open_in_new,
                                      size: width / 20,
                                      color: finalCardBgColor,
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
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
    );
  }
}
