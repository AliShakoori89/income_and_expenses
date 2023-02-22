import 'package:shamsi_date/shamsi_date.dart';
import '../data_base/data_base.dart';

class CalculateSFCartesianChartRepository {
  late final DatabaseHelper helper;

  CalculateSFCartesianChartRepository() {
    helper = DatabaseHelper();
  }

  Future<String> calculateExpenseByGroupingTypePerMonthRepo(String monthName, String categoryName) async {

    var date = DateTime.now();
    Gregorian g = Gregorian(date.year, date.month, date.day);
    Jalali g2j1 = g.toJalali();

    if(monthName == "farvardin"){
      return await helper.calculateCategoryTypeExpensesPerMonth("${g2j1.formatter.y}-01");
    }else if(monthName == "ordibehesht"){
      return await helper.calculateCategoryTypeExpensesPerMonth("${g2j1.formatter.y}-02");
    }else if(monthName == "khordad"){
      return await helper.calculateCategoryTypeExpensesPerMonth("${g2j1.formatter.y}-03");
    }else if(monthName == "tir"){
      return await helper.calculateCategoryTypeExpensesPerMonth("${g2j1.formatter.y}-04");
    }else if(monthName == "mordad"){
      return await helper.calculateCategoryTypeExpensesPerMonth("${g2j1.formatter.y}-05");
    }else if(monthName == "shahrivar"){
      return await helper.calculateCategoryTypeExpensesPerMonth("${g2j1.formatter.y}-06");
    }else if(monthName == "mehr"){
      return await helper.calculateCategoryTypeExpensesPerMonth("${g2j1.formatter.y}-07");
    }else if(monthName == "aban"){
      return await helper.calculateCategoryTypeExpensesPerMonth("${g2j1.formatter.y}-08");
    }else if(monthName == "azar"){
      return await helper.calculateCategoryTypeExpensesPerMonth("${g2j1.formatter.y}-09");
    }else if(monthName == "dey"){
      return await helper.calculateCategoryTypeExpensesPerMonth("${g2j1.formatter.y}-10");
    }else if(monthName == "bahman"){
      return await helper.calculateCategoryTypeExpensesPerMonth("${g2j1.formatter.y}-11");
    }else{
      return await helper.calculateCategoryTypeExpensesPerMonth("${g2j1.formatter.y}-12");
    }
  }
}