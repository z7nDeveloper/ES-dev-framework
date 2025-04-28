

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class SvgFileLoader {
  final String svgPath;
  final Color? defaultColor;


  static const int defaultIconSize = 20;
  static const Color defaultIconColor = Color(0xffEEEEEE);

  static String getSvgPath(name) {
    return "assets/icons/$name.svg";
  }

  SvgFileLoader({required this.svgPath, this.defaultColor});

  SvgPicture call({size, width , height, color, BoxFit? fit,}) {

    width ??= defaultIconSize;

    return SvgPicture.asset(
      getSvgPath(svgPath),
      width: size ?? width ,
      height: size ?? height ?? width,
      fit: fit ?? BoxFit.contain,
      color: color ?? (defaultColor ?? defaultIconColor),
    );
  }
}