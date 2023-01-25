import 'package:income_and_expenses/data_base/data_base.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalculateExpensesRepository {

  late final DatabaseHelper helper;

  CalculateExpensesRepository() {
    helper = DatabaseHelper();
  }

  Future<String> calculateTomanExpenseRepo() async {
    final prefs = await SharedPreferences.getInstance();
    final String? dateMonth = prefs.getString('dateMonth');
    return await helper.calculateTotalTomanExpenses(dateMonth);
  }

  Future<String> calculateRialExpenseRepo() async {
    final prefs = await SharedPreferences.getInstance();
    final String? dateMonth = prefs.getString('dateMonth');
    return await helper.calculateTotalRialExpenses(dateMonth);
  }

  Future<String> calculateTomanCashRepo() async {
    final prefs = await SharedPreferences.getInstance();
    final String? dateMonth = prefs.getString('dateMonth');
    final String? income = prefs.getString('income');
    return await helper.calculateTomanCash(dateMonth , income);
  }

  Future<String> calculateRialCashRepo() async {
    final prefs = await SharedPreferences.getInstance();
    final String? dateMonth = prefs.getString('dateMonth');
    final String? income = prefs.getString('income');
    return await helper.calculateRialCash(dateMonth , income);
  }
}