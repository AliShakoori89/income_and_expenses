import 'package:shared_preferences/shared_preferences.dart';

class CashRepository {
  addCash(String cash) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('cash', cash);
  }

  Future<String?> readCash() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('cash');
  }

  Future<String?> allExpenses(String date, String expense) async {
    DateTime time = DateTime.parse(date);
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('cash');
  }
}