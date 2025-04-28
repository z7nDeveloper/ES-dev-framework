

import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

extension ColorExtension on Color {
  Color darken({int percent = 10}) {
    assert(1 <= percent && percent <= 100);
    var f = percent / 100;
    return Color.fromARGB(
        alpha,
        (red * f).round(),
        (green  * f).round(),
        (blue * f).round()
    );
  }

  Color lighten({int percent = 10}) {
    assert(1 <= percent && percent <= 100);
    var f =  (percent) / 100;
    return Color.fromARGB(
        alpha,

        (red + red * f).round(),
        (green  + green* f).round(),
        (blue + blue * f).round()
    );
  }

  Color invert() => Color.fromARGB(alpha, 255 - red, 255 - green, 255 - blue);




  static Color? maybeColor(int? colorCode) {

    try {
      Color color = Color(colorCode!);
      return color;
    } catch (err) {

    }
    return null;
  }

  static Color random() {
    return Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  }

}
