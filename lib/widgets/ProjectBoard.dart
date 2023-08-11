import 'package:flutter/material.dart';
import 'package:portafolio/styles/themes/styles.dart';

class ProjectBoard extends StatelessWidget {
  const ProjectBoard({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      color: const Color.fromRGBO(162, 195, 195, 1),
      padding: ProjectBoardPadding,
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: [
          BoxShadow(
            color: primaryBlack,
            blurRadius: 10,
            offset: Offset(2, 2), // Shadow position
          ),
        ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadiusSecondary),
          child: Container(
            padding: EdgeInsets.only(bottom: height / 30),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: Column(
              children: [
                ProjectManagerFavorites(
                    width: width,
                    height: height,
                    cardBgColor: Color.fromARGB(255, 105, 214, 247),
                    projectTitle: 'Encriptador de texto',
                    projectBanner: 'assets/images/preview.png',
                    proyectLabels: ['Hola', 'dos']),
                ProjectManagerFavorites(
                  width: width,
                  height: height,
                  cardBgColor: Colors.pink,
                  projectTitle: 'projectTitle2',
                  projectBanner: '',
                  proyectLabels: [],
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProjectManagerFavorites extends StatelessWidget {
  ProjectManagerFavorites({
    super.key,
    required this.width,
    required this.height,
    required this.cardBgColor,
    required this.projectTitle,
    required this.projectBanner, 
    required this.proyectLabels,
  });

  final double width;
  final double height;
  final Color cardBgColor;
  final String projectTitle;
  final String projectBanner;
  final List<String> proyectLabels;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: width / 20, right: width / 20, top: height / 30),
      child: InkWell(
        onTap: () {},
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadiusSecondary),
          child: Container(
            color: primaryLight,
            height: height / 4.5,
            child: Column(
              children: [
                Container(
                    width: width,
                    height: height / 6,
                    color: cardBgColor,
                    child: projectBanner.isEmpty
                        ? Image.asset('assets/illustraciones/Mataura.png',
                            fit: BoxFit.cover)
                        : Image.asset('$projectBanner', fit: BoxFit.cover)),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: width/20),
                  height: height / 18,
                  child: Text(projectTitle,
                      style: TextStyle(
                          fontSize: width / 20,
                          color: Theme.of(context).colorScheme.secondary)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
