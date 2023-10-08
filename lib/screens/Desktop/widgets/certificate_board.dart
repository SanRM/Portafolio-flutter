// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:portafolio/screens/Desktop/widgets/certificate_utilities.dart';
import 'package:portafolio/styles/styles.dart';

GlobalKey globalKeyCertificatesBoard = GlobalKey();

class CertificatesBoard extends StatefulWidget {
  const CertificatesBoard({
    super.key,
    required this.width,
    required this.height,
    required this.snapshot,
  });

  final double width;
  final double height;
  final AsyncSnapshot<List<dynamic>> snapshot;

  @override
  State<CertificatesBoard> createState() => _CertificatesBoardState();
}

class _CertificatesBoardState extends State<CertificatesBoard> {
  List<dynamic> labels = [];
  List<CertificateManager> proyectos = [];
  List<CertificateManager> projectSelected = [];
  String setActualFilter = '';
  bool mostrarTodosIsSelected = false;
  int _selectedIndex = -1;

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < widget.snapshot.data!.length; i++) {
      
      var certificateDescription = widget.snapshot.data?[i]["description"];
      var certificateLabels = widget.snapshot.data?[i]["labels"];
      var certificateTitle = widget.snapshot.data?[i]["title"];
      var certificateUrl = widget.snapshot.data?[i]["Url"];

      proyectos.add(CertificateManager(
        snapshot: widget.snapshot,
        description: certificateDescription,
        labels: certificateLabels,
        title: certificateTitle,
        url: certificateUrl
      ));
    }

    labels = CertificateLabels(snapshot: widget.snapshot).getLabelsList();
  
    _mostrarTodos();
  
  }

  void _selectButtonLabel(labelSelected, projects) {
    setState(() {
      projectSelected = [];
    });

    Future.delayed(const Duration(milliseconds: 10), () {
      setState(() {
        projectSelected = CertificatesFilter(snapshot: widget.snapshot).getSimilitudes(labelSelected);
        //print(projectSelected);
      });
    });
  }

  void _mostrarTodos() {
    setState(() {
      projectSelected = [];
      setActualFilter = '';

      mostrarTodosIsSelected == false
          ? mostrarTodosIsSelected = true
          : mostrarTodosIsSelected = false;
    });
    Future.delayed(const Duration(milliseconds: 10), () {
      setState(() {
        projectSelected = proyectos;
        //print(projectSelected);
      });
    });
  }

  void _selectLabel(int index) {
    setState(() {
      _selectedIndex = index;
      mostrarTodosIsSelected = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      key: globalKeyCertificatesBoard,
      //height: widget.height * 2,
      color: const Color.fromRGBO(162, 195, 195, 1),
      padding: projectBoardPadding,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: primaryBlack,
              blurRadius: 10,
              offset: Offset(2, 2), // Shadow position
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadiusSecondary),
          child: Container(
            padding: EdgeInsets.only(bottom: widget.height / 200),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: widget.width / 20,
                      right: widget.width / 20,
                      top: widget.height / 50),
                  child: SizedBox(
                    width: widget.width,
                    //color: Colors.red,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: widget.height / 100,
                              bottom: widget.height / 100),
                          child: SizedBox(
                            width: widget.width,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: containerPadding),
                                  child: Icon(
                                    Icons.filter_alt_rounded,
                                    size: widget.width / 60,
                                    color: const Color.fromARGB(
                                      255,
                                      253,
                                      247,
                                      167,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                        containerPadding),
                                    child: Wrap(
                                      children: [
                                        SelectableText(
                                            'Filtrar certificados según tecnologías estudiadas',
                                            style: TextStyle(
                                                color: primaryLight,
                                                fontSize:
                                                    widget.width / 40)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Wrap(
                          runSpacing: widget.height / 100,
                          children: [
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                List<Widget> botones = [];

                                for (var i = 0; i < labels.length; i++) {
                                  var label = labels[i];

                                  botones.add(
                                    TextButton(
                                      onPressed: () {
                                        _selectButtonLabel(labels[i], proyectos);
                                        _selectLabel(i);
                                        setState(() {
                                          setActualFilter = labels[i];
                                        });
                                      },
                                      //ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red))
                                      style: _selectedIndex == i
                                          ? const ButtonStyle(
                                              padding: MaterialStatePropertyAll(
                                                  paddingAll),
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                tertiary,
                                              ),
                                            )
                                          : ButtonStyle(
                                              padding: const MaterialStatePropertyAll(
                                                  paddingAll),
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                              ),
                                              shape: MaterialStatePropertyAll(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          borderRadiusPrimary),
                                                  side: const BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 139, 139, 139),
                                                  ),
                                                ),
                                              ),
                                            ),
                                      child: _selectedIndex == i
                                          ? Text(
                                              '$label',
                                              style: TextStyle(
                                                  fontFamily:
                                                      principalFontFamily,
                                                  color: primaryBlack,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: widget.width / 100),
                                            )
                                          : Text(
                                              '$label',
                                              style: TextStyle(
                                                  fontFamily:
                                                      principalFontFamily,
                                                  color: primaryLight,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: widget.width / 100),
                                            ),
                                    ),
                                  ); // Agrega widgets a la lista
                                }

                                return Wrap(
                                  spacing: widget.width / 100,
                                  runSpacing: widget.height / 50,
                                  alignment: WrapAlignment.start,
                                  children: botones,
                                );
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: widget.height / 100,
                                  right: widget.width / 40,
                                  bottom: widget.width / 50),
                              child: Row(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        //print('mostrar todos');
                                        _mostrarTodos();
                                        _selectedIndex = -1;
                                        //_mostrarTodosSelected();
                                      });
                                    },
                                    style: mostrarTodosIsSelected == true
                                        ? const ButtonStyle(
                                            padding: MaterialStatePropertyAll(
                                                paddingAll),
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    tertiary))
                                        : const ButtonStyle(
                                            padding: MaterialStatePropertyAll(
                                                paddingAll),
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Color.fromRGBO(
                                                        168, 167, 255, 1))),
                                    child: Text(
                                      'Mostrar todo',
                                      style: TextStyle(
                                          fontFamily: principalFontFamily,
                                          color: primaryBlack,
                                          fontWeight: FontWeight.bold,
                                          fontSize: widget.width / 100),
                                    ),
                                  ),
                                  setActualFilter != ''
                                      ? Container(
                                          padding: EdgeInsets.only(
                                              left: widget.width / 100),
                                          child: Row(
                                            children: [
                                              Container(
                                                //color: Colors.amber,
                                                padding: EdgeInsets.only(
                                                    right: widget.width / 200),
                                                child: Icon(
                                                  Icons.star_rate_rounded,
                                                  size: widget.width / 80,
                                                  color: const Color.fromARGB(
                                                      255, 54, 244, 187),
                                                ),
                                              ),
                                              Text(
                                                'Proyectos desarrollados con $setActualFilter',
                                                style: TextStyle(
                                                    fontFamily:
                                                        principalFontFamily,
                                                    fontSize:
                                                        widget.width / 100,
                                                    color: primaryLight),
                                              )
                                            ],
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  //color: Colors.purple,
                  width: widget.width,
                  height: widget.height / 1.7,
                  padding: EdgeInsets.only(
                      left: widget.width / 20,
                      right: widget.width / 20,
                      bottom: widget.height / 15),
                  // child: RawScrollbar(
                  //   timeToFade: Duration(microseconds: 1),
                  //   thumbColor: Color.fromARGB(137, 0, 141, 151),
                  //   trackColor: Color.fromRGBO(54, 54, 54, 1),
                  //   trackRadius: Radius.circular(10),
                  //   trackVisibility: true,
                  //   thumbVisibility: true,
                  //   radius: Radius.circular(10),
                  //   thickness: 5,

                  child: Theme(
                    data: Theme.of(context).copyWith(
                      scrollbarTheme: const ScrollbarThemeData(
                          thickness: MaterialStatePropertyAll(10),
                          thumbColor: MaterialStatePropertyAll(
                              Color.fromARGB(137, 0, 141, 151)),
                          //trackColor: MaterialStatePropertyAll(Color.fromRGBO(114, 114, 114, 1)),
                          trackVisibility: MaterialStatePropertyAll(true),
                          thumbVisibility: MaterialStatePropertyAll(true)),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Wrap(
                          spacing: widget.width / 30,
                          runSpacing: widget.height / 15,
                          alignment: WrapAlignment.start,
                          children: projectSelected),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
