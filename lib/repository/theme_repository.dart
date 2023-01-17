import 'package:shared_preferences/shared_preferences.dart';

class ChangeThemeRepository {

  writeThemeBoolean(bool languageBoolean) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('ThemeBoolean', languageBoolean.toString());
  }

  Future<String?> readThemeBoolean() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('ThemeBoolean');
  }
}