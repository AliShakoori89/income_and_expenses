import 'package:shared_preferences/shared_preferences.dart';

class ChangeCurrencyRepository {

  writeCurrencyBoolean(bool currencyBoolean) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('CurrencyBoolean', currencyBoolean.toString());
  }

  Future<String?> readCurrencyBoolean() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('CurrencyBoolean');
  }
}