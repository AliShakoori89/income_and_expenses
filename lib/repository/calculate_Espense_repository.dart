import 'package:income_and_expenses/data_base/data_base.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalculateExpensesRepository {

  late final DatabaseHelper helper;

  CalculateExpensesRepository() {
    helper = DatabaseHelper();
  }

  Future<String> calculateExpenseRepo(String dateMonth) async {
    // final prefs = await SharedPreferences.getInstance();
    // final String? dateMonth = prefs.getString('dateMonth');
    return await helper.calculateTotalExpenses(dateMonth.toString());
  }

  Future<String> calculateCashRepo(String dateMonth) async {
    final prefs = await SharedPreferences.getInstance();

    // final String? dateMonth = prefs.getString('dateMonth');
    // var month = prefs.getString('month');
    final String? income = prefs.getString('income$dateMonth');
    return await helper.calculateCash(dateMonth.toString() , income);
  }
}