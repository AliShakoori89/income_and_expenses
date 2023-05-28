import 'package:income_and_expenses/model/income_model.dart';

import '../data_base/data_base.dart';

class IncomeRepository {

  late final DatabaseHelper helper;

  IncomeRepository() {
    helper = DatabaseHelper();
  }

  addIncome(IncomeModel incomeModel) async{
    return await helper.saveIncome(incomeModel);
  }

  Future<String> readIncome(String month) async {
    final String income = await helper.fetchIncomePerMonth(month) ?? "";
    return income;
  }
}