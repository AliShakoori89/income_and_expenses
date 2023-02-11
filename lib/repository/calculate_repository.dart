import 'package:income_and_expenses/data_base/data_base.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalculateRepository {

  late final DatabaseHelper helper;

  CalculateRepository() {
    helper = DatabaseHelper();
  }

  Future<String> calculateExpenseRepo(String dateMonth) async {
    // final prefs = await SharedPreferences.getInstance();
    // final String? dateMonth = prefs.getString('dateMonth');
    return await helper.calculateTotalExpenses(dateMonth.toString());
  }

  Future<String> calculateCashRepo(String dateMonth) async {
    final prefs = await SharedPreferences.getInstance();
    final String income = prefs.getString('income$dateMonth') ?? "";
    String cash = await helper.calculateCash(dateMonth.toString() , income);
    print("cash             "+cash);
    return cash;
  }
}