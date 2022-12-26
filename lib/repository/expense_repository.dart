import 'package:income_and_expenses/data_base/data_base.dart';
import 'package:income_and_expenses/model/expense_model.dart';

class ExpenseRepository {
  late final DatabaseHelper helper;

  ExpenseRepository() {
    helper = DatabaseHelper();
  }

  Future<List<ExpenseModel>> getAllExpensesRepo() async {
    return await helper.getAllMedicines();
  }

  Future<bool> addExpenseRepo(ExpenseModel expenseModel) async {
    print('save save save save save save ');
    return await helper.saveExpense(expenseModel);
  }
}
