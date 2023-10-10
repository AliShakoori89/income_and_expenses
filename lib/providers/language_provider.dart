import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage extends ChangeNotifier {
  Locale _appLocale = Locale('fa');

  Locale get appLocal => _appLocale;
  fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      print('11111111111');
      _appLocale = Locale('fa');
      return Null;
    }
    _appLocale = Locale(prefs.getString('language_code')!);
    print('222222222222');
    return Null;
  }


  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    print("tyyyyyyyyyyyyyyyyyyype           "+type.toString());
    if (_appLocale == type) {
      print('33333333333');
      return;
    }
    if (type == Locale("en")) {
      print('44444444444');

      _appLocale = Locale("en");
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', '');

    } else {
      print('55555555555');
      _appLocale = Locale("fa");
      await prefs.setString('language_code', 'fa');
      await prefs.setString('countryCode', 'US');
    }
    notifyListeners();
  }
}