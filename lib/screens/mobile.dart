import 'package:flutter/material.dart';
import 'package:portafolio/components/bottomAppBar.dart';
import 'package:portafolio/components/Header.dart';
import 'package:portafolio/styles/Responsive/responsive.dart';
import 'package:portafolio/styles/themes/styles.dart';

class Mobile extends StatefulWidget {
  const Mobile({super.key});

  @override
  State<Mobile> createState() => _MobileState();
}

class _MobileState extends State<Mobile> {
  
  @override
  Widget build(BuildContext context) {
    double height = Responsive(context: context).getDeviceHeight();
    double width = Responsive(context: context).getDeviceWidth();

    return Scaffold(
      appBar: Header(height: height, width: width),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              PrincipaImage(width: width, height: height),
              InitialInformation(width: width, height: height),
              projectBoard(width: width, height: height),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MobileBottomAppBar(height: height, width: width),
    );
  }
}

class projectBoard extends StatelessWidget {
  const projectBoard({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: Color.fromRGBO(162, 195, 195, 1),
    );
  }
}

class PrincipaImage extends StatelessWidget {
  const PrincipaImage({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingSymetricMiddle,
      child: Container(
        padding: paddingSymetricMiddle,
        width: width,
        height: height / 4,
        //color: Colors.red,
        child: Image.asset('assets/images/PrincipaImage.png'),
      ),
    );
  }
}

class InitialInformation extends StatelessWidget {
  final double width;
  final double height;

  const InitialInformation({
    required this.width,
    required this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: paddingSymetricMiddle,
          child: Container(
              alignment: Alignment.center,
              width: width,
              height: height / 10,
              //color: const Color.fromARGB(255, 54, 244, 139),
              child: Text('PORTAFOLIO',
                  style: TextStyle(fontSize: width / 15, letterSpacing: 6))),
        ),
        Padding(
          padding: paddingSymetricMiddle,
          child: Container(
            width: width,
            height: height / 150,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Padding(
          padding: paddingSymetricMiddle,
          child: Container(
            padding: paddingAll,
            alignment: Alignment.center,
            //color: Color.fromARGB(255, 54, 105, 244),
            child: Text('Santiago Rodriguez Morales',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: width / 10)),
          ),
        ),
        Padding(
          padding: paddingSymetricMiddle,
          child: Container(
              alignment: Alignment.center,
              height: height / 20,
              //color: Color.fromARGB(255, 255, 121, 255),
              child: Text(
                'Desarrollador de software',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: width / 18),
              )),
        ),
        Padding(
          padding: paddingSymetricMiddle,
          child: Container(
            width: width / 1.5,
            height: height / 6,
            //color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    width: width / 4,
                    child: Image.asset('assets/images/github-mark-white.png',
                        scale: width / 70),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color.fromRGBO(50, 50, 50, 1),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    width: width / 4,
                    child: Image.asset('assets/images/linkedin.png', scale: width / 40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color.fromRGBO(1, 120, 180, 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
