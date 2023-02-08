import 'package:shared_preferences/shared_preferences.dart';

class IncomeRepository {

  addIncome(String income, String month) async {
    print("income income income income      "+income);
    print("month month month month      "+month);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('month', month);
    prefs.setString('income$month', income);
  }

  Future<String?> readIncome(String month) async {
    final prefs = await SharedPreferences.getInstance();
    // var month = prefs.getString('month');
    print("month month month month   readIncome   "+month.toString());
    print("income$month income$month income$month income$month   readIncome   " 'income$month');
    return prefs.getString('income$month');
  }
}