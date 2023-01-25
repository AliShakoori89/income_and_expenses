import 'package:shared_preferences/shared_preferences.dart';

class ChangeCurrencyRepository {

  writeRialCurrencyBoolean(bool rialCurrencyBoolean) async {
    final prefs = await SharedPreferences.getInstance();
    print("11111   "+rialCurrencyBoolean.toString());
    prefs.setString('rialCurrencyBoolean', rialCurrencyBoolean.toString());
  }

  Future<String?> readRialCurrencyBoolean() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('rialCurrencyBoolean');
  }
}