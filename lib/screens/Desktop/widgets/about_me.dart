import 'package:flutter/material.dart';
import 'package:portafolio/styles/styles.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class AboutMe extends StatelessWidget {
  const AboutMe({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  final String AboutMeDescription =
      '''Mi pasión se enfoca en el desarrollo de aplicaciones móviles, y mi viaje me ha llevado a explorar diferentes tecnologías de programación como Dart, Flutter y Java. \n\n He trabajado en una variedad de proyectos emocionantes que han fortalecido mis habilidades y conocimientos en el mundo del desarrollo de software. ''';

  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: Container(
          //color: Colors.green,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                //color: Colors.amber,
                width: width / 4,
                child: Image.asset('assets/images/PersonalData.png'),
              ),
              Container(
                //color: Color.fromARGB(255, 32, 7, 255),
                width: width / 4,
                padding: EdgeInsets.all(height / 20),
                child: Column(
                  children: [
                    Container(
                      child: GradientText(
                        'Sobre mi',
                        textAlign: TextAlign.center,
                        colors: secondaryDegradee,
                        style: TextStyle(
                          fontSize: width / 27,
                        ),
                      ),
                      padding: EdgeInsets.only(bottom: height / 20),
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
              Container(
                //color: Colors.red,
                width: width / 4,
                padding: EdgeInsets.all(height / 20),
                child: Column(children: [
                  Container(
                    child: GradientText(
                      'Habilidades',
                      textAlign: TextAlign.center,
                      colors: secondaryDegradee,
                      style: TextStyle(
                        fontSize: width / 27,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    padding: EdgeInsets.only(bottom: height / 20),
                  ),
                  Container(
                    //color: Color.fromARGB(255, 0, 118, 122),
                    child: GridView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
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
          color: Color.fromRGBO(21, 65, 109, 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
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
