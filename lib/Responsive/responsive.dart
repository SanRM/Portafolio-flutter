import 'package:flutter/material.dart';
import 'package:portafolio/screens/Desktop/desktop.dart';
import 'package:portafolio/screens/Mobile/mobile.dart';

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

    if (getDeviceHeight() > getDeviceWidth()) {
      return const Mobile();
    } else {
      return const Desktop();
    }

  }

  // String getDevice() {

  //   if (getDeviceHeight() > getDeviceWidth()) {
  //     return 'Mobile';
  //   } else {
  //     return 'Desktop';
  //   }

  // }

}
