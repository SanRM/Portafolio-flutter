import 'package:flutter/material.dart';
//import 'package:lottie/lottie.dart';
import 'package:portafolio/services/firebase_service.dart';
import 'package:portafolio/styles/styles.dart';

class SendMessagePage extends StatefulWidget {
  const SendMessagePage({Key? key, required this.height, required this.width})
      : super(key: key);

  final double height;
  final double width;

  @override
  State<SendMessagePage> createState() => _SendMessagePageState();
}

class _SendMessagePageState extends State<SendMessagePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _showApprovedSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        dismissDirection: DismissDirection.startToEnd,
        margin: EdgeInsets.only(
          bottom: widget.height / 3,
          right: widget.width / 5,
          left: widget.width / 5,
        ),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 5),
        backgroundColor: Color.fromARGB(255, 60, 221, 208),
        showCloseIcon: true,
        closeIconColor: primaryBlack,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(width: 2, color: Color.fromARGB(255, 0, 177, 162)),
        ),
        content: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: widget.width,
              height: widget.height / 25,
              alignment: Alignment.center,
              child: Text(
                '¡Mensaje enviado correctamente!',
                style: TextStyle(
                  fontFamily: principalFontFamily,
                  //color: primaryBlack,
                  color: Color.fromARGB(255, 0, 61, 56),
                  fontWeight: FontWeight.bold,
                  fontSize: widget.width / 80,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRejectedSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: EdgeInsets.only(
          bottom: widget.height / 3,
          right: widget.width / 5,
          left: widget.width / 5,
        ),
        dismissDirection: DismissDirection.startToEnd,
        showCloseIcon: true,
        closeIconColor: primaryLight,
        behavior: SnackBarBehavior.floating,
        padding: EdgeInsets.zero,
        duration: Duration(seconds: 7),
        backgroundColor: Color.fromARGB(255, 255, 67, 130),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(width: 2, color: primaryBlack),
        ),
        content: Container(
          width: widget.width,
          height: widget.height / 15,
          alignment: Alignment.center,
          child: Text(
            '¡Ha ocurrido un error al enviar el mensaje!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: principalFontFamily,
              color: primaryLight,
              fontWeight: FontWeight.bold,
              fontSize: widget.width / 80,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _enviarMensaje() async {
    final success = await addBandejaDeEntrada(
      nameController.text,
      emailController.text,
      messageController.text,
    );

    if (success) {
       _showApprovedSnackBar();
    } else {
      _showRejectedSnackBar();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      width: widget.width,
      height: widget.height,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: widget.height / 4,
              right: widget.width / 5,
              left: widget.width / 5,
              bottom: widget.height / 5,
            ),
            width: widget.width,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    //color: Colors.red,
                    height: widget.height / 4,
                    child: LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        var containerMaxHeight = constraints.maxHeight;

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                height: containerMaxHeight,
                                child: Wrap(
                                  runAlignment: WrapAlignment.spaceBetween,
                                  children: [
                                    //IconButton(onPressed: _showApprovedSnackBar, icon: Icon(Icons.warning_rounded)),
                                    //IconButton(onPressed: _showRejectedSnackBar, icon: Icon(Icons.warning_rounded)),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: SelectableText(
                                        'Escribe un mensaje',
                                        style: TextStyle(
                                          fontFamily: principalFontFamily,
                                          fontSize: widget.height / 20,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: containerMaxHeight / 3,
                                      width: widget.width / 3.75,
                                      alignment: Alignment.center,
                                      child: TextFormField(
                                        controller: nameController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Campo de texto obligatorio';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Ingresa tu nombre',
                                        ),
                                        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                                        keyboardType: TextInputType.name,
                                        cursorColor: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      ),
                                    ),
                                    Container(
                                      height: containerMaxHeight / 3,
                                      width: widget.width / 3.75,
                                      alignment: Alignment.bottomCenter,
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Campo de texto obligatorio';
                                          } else if (!value.contains('@')) {
                                            return 'Ingresa un email válido';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Ingresa tu email',
                                        ),
                                        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                                        controller: emailController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        cursorColor: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Campo de texto obligatorio';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Digita el mensaje que quieres enviarme',
                                    alignLabelWithHint: true,
                                  ),
                                  style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                                  controller: messageController,
                                  keyboardType: TextInputType.text,
                                  cursorColor:
                                      Theme.of(context).colorScheme.onPrimary,
                                  textAlignVertical: TextAlignVertical.top,
                                  maxLines: containerMaxHeight.toInt(),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: widget.height / 30),
                    child: FilledButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _enviarMensaje();
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(widget.height / 100),
                        width: widget.width,
                        alignment: Alignment.center,
                        child: Text(
                          'Enviar',
                          style: TextStyle(
                            fontFamily: principalFontFamily,
                            color: primaryBlack,
                            fontWeight: FontWeight.bold,
                            fontSize: widget.height / 50,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: widget.width,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color.fromRGBO(100, 200, 245, 1),
                    width: widget.height / 100,
                  ),
                ),
              ),
              child: Image.asset(
                'assets/illustraciones/Waimakariri.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
