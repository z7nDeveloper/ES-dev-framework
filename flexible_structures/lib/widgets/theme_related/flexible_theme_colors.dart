



import 'package:flutter/material.dart';

abstract class FlexibleThemeColors {


  Color getBlack();

  Color getTextContrastToBackground();

  getCardColor() {
    return Color(0xff222222);
  }

  Color getIncorrectColor() {
    return Colors.red.shade700;
  }

  Color getSlightDeactivatedColor();
  Color getDeactivatedColor();

  Color getAppBackgroundColor();

  Color getDarkLight();

  Color getMainColor();

  Color getLighterMainColor() {
    return getMainColor();
  }

  Color getClickableBlue(bool background) {
    if(background) {
      return getMainColor();
    }
    return getAppBackgroundColor();
  }



  Color getDarkMainColor();

  Color getReadableGray();


  Color? getWhiteBoxBackgroundColor() {
    return null;
  }

}