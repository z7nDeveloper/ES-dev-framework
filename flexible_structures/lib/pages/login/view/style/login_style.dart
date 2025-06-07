


import 'package:flexible_structures/widgets/layout/quadruple_screen.dart';
import 'package:flutter/material.dart';

class LoginStyle {


  bool isLogoCentered() {
    return false;
  }
  Color? getBodyBackgroundColor() {
    return null;
  }

  List<int> getStructureFlex() {
    return [1,12,1];
  }

  QuadrupleFlex getQuadrupleFlex() {
    return QuadrupleFlex(2, 4, 1, 1);
  }

  double? getMaxWidth() {
    return 480;
  }


}