import 'package:flutter/material.dart';
import 'package:portafolio/styles/styles.dart';

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
    ;

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

  intToColor(cardBgColor) {
    print(cardBgColor);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.width;

    Color cardColor = Color(cardBgColor).withOpacity(1);

    return InkWell(
      onTap: () {
        _onPressAnimation();
        //print(finalcolor);
      },
      child: Container(
        width: width / 4,
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
                      Stack(
                        children: [
                          Container(
                            width: width,
                            height: height / 10,
                            //color: Color("157"),
                            color: cardColor,
                            child: projectBanner == "default"
                                ? Image.asset(
                                    'assets/illustraciones/Mataura.png',
                                    fit: BoxFit.cover)
                                : Image.network(projectBanner,
                                    fit: BoxFit.cover),
                          ),
                          Positioned(
                            top: height / 100,
                            right: width / 100,
                            child: InkWell(
                                child: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(115, 0, 0, 0),
                                  borderRadius: BorderRadius.circular(50)),
                              child: Icon(
                                size: width / 50,
                                Icons.crop_free,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            )),
                          ),
                        ],
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
                            horizontal: width / 40, vertical: height / 100),
                        child: Text('$title',
                            style: TextStyle(
                                fontFamily: principalFontFamily,
                                fontSize: width / 50,
                                color:
                                    Theme.of(context).colorScheme.secondary)),
                      ),
                    ],
                  ),

                  //10. Second Child

                  secondChild: Column(
                    children: [
                      //2. Project banner
                      Stack(
                        children: [
                          Container(
                            width: width,
                            height: height / 7,
                            color: cardColor,
                            child: projectBanner == "default"
                                ? Image.asset(
                                    'assets/illustraciones/Mataura.png',
                                    fit: BoxFit.cover)
                                : Image.network(projectBanner,
                                    fit: BoxFit.cover),
                          ),
                          Positioned(
                            top: height / 100,
                            right: width / 100,
                            child: InkWell(
                                child: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(115, 0, 0, 0),
                                  borderRadius: BorderRadius.circular(50)),
                              child: Icon(
                                size: width / 50,
                                Icons.crop_free,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            )),
                          ),
                        ],
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
                            left: width / 40,
                            right: width / 40,
                            top: height / 80),
                        child: Text('$title',
                            style: TextStyle(
                                fontFamily: principalFontFamily,
                                fontWeight: FontWeight.bold,
                                fontSize: width / 40,
                                color:
                                    Theme.of(context).colorScheme.secondary)),
                      ),

                      //2. Project description
                      Container(
                        //color: const Color.fromARGB(255, 7, 255, 40),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(
                            left: width / 40,
                            right: width / 40,
                            top: height / 100,
                            bottom: height / 100),
                        child: Text('$description',
                            style: TextStyle(
                                fontFamily: principalFontFamily,
                                fontSize: width / 80,
                                color: projectBoardDescription)),
                      ),

                      //2. Project labels
                      Container(
                        //color: const Color.fromARGB(255, 7, 143, 255),
                        width: width / 1,
                        padding: EdgeInsets.only(
                          left: width / 40,
                          right: width / 40,
                          top: height / 100,
                          bottom: height / 40,
                        ),
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          spacing: width / 100,
                          runSpacing: height / 100,
                          // children: List.generate(
                          //   projectLabels.length,
                          //   (index) {
                          //     var project = projectLabels[
                          //         index]; // Cambiado projectLabels[1] a projectLabels[index]
                          //     return Chip(
                          //         backgroundColor:
                          //             const Color.fromARGB(255, 243, 243, 243),
                          //         shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(
                          //               borderRadiusPrimary),
                          //           side: const BorderSide(
                          //               strokeAlign: 2, color: labelOutline),
                          //         ),
                          //         label: Text(
                          //           project,
                          //           style: TextStyle(
                          //               fontFamily: principalFontFamily,
                          //               color: labelTextColor,
                          //               fontSize: width / 80),
                          //         ));
                          //   },
                          // ),
                        ),
                      ),

                      //2. Project link button
                      InkWell(
                        onTap: () async {
                          // final Uri url = Uri.parse(projectLink);

                          // if (!await launchUrl(url)) {
                          //   throw Exception('No se pudo cargar $url');
                          // }
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                              color: principalButton,
                              border: Border(top: BorderSide(width: 0.5))),

                          padding: EdgeInsets.only(
                              left: width / 40,
                              right: width / 40,
                              bottom: height / 50,
                              top: height / 50),
                          //color: Colors.red,
                          width: width,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Ver en Github',
                                  style: TextStyle(
                                      fontFamily: principalFontFamily,
                                      fontSize: width / 50,
                                      color: Color.fromARGB(255, 0, 83, 104)),
                                ),
                                SizedBox(
                                  width: width / 80,
                                ),
                                Icon(
                                  Icons.open_in_new,
                                  size: width / 40,
                                  color: const Color.fromARGB(255, 0, 83, 104),
                                )
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
    );
  }
}
