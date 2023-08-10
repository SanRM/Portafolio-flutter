import 'package:flutter/material.dart';
import 'package:portafolio/styles/themes/styles.dart';

class Header extends StatefulWidget implements PreferredSizeWidget {
  final double height;

  final double width;

  const Header({super.key, required this.height, required this.width});

  @override
  State<Header> createState() => _HeaderState(this.height, this.width);

  @override
  Size get preferredSize => Size(width, height);
}

class _HeaderState extends State<Header> {
  final double height;
  final double width;

  _HeaderState(this.height, this.width);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingSymmetricTop,
      child: Container(
        height: height / heightDivisor,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer),
        //color: Colors.transparent),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          tituloMarca(width: width),
          SizedBox(width: width * appbarSpacing),
          InkWell(
              onTap: () {
                
              },
              customBorder: CircleBorder(),
              child: Container(
                  width: width / 9,
                  height: height / 19,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(50)),
                  child: Icon(Icons.dark_mode_outlined, size: width / 12))),
          ContactButton(
            width: width,
            height: height,
          )
        ]),
      ),
    );
  }
}

class tituloMarca extends StatelessWidget {
  const tituloMarca({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width / 4,
      //color: const Color.fromARGB(255, 7, 123, 255),
      child: Text(
        'Horizon SanTech',
        style: TextStyle(fontSize: width / 20),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class ContactButton extends StatelessWidget {
  const ContactButton({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          const BorderRadius.all(Radius.circular(containerBorderRadius)),
      child: Container(
        width: width / 3.5,
        height: height / 20,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(containerBorderRadius),
            color: Theme.of(context).colorScheme.primary),
        child: Center(
            child: Text(
          'Contacto',
          style: TextStyle(fontSize: width / 25, color: Colors.white),
        )),
      ),
    );
  }
}
