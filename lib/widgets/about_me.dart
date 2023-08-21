import 'package:flutter/material.dart';
import 'package:portafolio/styles/themes/styles.dart';
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
      '''Mi pasión se enfoca en el desarrollo de aplicaciones móviles, y mi viaje me ha llevado a explorar diferentes tecnologías de programación como Dart, Flutter y Java. \n\n He trabajado en una variedad de proyectos emocionantes que han fortalecido mis habilidades y conocimientos en el mundo del desarrollo de software.''';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      color: const Color.fromRGBO(0, 54, 93, 1),
      child: Padding(
        padding: EdgeInsets.only(left: width / 10, right: width / 10, bottom: width / 20, top: width / 10),
        child: Container(
          //color: Colors.green,
          child: Column(
            children: [
              Container(
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
                    fontSize: width / 8,
                    color: Theme.of(context).colorScheme.secondary),
              ),
              Container(
                padding: paddingAll,
                //color: Colors.deepPurple,
                child: Text(
                  AboutMeDescription,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: primaryLight, fontSize: width / 20),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
