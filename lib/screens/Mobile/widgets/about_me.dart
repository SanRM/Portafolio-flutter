// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:portafolio/services/firebase_service.dart';
import 'package:portafolio/styles/styles.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

GlobalKey globalKeyAboutMe = GlobalKey();

class AboutMe extends StatelessWidget {
  const AboutMe({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getSection("Sección de habilidades"),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          String aboutMeDescription = snapshot.data[0]['Descripcion'];
          String lateralImage = snapshot.data[0]['Imagen lateral'];
          List badgesList = snapshot.data[0]['Insignias'];

          return Container(
            key: globalKeyAboutMe,
            width: width,
            color: const Color.fromRGBO(0, 54, 93, 1),
            child: Padding(
              padding: EdgeInsets.only(
                  left: width / 10,
                  right: width / 10,
                  bottom: width / 10,
                  top: width / 10),
              child: Column(
                children: [
                  //10. Imágen lateral
                  SizedBox(
                    //color: Colors.amber,
                    height: height / 4,
                    width: width,
                    child: Image.network(lateralImage),
                  ),

                  //10. Sección sobre mi
                  GradientText(
                    'Sobre mi',
                    textAlign: TextAlign.center,
                    colors: secondaryDegradee,
                    style: TextStyle(
                        fontFamily: principalFontFamily,
                        fontSize: width / 10,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  Text(
                    aboutMeDescription,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: principalFontFamily,
                        color: primaryLight,
                        fontSize: width / 20),
                  ),
                  SizedBox(
                    height: height / 20,
                  ),

                  //10. Panel de habilidades
                  GradientText(
                    'Habilidades',
                    textAlign: TextAlign.center,
                    colors: secondaryDegradee,
                    style: TextStyle(
                        fontFamily: principalFontFamily, fontSize: width / 9),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemCount: badgesList.length,
                    itemBuilder: (context, index) {
                      var badgeUrl = snapshot.data[0]['Insignias'][index]['ImageUrl'];
                      var badgeName = snapshot.data[0]['Insignias'][index]['nombre'];

                      return BadgesGrid(
                        width: width,
                        height: height,
                        title: badgeName,
                        image: badgeUrl,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.onTertiaryContainer,
            ),
          );
        }
      },
    );
  }
}

class BadgesGrid extends StatelessWidget {
  const BadgesGrid(
      {super.key,
      required this.width,
      required this.height,
      required this.title,
      required this.image});

  final double width;
  final double height;
  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: const Color.fromRGBO(21, 65, 109, 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Tooltip(
                message: title,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 7, 196, 230),
                      Color.fromARGB(255, 63, 158, 236)
                    ],
                  ),
                ),
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                  width: width / 7,
                ),
              ),
              Text(
                title,
                style: TextStyle(color: primaryLight, fontSize: width / 25),
              )
            ],
          ),
        ),
      ),
    );
  }
}
