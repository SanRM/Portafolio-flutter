import 'package:flutter/material.dart';
import 'package:portafolio/services/firebase_service.dart';
import 'package:portafolio/styles/styles.dart';

class ProjectFilter {
  AsyncSnapshot<List> snapshot;

  ProjectFilter({required this.snapshot});


  List getSimilitudes(labelToCompare) {

   List<dynamic> filtroFinal = [];

    print("Boton presionado: $labelToCompare");

    var listaProyectos = snapshot.data!.length;

    for (var i = 0; i < listaProyectos; i++) {
      print(snapshot.data?[i]["projectLabels"]);
      print('');

      var labels = snapshot.data?[i]["projectLabels"];
      var proyecto = snapshot.data?[i];

      for (var i = 0; i < labels.length; i++) {
        print(labels[i]);
        
        if (labels[i] == labelToCompare) {
          filtroFinal.add(proyecto);
        }
      }
    };


    // for (var i = 0; i < projects.length; i++) {
    //   List<String> labels = projects[i].projectList[i];
    //   var labelsFilter = labels.where((element) {
    //     return element == labelToCompare;
    //   }).toList();

    //   print('labels: $labels,     labelsFilter: $labelsFilter');

    //   if (labelsFilter.isEmpty == false) {
    //     if (labelsFilter[0] == labelToCompare) {
    //       print('Hay etiquetas iguales en el proyecto $i');
    //       //print(labelsFilter);

    //       filtroFinal.add(projects[i]);
    //     }
    //   } else if (labelsFilter.isEmpty == true) {
    //     print('No hay etiquetas iguales en el proyecto $i');
    //   }
    // }

    //print('Filtro final: $filtroFinal');
    return filtroFinal;
  }
}

class ProjectManager extends StatefulWidget {
  final AsyncSnapshot<List> snapshot;

  const ProjectManager({
    super.key,
    required this.snapshot,
  });

  @override
  // ignore: no_logic_in_create_state
  State<ProjectManager> createState() => _ProjectManagerState(snapshot: snapshot);
}

class _ProjectManagerState extends State<ProjectManager> {
  AsyncSnapshot<List> snapshot;

  _ProjectManagerState({required this.snapshot});

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

    List<dynamic>? data;

    return FutureBuilder(
      future: getProjects(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //var data = snapshot.data?[0];
          data = snapshot.data;
          var datalength = data!.length;

          ProjectFilter(snapshot: snapshot);

          List<Widget> lista = [];

          for (var i = 0; i < datalength; i++) {
            var projectDescription = snapshot.data?[i]["projectDescription"];

            lista.add(
              InkWell(
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
                      child: Text('proyecto #$i, $projectDescription'),
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
    );
  }
}
