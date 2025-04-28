

import 'package:common_extensions/extensions/basic_types/for_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LanguageController extends Listenable {
  static String defaultCode = 'pt';
  static String prefSelectedLanguageCode = "SelectedLanguageCode";
  late Locale _locale;

  LanguageController({Locale? locale}) {
    _locale = locale ?? Locale(defaultCode);
  }

  Locale get locale => _locale;

  Future<Locale> setLocale(String languageCode) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(prefSelectedLanguageCode, languageCode);
    _locale = Locale(languageCode);

    return _locale;
  }

  static localeWasSelected() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(prefSelectedLanguageCode) != null;
  }

  void changeLanguage(BuildContext context, String selectedLanguageCode) async {
    await setLocale(selectedLanguageCode);
    //ATechMyApp.setLocale(context, _locale);
    for (Function listener in listeners) {
      listener();
    }
  }

  static Future<Locale> getLocale() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String languageCode =
        _prefs.getString(prefSelectedLanguageCode) ?? defaultCode;
    return Locale(languageCode);
  }

  static getLocaleDisplay(String languageCode) {
    debugPrint("language:> " + languageCode);
    //debugPrint(LocaleNamesLocalizationsDelegate.nativeLocaleNames.toString());
    String display =
        LocaleNamesLocalizationsDelegate.nativeLocaleNames[languageCode]!;

    return display.capitalize ?? "";
    return "";
  }

  List<Function> listeners = [];
  @override
  void addListener(Function listener) {
    listeners.add(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    listeners.remove(listener);
  }
}
