import 'package:income_and_expenses/data_base/data_base.dart';
import 'package:income_and_expenses/model/expense_model.dart';

class ExpenseRepository {
  late final DatabaseHelper helper;

  ExpenseRepository() {
    helper = DatabaseHelper();
  }

  Future<List<ExpenseModel>> getAllExpensesRepo() async {
    return await helper.getAllExpenses();
  }

  Future<bool> addExpenseRepo(ExpenseModel expenseModel) async {
    return await helper.saveExpense(expenseModel);
  }
}
