// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:portafolio/styles/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectBoard extends StatefulWidget {
  ProjectBoard({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  State<ProjectBoard> createState() => _ProjectBoardState();
}

class _ProjectBoardState extends State<ProjectBoard> {
  List labels = ['HTML', 'CSS', 'JavaScript', 'Java'];

  bool buttonOnPressed = false;

  static List<ProjectManager> proyectos = [
    const ProjectManager(
        cardBgColor: const Color.fromARGB(255, 105, 214, 247),
        projectTitle: 'Encriptador de texto',
        projectBanner: 'assets/images/preview.png',
        projectDescription: 'Descripción proyecto',
        projectLabels: const ['HTML', 'CSS', 'JavaScript'],
        projectLink: 'https://github.com/SanRM/Encriptador'),
    const ProjectManager(
      cardBgColor: Colors.pink,
      projectTitle: 'Proyecto creado con Java',
      projectBanner: '',
      projectDescription: 'a',
      projectLabels: const ['Java'],
      projectLink: 'https://github.com/SanRM/Conversor',
    ),
    const ProjectManager(
      cardBgColor: Color.fromARGB(255, 30, 233, 165),
      projectTitle: 'Proyecto creado con Java version 2',
      projectBanner: '',
      projectDescription: 'asd',
      projectLabels: const ['Java'],
      projectLink: 'https://github.com/SanRM/Conversor',
    ),
    const ProjectManager(
      cardBgColor: Color.fromARGB(255, 65, 95, 226),
      projectTitle: 'Proyecto creado con HTML',
      projectBanner: '',
      projectDescription: 'asd',
      projectLabels: const ['HTML'],
      projectLink: 'https://github.com/SanRM/Conversor',
    ),
  ];

  List<Widget> projectSelected = proyectos;

  _selectButtonLabel(labelSelected, projects) {
    setState(() {
      projectSelected = [];
    });

    Future.delayed(Duration(microseconds: 1000), () {
      setState(() {
        projectSelected =
            ProjectFilter(projects: projects).getSimilitudes(labelSelected);
        print(projectSelected);
      });
    });
  }

  _mostrarTodos() {
    setState(() {
      projectSelected = [];
    });

    Future.delayed(Duration(microseconds: 1000), () {
      setState(() {
        projectSelected = proyectos;
        //print(projectSelected);
      });
    });
  }

  int _selectedIndex = -1;
  bool _mostrarTodosIsSelected = false;

  void _selectLabel(int index) {
    setState(() {
      _selectedIndex = index;
      _mostrarTodosIsSelected = false;
    });
  }

  String _setActualFilter = '';

  void _mostrarTodosSelected() {
    setState(() {
      _mostrarTodosIsSelected == false
          ? _mostrarTodosIsSelected = true
          : _mostrarTodosIsSelected = false;
      _setActualFilter = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: widget.height * 2,
      color: const Color.fromRGBO(162, 195, 195, 1),
      padding: projectBoardPadding,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: primaryBlack,
              blurRadius: 10,
              offset: Offset(2, 2), // Shadow position
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadiusSecondary),
          child: Container(
            padding: EdgeInsets.only(bottom: widget.height / 50),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.only(
                        left: widget.width / 20,
                        right: widget.width / 20,
                        top: widget.height / 50),
                    child: Container(
                        width: widget.width,
                        //color: Colors.red,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: widget.height / 100,
                                  bottom: widget.height / 500),
                              child: Container(
                                width: widget.width,
                                child: Container(
                                  //color: Colors.blue,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: containerPadding),
                                        child: Container(
                                          //color: Colors.amber,
                                          child: Icon(
                                            Icons.filter_alt_rounded,
                                            size: widget.width / 30,
                                            color: Color.fromARGB(
                                              255,
                                              253,
                                              247,
                                              167,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(
                                              containerPadding),
                                          child: Container(
                                            //color: Colors.red,
                                            child: Wrap(
                                              children: [
                                                SelectableText(
                                                    'Filtrar proyectos según tecnologías usadas',
                                                    style: TextStyle(
                                                        color: primaryLight,
                                                        fontSize:
                                                            widget.width / 40)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Wrap(runSpacing: widget.height / 100, children: [
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 1,
                                itemBuilder: (context, index) {
                                  List<Widget> botones = [];

                                  for (var i = 0; i < labels.length; i++) {
                                    var label = labels[i];

                                    botones.add(
                                      TextButton(
                                        onPressed: () {
                                          _selectButtonLabel(
                                              labels[i], proyectos);
                                          _selectLabel(i);
                                          setState(() {
                                            _setActualFilter = labels[i];
                                          });
                                        },
                                        //ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red))
                                        style: _selectedIndex == i
                                            ? const ButtonStyle(
                                                padding:
                                                    MaterialStatePropertyAll(
                                                        paddingAll),
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                  tertiary,
                                                ),
                                              )
                                            : ButtonStyle(
                                                padding:
                                                    MaterialStatePropertyAll(
                                                        paddingAll),
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                ),
                                                shape: MaterialStatePropertyAll(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            borderRadiusPrimary),
                                                    side: const BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 139, 139, 139),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                        child: _selectedIndex == i
                                            ? Text(
                                                '$label',
                                                style: TextStyle(
                                                    fontFamily:
                                                        principalFontFamily,
                                                    color: primaryBlack,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        widget.width / 100),
                                              )
                                            : Text(
                                                '$label',
                                                style: TextStyle(
                                                    fontFamily:
                                                        principalFontFamily,
                                                    color: primaryLight,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        widget.width / 100),
                                              ),
                                      ),
                                    ); // Agrega widgets a la lista
                                  }

                                  return Wrap(
                                    spacing: widget.width / 100,
                                    runSpacing: widget.height / 50,
                                    alignment: WrapAlignment.start,
                                    children: botones,
                                  );
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: widget.height / 100,
                                    right: widget.width / 40,
                                    bottom: widget.width / 50),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _mostrarTodos();
                                      _selectedIndex = -1;
                                      _mostrarTodosSelected();
                                    });
                                  },
                                  style: _mostrarTodosIsSelected == true
                                      ? ButtonStyle(
                                          padding: MaterialStatePropertyAll(
                                              paddingAll),
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  tertiary))
                                      : ButtonStyle(
                                          padding: MaterialStatePropertyAll(
                                              paddingAll),
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Color.fromRGBO(
                                                      168, 167, 255, 1))),
                                  child: Text(
                                    'Mostrar todo',
                                    style: TextStyle(
                                        fontFamily: principalFontFamily,
                                        color: primaryBlack,
                                        fontWeight: FontWeight.bold,
                                        fontSize: widget.width / 100),
                                  ),
                                ),
                              ),
                            ]),
                          ],
                        ))),
                _setActualFilter != ''
                    ? Padding(
                        padding: EdgeInsets.only(
                            left: widget.width / 20,
                            right: widget.width / 20,
                            bottom: widget.height / 100),
                        child: projectSelected.isNotEmpty
                            ? Row(
                                children: [
                                  Container(
                                    //color: Colors.amber,
                                    child: Icon(
                                      Icons.star_rate_rounded,
                                      size: widget.width / 30,
                                      color: Color.fromARGB(255, 255, 125, 255),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(
                                          containerPadding),
                                      child: Container(
                                        //color: Colors.red,
                                        width: widget.width / 1.7,
                                        child: Wrap(
                                          children: [
                                            Text(
                                              'Proyectos realizados con $_setActualFilter',
                                              style: TextStyle(
                                                  fontFamily:
                                                      principalFontFamily,
                                                  fontSize: widget.width / 40,
                                                  color: primaryLight),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : Container(),
                      )
                    : Container(),
                Container(
                  //color: Colors.purple,
                  width: widget.width,
                  height: widget.height / 1.8,
                  padding: EdgeInsets.only(
                      left: widget.width / 20,
                      right: widget.width / 20,
                      bottom: widget.height / 15),
                  child: RawScrollbar(
                    timeToFade: Duration(microseconds: 1),
                    thumbColor: Color.fromARGB(255, 0, 141, 151),
                    trackColor: Color.fromRGBO(54, 54, 54, 1),
                    trackRadius: Radius.circular(10),
                    trackVisibility: true,
                    thumbVisibility: true,
                    radius: Radius.circular(10),
                    thickness: 5,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      primary: true,
                      child: Wrap(
                          spacing: widget.width / 30,
                          runSpacing: widget.height / 15,
                          alignment: WrapAlignment.start,
                          children: projectSelected),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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

    return InkWell(
      onTap: () {
        _onPressAnimation();
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
                      Container(
                          width: width,
                          height: height / 10,
                          color: cardBgColor,
                          child: projectBanner.isEmpty
                              ? Image.asset('assets/illustraciones/Mataura.png',
                                  fit: BoxFit.cover)
                              : Image.asset(projectBanner, fit: BoxFit.cover)),
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
                        child: Text(projectTitle,
                            style: TextStyle(
                                fontFamily: principalFontFamily,
                                fontSize: width / 50,
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
                          height: height / 7,
                          color: cardBgColor,
                          child: projectBanner.isEmpty
                              ? Image.asset('assets/illustraciones/Mataura.png',
                                  fit: BoxFit.cover)
                              : Image.asset(projectBanner, fit: BoxFit.cover)),

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
                            top: height / 40),
                        child: Text(projectTitle,
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
                        child: Text(projectDescription,
                            style: TextStyle(
                                fontSize: width / 50,
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
                          spacing: width / 80,
                          runSpacing: height / 60,
                          children: List.generate(
                            projectLabels.length,
                            (index) {
                              var project = projectLabels[
                                  index]; // Cambiado projectLabels[1] a projectLabels[index]
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
                                        color: labelTextColor,
                                        fontSize: width / 80),
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
                                      color: primaryBlack),
                                ),
                                SizedBox(
                                  width: width / 80,
                                ),
                                Icon(
                                  Icons.open_in_new,
                                  size: width / 40,
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
