import 'package:income_and_expenses/data_base/data_base.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalculateExpensesRepository {

  late final DatabaseHelper helper;

  CalculateExpensesRepository() {
    helper = DatabaseHelper();
  }

  Future<String> calculateExpenseRepo() async {
    final prefs = await SharedPreferences.getInstance();
    final String? date = prefs.getString('date');
    print('daaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaate     $date');
    return await helper.calculateTotalExpenses(date);
  }

  Future<String> calculateSpentRepo() async {
    final prefs = await SharedPreferences.getInstance();
    final String? date = prefs.getString('date');
    final String? cash = prefs.getString('cash');
    print('daaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaate     $date'+ cash.toString());
    return await helper.calculateSpent(date , cash);
  }
}