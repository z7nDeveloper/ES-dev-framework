



import 'package:flutter/cupertino.dart';

import 'language_controller.dart';

class AppLanguageControl {
  static LanguageController languageController = LanguageController();

  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<LanguageControllerAppState>();
    state?.setLocale(newLocale);
  }
}

abstract class LanguageControllerAppState<T extends StatefulWidget> extends State<T> {
  Future<void> setLocale(Locale locale);
}