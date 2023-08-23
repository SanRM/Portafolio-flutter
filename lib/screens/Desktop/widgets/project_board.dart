// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:portafolio/config/project_list.dart';
import 'package:portafolio/globalWidgets/project_manager.dart';
import 'package:portafolio/styles/styles.dart';

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

  bool buttonOnPressed = false;

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
            ]),
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
                                            size: widget.width / 15,
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
                                                Text(
                                                    'Filtrar proyectos según tecnologías usadas',
                                                    style: TextStyle(
                                                        fontFamily: principalFontFamily,
                                                        color: primaryLight,
                                                        fontSize:
                                                            widget.width / 20)),
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
                                                padding: MaterialStatePropertyAll(paddingAll),
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                  tertiary,
                                                ),
                                              )
                                            : ButtonStyle(
                                                padding: MaterialStatePropertyAll(paddingAll),
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
                                                  fontFamily: principalFontFamily,
                                                    color: primaryBlack,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        widget.width / 30),
                                              )
                                            : Text(
                                                '$label',
                                                style: TextStyle(
                                                    fontFamily: principalFontFamily,
                                                    color: primaryLight,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        widget.width / 30),
                                              ),
                                      ),
                                    ); // Agrega widgets a la lista
                                  }

                                  return Wrap(
                                    runSpacing: widget.height / 100,
                                    alignment: WrapAlignment.spaceBetween,
                                    children: botones,
                                  );
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: widget.width / 40,
                                    bottom: widget.width / 25),
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
                                          padding: MaterialStatePropertyAll(paddingAll),
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  tertiary))
                                      : ButtonStyle(
                                          padding: MaterialStatePropertyAll(paddingAll),
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
                                        fontSize: widget.width / 30),
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
                                      size: widget.width / 15,
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
                                                fontFamily: principalFontFamily,
                                                fontSize: widget.width / 20,
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
                            : Container(),
                      )
                    : Container(),
                ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: projectSelected,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


