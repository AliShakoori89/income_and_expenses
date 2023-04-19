import 'package:shamsi_date/shamsi_date.dart';
import '../data_base/data_base.dart';

class CalculateSFCartesianChartRepository {
  late final DatabaseHelper helper;

  CalculateSFCartesianChartRepository() {
    helper = DatabaseHelper();
  }

  Future<String> calculateExpenseByGroupingTypePerMonthRepo(String year, String monthName ,String categoryPersianName) async {

    if(monthName == "1"){
      return await helper.calculateCategoryTypeExpensesPerMonth("$year-01", categoryPersianName);
    }else if(monthName == "2"){
      return await helper.calculateCategoryTypeExpensesPerMonth("$year-02", categoryPersianName);
    }else if(monthName == "3"){
      return await helper.calculateCategoryTypeExpensesPerMonth("$year-03", categoryPersianName);
    }else if(monthName == "4"){
      return await helper.calculateCategoryTypeExpensesPerMonth("$year}-04", categoryPersianName);
    }else if(monthName == "5"){
      return await helper.calculateCategoryTypeExpensesPerMonth("$year-05", categoryPersianName);
    }else if(monthName == "6"){
      return await helper.calculateCategoryTypeExpensesPerMonth("$year-06", categoryPersianName);
    }else if(monthName == "7"){
      return await helper.calculateCategoryTypeExpensesPerMonth("$year-07", categoryPersianName);
    }else if(monthName == "8"){
      return await helper.calculateCategoryTypeExpensesPerMonth("$year-08", categoryPersianName);
    }else if(monthName == "9"){
      return await helper.calculateCategoryTypeExpensesPerMonth("$year-09", categoryPersianName);
    }else if(monthName == "10"){
      return await helper.calculateCategoryTypeExpensesPerMonth("$year-10", categoryPersianName);
    }else if(monthName == "11"){
      return await helper.calculateCategoryTypeExpensesPerMonth("$year-11", categoryPersianName);
    }else{
      return await helper.calculateCategoryTypeExpensesPerMonth("$year-12", categoryPersianName);
    }
  }
}