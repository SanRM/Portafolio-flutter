import 'package:flutter/material.dart';
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
      body: Padding(
        padding: EdgeInsets.all(25.0),
        child: Text('hola'),
      ),
      bottomNavigationBar: MobileBottomAppBar(height: height, width: width),
    );
  }
}

class MobileBottomAppBar extends StatelessWidget {
  const MobileBottomAppBar({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ClipRRect(
            borderRadius:
                BorderRadius.all(Radius.circular(ContainerBorderRadius)),
            child: BottomAppBar(
              elevation: 0,
              color: Theme.of(context).colorScheme.primaryContainer,
              height: height / 12,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(ContainerBorderRadius),
                    border: Border.all(
                        width: ContainerBorderWidth,
                        color: Theme.of(context).colorScheme.outline)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: width * 0.01),
                    Text(
                      'Inicio',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      'Proyectos',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      'Sobre mi',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(width: width * 0.01),
                  ],
                ),
              ),
            )));
  }
}
