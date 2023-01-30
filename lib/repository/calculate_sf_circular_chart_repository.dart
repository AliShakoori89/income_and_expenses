import '../data_base/data_base.dart';
import '../model/expense_model.dart';

class CalculateSFCircularChartRepository {
  late final DatabaseHelper helper;

  CalculateSFCircularChartRepository() {
    helper = DatabaseHelper();
  }


  Future<bool> addExpenseRepo(ExpenseModel expenseModel) async {
    return await helper.saveExpense(expenseModel);
  }
}