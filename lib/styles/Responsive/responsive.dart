import 'package:flutter/material.dart';
import 'package:portafolio/screens/desktop.dart';
import 'package:portafolio/screens/tablet.dart';
import 'package:portafolio/screens/mobile.dart';

class Responsive {

  BuildContext? _context;

  Responsive({required BuildContext context}) {
    _context = context;
  }

  getContext() {
    return _context;
  }

  getDeviceWidth(){
    return MediaQuery.of(getContext()).size.width;
  }

  getDeviceHeight(){
    return MediaQuery.of(getContext()).size.height;
  }

  Widget getDevice() {
    double actualWidth = MediaQuery.of(getContext()).size.width;

    if (actualWidth < 450) {
      return const Mobile();
    } else if (actualWidth > 450 && actualWidth < 1440) {
      return const Tablet();
    } else {
      return const Desktop();
    }

  }

}
