



import 'package:flutter/cupertino.dart';

extension AxisExtension on Axis {


  reversed() {

    if(this == Axis.horizontal) {
      return Axis.vertical;
    }

    return Axis.horizontal;
  }

}