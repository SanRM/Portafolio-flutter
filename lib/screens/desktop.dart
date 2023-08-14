import 'package:flutter/material.dart';
import 'package:portafolio/components/Header.dart';
import 'package:portafolio/styles/Responsive/responsive.dart';

class Desktop extends StatefulWidget {
  const Desktop({super.key});

  @override
  State<Desktop> createState() => _DesktopState();
}

class _DesktopState extends State<Desktop> {
  @override
  Widget build(BuildContext context) {

    double height = Responsive(context: context).getDeviceHeight();
    double width = Responsive(context: context).getDeviceWidth();

    return Scaffold(
      appBar: Header(height: height, width: width)
      );
    
  }
}