
import 'package:income_and_expenses/data/data_base/data_base.dart';

class CalculateSFCircularChartRepository {
  late final DatabaseHelper helper;

  CalculateSFCircularChartRepository() {
    helper = DatabaseHelper();
  }

  Future<String> calculateExpensePerMonthRepo(String year, String monthName) async {

    if(monthName == "farvardin"){
      return await helper.calculateTotalExpenses("$year-01");
    }else if(monthName == "ordibehesht"){
      return await helper.calculateTotalExpenses("$year-02");
    }else if(monthName == "khordad"){
      return await helper.calculateTotalExpenses("$year-03");
    }else if(monthName == "tir"){
      return await helper.calculateTotalExpenses("$year-04");
    }else if(monthName == "mordad"){
      return await helper.calculateTotalExpenses("$year-05");
    }else if(monthName == "shahrivar"){
      return await helper.calculateTotalExpenses("$year-06");
    }else if(monthName == "mehr"){
      return await helper.calculateTotalExpenses("$year-07");
    }else if(monthName == "aban"){
      return await helper.calculateTotalExpenses("$year-08");
    }else if(monthName == "azar"){
      return await helper.calculateTotalExpenses("$year-09");
    }else if(monthName == "dey"){
      return await helper.calculateTotalExpenses("$year-10");
    }else if(monthName == "bahman"){
      return await helper.calculateTotalExpenses("$year-11");
    }else{
      return await helper.calculateTotalExpenses("$year-12");
    }
  }
}