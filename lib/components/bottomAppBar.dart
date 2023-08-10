import 'package:flutter/material.dart';
import 'package:portafolio/styles/themes/styles.dart';

class MobileBottomAppBar extends StatelessWidget  {

  final double height;
  final double width;

  const MobileBottomAppBar({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ClipRRect(
            borderRadius:
                BorderRadius.all(Radius.circular(containerBorderRadius)),
            child: BottomAppBar(
              elevation: 0,
              color: Colors.transparent,
              height: height / heightDivisor,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(containerBorderRadius),
                    border: Border.all(
                        width: containerBorderWidth,
                        color: Theme.of(context).colorScheme.outline)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: width * sizedBoxWidth),
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
                    SizedBox(width: width * sizedBoxWidth),
                  ],
                ),
              ),
            )));
  }
}