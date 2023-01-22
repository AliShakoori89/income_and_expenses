import 'package:income_and_expenses/data_base/data_base.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalculateExpensesRepository {

  late final DatabaseHelper helper;

  CalculateExpensesRepository() {
    helper = DatabaseHelper();
  }

  Future<String> calculateExpenseRepo() async {
    final prefs = await SharedPreferences.getInstance();
    final String? dateMonth = prefs.getString('dateMonth');
    return await helper.calculateTotalTomanExpenses(dateMonth);
  }

  Future<String> calculateSpentRepo() async {
    final prefs = await SharedPreferences.getInstance();
    final String? dateMonth = prefs.getString('dateMonth');
    final String? cash = prefs.getString('cash');
    return await helper.calculateTomanSpent(dateMonth , cash);
  }
}