import 'package:shared_preferences/shared_preferences.dart';

class ChangeLanguageRepository {

  bool changeLanguageToPersianRepository(bool value){
    return value;
  }

  bool changeLanguageToEnglishRepository(bool value){
    return value;
  }

  writeLanguageBoolean(bool languageBoolean) async {
    final prefs = await SharedPreferences.getInstance();
    print("languageBoolean              "+languageBoolean.toString());
    await prefs.setString('languageBoolean', languageBoolean.toString());
  }

  Future<String?> readLanguageBoolean() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('languageBoolean');
  }
}