import 'package:shared_preferences/shared_preferences.dart';

class ChangeThemeRepository {

  var bottomNavIndex = 0;

  writeThemeBoolean(bool themeBoolean) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('ThemeBoolean', themeBoolean.toString());
  }

  Future<String?> readThemeBoolean() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('ThemeBoolean');
  }

  int changePage(int index){
    bottomNavIndex = index;
    return bottomNavIndex;
  }

  onTapNav(int index){
    bottomNavIndex = index;
  }
}