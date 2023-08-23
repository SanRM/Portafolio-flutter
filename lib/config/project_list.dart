
import 'package:flutter/material.dart';
import 'package:portafolio/globalWidgets/project_manager.dart';

//10. Etiquetas disponibles en el proyecto

List labels = ['HTML', 'CSS', 'JavaScript', 'Java'];


//6. Etiquetas disponibles en el proyecto

List<Widget> proyectos = [

    const ProjectManager(
        cardBgColor:  Color.fromARGB(255, 105, 214, 247),
        projectTitle: 'Encriptador de texto',
        projectBanner: 'assets/images/preview.png',
        projectDescription: 'Descripción proyecto',
        projectLabels: const ['HTML', 'CSS', 'JavaScript'],
        projectLink: 'https://github.com/SanRM/Encriptador',
        ),

    const ProjectManager(
      cardBgColor: Colors.pink,
      projectTitle: 'Proyecto creado con Java',
      projectBanner: '',
      projectDescription: 'a',
      projectLabels: const ['Java'],
      projectLink: 'https://github.com/SanRM/Conversor',
    ),

    const ProjectManager(
      cardBgColor: Color.fromARGB(255, 30, 233, 165),
      projectTitle: 'Proyecto creado con Java version 2',
      projectBanner: '',
      projectDescription: 'asd',
      projectLabels: const ['Java'],
      projectLink: 'https://github.com/SanRM/Conversor',
    ),

    const ProjectManager(
      cardBgColor: Color.fromARGB(255, 65, 95, 226),
      projectTitle: 'Proyecto creado con HTML',
      projectBanner: '',
      projectDescription: 'asd',
      projectLabels: const ['HTML'],
      projectLink: 'https://github.com/SanRM/Conversor',
    ),

];