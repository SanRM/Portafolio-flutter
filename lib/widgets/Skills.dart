import 'package:flutter/material.dart';
import 'package:portafolio/styles/themes/styles.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class Skills extends StatelessWidget {
  const Skills({
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
      color: const Color.fromRGBO(0, 54, 93, 1),
      padding: EdgeInsets.only(left: width / 10, right: width / 10, bottom: width / 10),
      child: Container(
        width: width,
        //color: Colors.red,
        child: Column(children: [
          SkillsTitle(height: height, width: width,),
          Container(
            //color: Color.fromARGB(255, 0, 118, 122),
            child: GridView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
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
              ],
            ),
          ),
        ]),
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
              Tooltip(
                message: title,
                decoration: BoxDecoration(gradient: LinearGradient(colors: [Color.fromARGB(255, 7, 196, 230), Color.fromARGB(255, 63, 158, 236)])),
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

class SkillsTitle extends StatelessWidget {
  const SkillsTitle({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      //color: Color.fromARGB(255, 187, 32, 166),
      padding: EdgeInsets.only(bottom: height/50),
      child: GradientText(
        'Habilidades',
        textAlign: TextAlign.center,
        colors: secondaryDegradee,
        style: TextStyle(
            fontSize: width / 8,
            color: Theme.of(context).colorScheme.secondary),
      ),
    );
  }
}
