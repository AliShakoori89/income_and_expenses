import 'package:shared_preferences/shared_preferences.dart';

class IncomeRepository {

  addIncome(String income, String month) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('month', month);
    prefs.setString('income$month', income);
  }

  Future<String?> readIncome() async {
    final prefs = await SharedPreferences.getInstance();
    var month = prefs.getString('month');
    return prefs.getString('income$month');
  }
}