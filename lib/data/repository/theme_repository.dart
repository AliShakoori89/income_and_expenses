import 'package:shared_preferences/shared_preferences.dart';

class ChangeThemeRepository {

  writeThemeBoolean(bool themeBoolean) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('ThemeBoolean', themeBoolean.toString());
  }

  Future<String?> readThemeBoolean() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('ThemeBoolean');
  }
}