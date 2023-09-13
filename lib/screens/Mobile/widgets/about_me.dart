// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
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

  final String aboutMeDescription =
      '''Mi pasión se enfoca en el desarrollo de aplicaciones móviles, y mi viaje me ha llevado a explorar diferentes tecnologías de programación como Dart, Flutter y Java. \n\n He trabajado en una variedad de proyectos emocionantes que han fortalecido mis habilidades y conocimientos en el mundo del desarrollo de software.''';

  @override
  Widget build(BuildContext context) {
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
            SizedBox(
              //color: Colors.amber,
              height: height / 4,
              width: width,
              child: Image.asset('assets/images/PersonalData.png'),
            ),
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
            GradientText(
              'Habilidades',
              textAlign: TextAlign.center,
              colors: secondaryDegradee,
              style: TextStyle(
                  fontFamily: principalFontFamily, fontSize: width / 9),
            ),
            GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              children: [
                BadgesGrid(
                    width: width,
                    height: height,
                    title: 'Dart',
                    image: 'assets/images/dart.png'),
                BadgesGrid(
                    width: width,
                    height: height,
                    title: 'Flutter',
                    image: 'assets/images/flutter.png'),
                BadgesGrid(
                    width: width,
                    height: height,
                    title: 'SQL',
                    image: 'assets/images/sql.png'),
                BadgesGrid(
                    width: width,
                    height: height,
                    title: 'Java',
                    image: 'assets/images/java.png'),
                BadgesGrid(
                    width: width,
                    height: height,
                    title: 'Python',
                    image: 'assets/images/python.png'),
                BadgesGrid(
                    width: width,
                    height: height,
                    title: 'MySQL',
                    image: 'assets/images/mysql.png'),
                BadgesGrid(
                    width: width,
                    height: height,
                    title: 'HTML',
                    image: 'assets/images/html.png'),
                BadgesGrid(
                    width: width,
                    height: height,
                    title: 'CSS 5',
                    image: 'assets/images/css.png'),
                BadgesGrid(
                    width: width,
                    height: height,
                    title: 'JavaScript',
                    image: 'assets/images/js.png'),
                BadgesGrid(
                    width: width,
                    height: height,
                    title: 'Firebase',
                    image: 'assets/images/firebase.png'),
              ],
            ),
          ],
        ),
      ),
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
                    gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 7, 196, 230),
                  Color.fromARGB(255, 63, 158, 236)
                ])),
                child: Image.asset(
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
