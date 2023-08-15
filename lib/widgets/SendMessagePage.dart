import 'package:flutter/material.dart';
import 'package:portafolio/styles/themes/styles.dart';

class SendMessagePage extends StatefulWidget {
  const SendMessagePage({super.key, required this.height, required this.width});

  final double height;
  final double width;

  @override
  State<SendMessagePage> createState() => _SendMessagePageState(height, height);
}

class _SendMessagePageState extends State<SendMessagePage> {
  final double height;
  final double width;

  _SendMessagePageState(this.height, this.width);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.all(width / 20),
              width: width,
              //color: const Color.fromARGB(255, 54, 244, 155),
              child: Column(
                children: [
                  Container(
                    //color: Colors.amber,
                    alignment: Alignment.center,
                    child: Text(
                      textAlign: TextAlign.center,
                      'Escribe un mensaje',
                      style: TextStyle(
                          fontSize: height / 20,
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: height / 30),
                    //color: Color.fromARGB(255, 7, 255, 110),
                    alignment: Alignment.center,
                    child: TextFormField(
                      cursorColor: Theme.of(context).colorScheme.onPrimary,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                      decoration: InputDecoration(
                          labelText: 'Nombre',
                          labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          floatingLabelStyle: TextStyle(
                              fontSize: height / 40,
                              color: Theme.of(context).colorScheme.onPrimary),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            //borderSide: BorderSide(width: 3, color: Theme.of(context).colorScheme.surface),
                            borderSide: BorderSide(
                                width: 3,
                                color: Theme.of(context).colorScheme.surface),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                width: 3,
                                color: Theme.of(context).colorScheme.onPrimary),
                          )),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: height / 30),
                    //color: Color.fromARGB(255, 7, 123, 255),
                    alignment: Alignment.center,
                    child: TextFormField(
                      cursorColor: Theme.of(context).colorScheme.onPrimary,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        floatingLabelStyle: TextStyle(
                            fontSize: height / 40,
                            color: Theme.of(context).colorScheme.onPrimary),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          //borderSide: BorderSide(width: 3, color: Theme.of(context).colorScheme.surface),
                          borderSide: BorderSide(
                              width: 3,
                              color: Theme.of(context).colorScheme.surface),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              width: 3,
                              color: Theme.of(context).colorScheme.onPrimary),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: height / 30),
                    //color: Color.fromARGB(255, 7, 123, 255),
                    alignment: Alignment.center,
                    child: TextFormField(
                      cursorColor: Theme.of(context).colorScheme.onPrimary,
                      maxLength: 100,
                      textAlignVertical: TextAlignVertical.top,
                      maxLines: (height / 100).toInt(),
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                      decoration: InputDecoration(
                        counterStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary),
                        labelText: 'Mensaje',
                        alignLabelWithHint: true,
                        labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        floatingLabelStyle: TextStyle(
                            fontSize: height / 40,
                            color: Theme.of(context).colorScheme.onPrimary),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          //borderSide: BorderSide(width: 3, color: Theme.of(context).colorScheme.surface),
                          borderSide: BorderSide(
                              width: 3,
                              color: Theme.of(context).colorScheme.surface),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              width: 3,
                              color: Theme.of(context).colorScheme.onPrimary),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: height / 50),
                    //color: Color.fromARGB(255, 7, 123, 255),
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        print('a');
                      },
                      style: ButtonStyle(
                        padding: MaterialStatePropertyAll(
                            EdgeInsets.all(height / 80)),
                        backgroundColor: const MaterialStatePropertyAll(
                          Color.fromARGB(255, 32, 238, 159),
                        ),
                      ),
                      child: Container(
                        width: width,
                        alignment: Alignment.center,
                        child: Text(
                          'Enviar',
                          style: TextStyle(
                            color: primaryBlack,
                            fontSize: height / 50,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
          Container(
            width: width,
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: Color.fromRGBO(100, 200, 245, 1),
                        width: height / 100))),
            child: Image.asset('assets/illustraciones/Waimakariri.png',
                fit: BoxFit.cover),
            height: height / 5,
          )
        ],
      ),
    );
  }
}
