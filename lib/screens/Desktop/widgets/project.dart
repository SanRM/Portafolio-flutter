// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:portafolio/services/firebase_service.dart';
import 'package:portafolio/styles/styles.dart';
//import 'package:portafolio/screens/Desktop/widgets/test.dart';

class ProjectBoardTEST extends StatefulWidget {
  ProjectBoardTEST({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  State<ProjectBoardTEST> createState() => _ProjectBoardTESTState();
}

class _ProjectBoardTESTState extends State<ProjectBoardTEST> {
  List<dynamic> valor = [];

  List<dynamic>? data;

  dynamic valorget;

  @override
  
  Widget build(BuildContext context) {

    Future<List> getval() async {
      List projects = [];

      await db.collection("Lista de proyectos").get().then((querySnapshot) {
        querySnapshot.docs.forEach((result) {
          projects.add(result.data());
        });
      });

      ProjectFilter(projects: projects);

      return projects;
      
    }

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
            padding: EdgeInsets.only(bottom: widget.height / 200),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: Column(
              children: [
                FutureBuilder(
                  future: getProjects(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      //var data = snapshot.data?[0];
                      data = snapshot.data;
                      var datalength = data!.length;

                      print('asd');

                      List<Widget> lista = [];

                      for (var i = 0; i < datalength; i++) {
                        var projectDescription =
                            snapshot.data?[i]["projectDescription"];

                        lista.add(
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: widget.width / 4,
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
                                borderRadius: BorderRadius.circular(
                                    borderRadiusSecondary),
                                child: Container(
                                  color:
                                      const Color.fromARGB(255, 243, 243, 243),
                                  child:
                                      Text('proyecto #$i, $projectDescription'),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      return Wrap(
                        children: lista,
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                TextButton(
                  onPressed: () async {
                    
                    valorget = await getval();
                    //print(valorget);
                  },
                  child: Text(
                    '$valorget'
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

  List<dynamic> projects = [];
  List<dynamic> filtroFinal = [];

  List<dynamic> getSimilitudes(labelToCompare) {
    for (var i = 0; i < projects.length; i++) {
      List<dynamic> labels = projects[i];
      var labelsFilter = labels.where((element) {
        return element == labelToCompare;
      }).toList();

      print('labels: $labels,     labelsFilter: $labelsFilter');

      if (labelsFilter.isEmpty == false) {
        if (labelsFilter[0] == labelToCompare) {
          print('Hay etiquetas iguales en el proyecto $i');
          //print(labelsFilter);

          filtroFinal.add(projects[i]);
        }
      } else if (labelsFilter.isEmpty == true) {
        print('No hay etiquetas iguales en el proyecto $i');
      }
    }

    //print('Filtro final: $filtroFinal');
    return filtroFinal;
  }
}