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
    print('daaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaate     $dateMonth');
    return await helper.calculateTotalExpenses(dateMonth);
  }

  Future<String> calculateSpentRepo() async {
    final prefs = await SharedPreferences.getInstance();
    final String? dateMonth = prefs.getString('dateMonth');
    final String? cash = prefs.getString('cash');
    print('daaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaate     $dateMonth'+ cash.toString());
    return await helper.calculateSpent(dateMonth , cash);
  }
}