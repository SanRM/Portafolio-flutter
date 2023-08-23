import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:portafolio/services/firebase_service.dart';
import 'package:portafolio/styles/styles.dart';

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

  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController messageController = TextEditingController(text: "");

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    
    ApprovedSnackBar() {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          dismissDirection: DismissDirection.startToEnd,
          margin: EdgeInsets.only(
              bottom: height / 8, right: width / 30, left: width / 30),
          behavior: SnackBarBehavior.floating,
          padding: EdgeInsets.all(0),
          duration: Duration(seconds: 7),
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(width: 2, color: primaryBlack)),
          // Lottie.asset('animations/confeti.json', fit: BoxFit.fill, repeat: false)
          content: Stack(alignment: Alignment.center, children: [
            Positioned(
              bottom: 0,
              child: Container(
                //color: Colors.red,
                width: width,
                height: height / 3,
                child: Lottie.asset('assets/animations/confeti.json',
                    repeat: true, fit: BoxFit.cover),
              ),
            ),
            Container(
              width: width,
              height: height / 15,
              alignment: Alignment.center,
              child: Text(
                '¡Mensaje enviado correctamente!',
                style: TextStyle(
                    fontFamily: principalFontFamily,
                    color: primaryBlack,
                    fontWeight: FontWeight.bold,
                    fontSize: width / 50),
              ),
            ),
          ]),
        ),
      );
    }

    RejectedSnackBar() {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          dismissDirection: DismissDirection.startToEnd,
          margin: EdgeInsets.only(
              bottom: height / 8, right: width / 30, left: width / 30),
          behavior: SnackBarBehavior.floating,
          padding: EdgeInsets.all(0),
          duration: Duration(seconds: 7),
          backgroundColor: Color.fromARGB(255, 255, 67, 130),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(width: 2, color: primaryBlack)),
          // Lottie.asset('animations/confeti.json', fit: BoxFit.fill, repeat: false)
          content: 
            Container(
              width: width,
              height: height / 15,
              alignment: Alignment.center,
              child: Text(
                '¡Ha ocurrido un error al enviar el mensaje!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: principalFontFamily,
                    color: primaryLight,
                    fontWeight: FontWeight.bold,
                    fontSize: width / 50),
              ),
            ),
          
        ),
      );
    }

    enviarMensaje() async {
      await addBandejaDeEntrada(
              nameController.text, emailController.text, messageController.text)
          .then((value) {
        value
            ? ApprovedSnackBar()
            : RejectedSnackBar();
      });
    }

    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.all(width / 20),
              width: width,
              //color: const Color.fromARGB(255, 54, 244, 155),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    //IconButton(onPressed: ApprovedSnackBar, icon: Icon(Icons.ac_unit_rounded)),
                    Container(
                      //color: Colors.amber,
                      alignment: Alignment.center,
                      child: Text(
                        textAlign: TextAlign.center,
                        'Escribe un mensaje',
                        style: TextStyle(
                            fontFamily: principalFontFamily,
                            fontSize: height / 20,
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: height / 30),
                      //color: Color.fromARGB(255, 7, 255, 110),
                      alignment: Alignment.center,
                      child: TextFormField(
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo de texto obligatorio';
                          }
                          return null;
                        },
                        decoration:InputDecoration(labelText: 'Ingresa tu nombre'),
                        keyboardType: TextInputType.name,
                        cursorColor: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: height / 30),
                      //color: Color.fromARGB(255, 7, 123, 255),
                      alignment: Alignment.center,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo de texto obligatorio';
                          } else if (value.contains('@') == false) {
                            return 'Ingresa un email valido';
                          }
                          return null;
                        },
                        decoration:
                            InputDecoration(labelText: 'Ingresa tu email'),
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: height / 30),
                      //color: Color.fromARGB(255, 7, 123, 255),
                      alignment: Alignment.center,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo de texto obligatorio';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Ingresa el texto que desas enviarme',
                          alignLabelWithHint: true,
                        ),
                        controller: messageController,
                        keyboardType: TextInputType.text,
                        cursorColor: Theme.of(context).colorScheme.onPrimary,
                        maxLength: 100,
                        textAlignVertical: TextAlignVertical.top,
                        maxLines: (height / 100).toInt(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height / 80),
                      child: FilledButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              enviarMensaje();
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(height / 100),
                            width: width,
                            alignment: Alignment.center,
                            child: Text(
                              'Enviar',
                              style: TextStyle(
                                  fontFamily: principalFontFamily,
                                  color: primaryBlack,
                                  fontWeight: FontWeight.bold,
                                  fontSize: height / 50),
                            ),
                          )),
                    ),
                  ],
                ),
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
