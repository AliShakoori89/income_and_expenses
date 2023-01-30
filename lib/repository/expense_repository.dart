import 'package:income_and_expenses/data_base/data_base.dart';
import 'package:income_and_expenses/model/expense_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseRepository {
  late final DatabaseHelper helper;

  ExpenseRepository() {
    helper = DatabaseHelper();
  }

  Future<List<ExpenseModel>> getAllExpensesRepo() async {
    final prefs = await SharedPreferences.getInstance();
    final String? date = prefs.getString('date');
    return await helper.getAllExpenses(date!);
  }

  Future<bool> addExpenseRepo(ExpenseModel expenseModel) async {
    return await helper.saveExpense(expenseModel);
  }

  addTodayExpensesRepo(int todayExpenses) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('todayExpenses', todayExpenses.toString());
  }

  Future<String?> readTodayExpensesRepo() async {
    final prefs = await SharedPreferences.getInstance();
    final String? todayExpenses = prefs.getString('todayExpenses');
    return todayExpenses;
  }
}
