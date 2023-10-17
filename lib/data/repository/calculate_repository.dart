import 'package:income_and_expenses/data/data_base/data_base.dart';

class CalculateRepository {

  late final DatabaseHelper helper;

  CalculateRepository() {
    helper = DatabaseHelper();
  }

  Future<String> calculateExpenseRepo(String month) async {
    return await helper.calculateTotalExpenses(month.toString());
  }

  Future<String> calculateDayExpenseRepo(String date) async {
    return await helper.calculateDayExpenses(date.toString());
  }

  Future<String> calculateCash(String month) async {
    final String income = await helper.fetchIncomePerMonth(month) ?? "";
    String cash = await helper.calculateCash(month.toString() , income);
    return cash;
  }
}