
import 'package:shared_preferences/shared_preferences.dart';

class ChangeLanguageRepository {

  bool changeLanguageRepository(bool value){
    value = !value;
    return value;
  }

  writeLanguageBoolean(bool languageBoolean) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('languageBoolean', languageBoolean.toString());
  }

  Future<String?> readCashLanguageBoolean() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('languageBoolean');
  }
}