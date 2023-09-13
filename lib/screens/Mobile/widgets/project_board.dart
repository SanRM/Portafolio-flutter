// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:portafolio/styles/styles.dart';
import 'package:portafolio/screens/Mobile/widgets/project_utilities.dart';

GlobalKey globalKeyProjectBoard = GlobalKey();

class ProjectBoard extends StatefulWidget {
  const ProjectBoard({
    super.key,
    required this.width,
    required this.height,
    required this.snapshot,
  });

  final double width;
  final double height;
  final AsyncSnapshot<List<dynamic>> snapshot;

  @override
  State<ProjectBoard> createState() => _ProjectBoardState();
}

class _ProjectBoardState extends State<ProjectBoard> {
  List<dynamic> labels = [];
  List<ProjectManager> proyectos = [];
  List<ProjectManager> projectSelected = [];
  String setActualFilter = '';
  bool mostrarTodosIsSelected = false;
  int _selectedIndex = -1;

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < widget.snapshot.data!.length; i++) {
      var cardColor = widget.snapshot.data?[i]["cardBgColor"];
      var projectBanner = widget.snapshot.data?[i]["projectBanner"];
      var description = widget.snapshot.data?[i]["projectDescription"];
      var projectLabels = widget.snapshot.data?[i]["projectLabels"];
      var projectLinks = widget.snapshot.data?[i]["projectLinks"];
      var titulo = widget.snapshot.data?[i]["projectTitle"];

      proyectos.add(ProjectManager(
        snapshot: widget.snapshot,
        cardBgColor: cardColor,
        projectBanner: projectBanner,
        description: description,
        labels: projectLabels,
        projectLinks: projectLinks,
        title: titulo,
      ));
    }

    labels = ProjectLabels(snapshot: widget.snapshot).getLabelsList();

    _mostrarTodos();
  }

  void _selectButtonLabel(labelSelected, projects) {
    setState(() {
      projectSelected = [];
    });

    Future.delayed(const Duration(milliseconds: 10), () {
      setState(() {
        projectSelected = ProjectFilter(snapshot: widget.snapshot)
            .getSimilitudes(labelSelected);
        //print(projectSelected);
      });
    });
  }

  void _mostrarTodos() {
    setState(() {
      projectSelected = [];
      setActualFilter = '';

      mostrarTodosIsSelected == false
          ? mostrarTodosIsSelected = true
          : mostrarTodosIsSelected = false;
    });
    Future.delayed(const Duration(milliseconds: 10), () {
      setState(() {
        projectSelected = proyectos;
        //print(projectSelected);
      });
    });
  }

  void _selectLabel(int index) {
    setState(() {
      _selectedIndex = index;
      mostrarTodosIsSelected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: globalKeyProjectBoard,
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
            padding: EdgeInsets.only(bottom: widget.height / 200),
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
                  child: SizedBox(
                    width: widget.width,
                    //color: Colors.red,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: widget.height / 100,
                              bottom: widget.height / 100),
                          child: SizedBox(
                            width: widget.width,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: containerPadding),
                                  child: Icon(
                                    Icons.filter_alt_rounded,
                                    size: widget.width / 15,
                                    color: const Color.fromARGB(
                                      255,
                                      253,
                                      247,
                                      167,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                        containerPadding),
                                    child: Wrap(
                                      children: [
                                        SelectableText(
                                            'Filtrar proyectos según tecnologías usadas',
                                            style: TextStyle(
                                                color: primaryLight,
                                                fontSize:
                                                    widget.width / 20)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Wrap(
                          runSpacing: widget.height / 100,
                          children: [
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
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
                                          setActualFilter = labels[i];
                                        });
                                      },
                                      //ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red))
                                      style: _selectedIndex == i
                                          ?  ButtonStyle(
                                              padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: widget.height/80, horizontal: widget.height/50)),
                                              backgroundColor:
                                                  const MaterialStatePropertyAll(
                                                tertiary,
                                              ),
                                            )
                                          : ButtonStyle(
                                              padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: widget.height/80, horizontal: widget.height/50)),
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
                                                  fontSize: widget.width / 30),
                                            )
                                          : Text(
                                              '$label',
                                              style: TextStyle(
                                                  fontFamily:
                                                      principalFontFamily,
                                                  color: primaryLight,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: widget.width / 30),
                                            ),
                                    ),
                                  ); // Agrega widgets a la lista
                                }

                                return Wrap(
                                  spacing: widget.width / 50,
                                  runSpacing: widget.height / 100,
                                  alignment: WrapAlignment.start,
                                  children: botones,
                                );
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: widget.height / 200,
                                  right: widget.width / 40,
                                  //bottom: widget.width / 20
                                  ),
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    //print('mostrar todos');
                                    _mostrarTodos();
                                    _selectedIndex = -1;
                                    //_mostrarTodosSelected();
                                  });
                                },
                                style: mostrarTodosIsSelected == true
                                    ? ButtonStyle(
                                        padding: MaterialStatePropertyAll(
                                            EdgeInsets.symmetric(vertical: widget.height/80, horizontal: widget.height/50)),
                                        backgroundColor:
                                            const MaterialStatePropertyAll(tertiary))
                                    : ButtonStyle(
                                        padding: MaterialStatePropertyAll(
                                            EdgeInsets.symmetric(vertical: widget.height/80, horizontal: widget.height/50)),
                                        backgroundColor:
                                            const MaterialStatePropertyAll(
                                                Color.fromRGBO(
                                                    168, 167, 255, 1))),
                                child: Text(
                                  'Mostrar todo',
                                  style: TextStyle(
                                      fontFamily: principalFontFamily,
                                      color: primaryBlack,
                                      fontWeight: FontWeight.bold,
                                      fontSize: widget.width / 30),
                                ),
                              ),
                            ),
                          ],
                        ),
                        setActualFilter != ''
                            ? Row(
                                children: [
                                  Icon(
                                    Icons.star_rate_rounded,
                                    size: widget.width / 25,
                                    color: const Color.fromARGB(255, 255, 125, 255),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: widget.height/40, horizontal: widget.height/80),
                                      child: SizedBox(
                                        //color: Colors.red,
                                        width: widget.width / 1.7,
                                        child: Wrap(
                                          children: [
                                            Text(
                                              'Proyectos desarrollados con $setActualFilter',
                                              style: TextStyle(
                                                fontFamily: principalFontFamily,
                                                fontSize: widget.width / 25,
                                                color: primaryLight
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              
                            )
                            : SizedBox(height: widget.height/40),
                      ],
                    ),
                  ),
                ),
                Container(
                  //color: Colors.purple,
                  width: widget.width,
                  //height: widget.height / 1.7,
                  padding: EdgeInsets.only(
                      left: widget.width / 20,
                      right: widget.width / 20,
                      bottom: widget.height / 40),

                  child: Wrap(
                      spacing: widget.width / 30,
                      runSpacing: widget.height / 40,
                      alignment: WrapAlignment.start,
                      children: projectSelected),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
