import 'package:flutter/material.dart';
import 'package:portafolio/styles/Responsive/responsive.dart';

class Tablet extends StatefulWidget {
  const Tablet({super.key});

  @override
  State<Tablet> createState() => _TabletState();
}

class _TabletState extends State<Tablet> {
  @override
  Widget build(BuildContext context) {

    double height = Responsive(context: context).getDeviceHeight();
    double width = Responsive(context: context).getDeviceWidth();

    return Scaffold(
      );
    
  }
}