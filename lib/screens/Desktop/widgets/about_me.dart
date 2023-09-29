// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages

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
          String AboutMeDescription = snapshot.data[0]['Descripcion'];
          String lateralImage = snapshot.data[0]['Imagen lateral'];
          List badgesList = snapshot.data[0]['Insignias'];

          return Container(
            key: globalKeyAboutMe,
            width: width,
            //height: height,
            color: const Color.fromRGBO(0, 54, 93, 1),
            child: Padding(
              padding:
                  //EdgeInsets.symmetric(horizontal: width / 15, vertical: height / 5),
                  EdgeInsets.only(
                      right: width / 15,
                      left: width / 15,
                      top: height / 6,
                      bottom: height / 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //10. Imágen lateral
                  SizedBox(
                    //color: Colors.amber,
                    width: width / 4,
                    child: Image.network(lateralImage),
                  ),

                  //10. Sección sobre mi
                  Container(
                    //color: Color.fromARGB(255, 32, 7, 255),
                    width: width / 4,
                    padding: EdgeInsets.all(height / 20),
                    child: Column(
                      children: [
                        GradientText(
                          'Sobre mi',
                          textAlign: TextAlign.center,
                          colors: secondaryDegradee,
                          style: TextStyle(
                            fontSize: width / 27,
                          ),
                        ),
                        SizedBox(
                          height: height / 100,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: SelectableText(
                            AboutMeDescription,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: primaryLight,
                              fontSize: width / 70,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //10. Panel de habilidades
                  Container(
                    //color: Colors.red,
                    width: width / 4,
                    padding: EdgeInsets.all(height / 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GradientText(
                          'Habilidades',
                          textAlign: TextAlign.center,
                          colors: secondaryDegradee,
                          style: TextStyle(
                            fontSize: width / 29,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        SizedBox(
                          height: height / 100,
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
                            var badgeUrl = snapshot.data[0]['Insignias'][index]
                                ['ImageUrl'];
                            var badgeName =
                                snapshot.data[0]['Insignias'][index]['nombre'];

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
              Image.network(
                image,
                fit: BoxFit.cover,
                width: width / 30,
              ),
              SelectableText(
                title,
                style: TextStyle(color: primaryLight, fontSize: width / 100),
              )
            ],
          ),
        ),
      ),
    );
  }
}
