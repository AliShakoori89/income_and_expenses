import 'package:shamsi_date/shamsi_date.dart';
import '../data_base/data_base.dart';

class CalculateSFCartesianChartRepository {
  late final DatabaseHelper helper;

  CalculateSFCartesianChartRepository() {
    helper = DatabaseHelper();
  }

  Future<String> calculateExpenseByGroupingTypePerMonthRepo(String monthName ,String categoryPersianName) async {

    var date = DateTime.now();
    Gregorian g = Gregorian(date.year, date.month, date.day);
    Jalali g2j1 = g.toJalali();

    if(monthName == "فروردین"){
      return await helper.calculateCategoryTypeExpensesPerMonth("${g2j1.formatter.y}-01", categoryPersianName);
    }else if(monthName == "اردیبهشت"){
      return await helper.calculateCategoryTypeExpensesPerMonth("${g2j1.formatter.y}-02", categoryPersianName);
    }else if(monthName == "خرداد"){
      return await helper.calculateCategoryTypeExpensesPerMonth("${g2j1.formatter.y}-03", categoryPersianName);
    }else if(monthName == "تیر"){
      return await helper.calculateCategoryTypeExpensesPerMonth("${g2j1.formatter.y}-04", categoryPersianName);
    }else if(monthName == "مرداد"){
      return await helper.calculateCategoryTypeExpensesPerMonth("${g2j1.formatter.y}-05", categoryPersianName);
    }else if(monthName == "شهریور"){
      return await helper.calculateCategoryTypeExpensesPerMonth("${g2j1.formatter.y}-06", categoryPersianName);
    }else if(monthName == "مهر"){
      return await helper.calculateCategoryTypeExpensesPerMonth("${g2j1.formatter.y}-07", categoryPersianName);
    }else if(monthName == "آبان"){
      return await helper.calculateCategoryTypeExpensesPerMonth("${g2j1.formatter.y}-08", categoryPersianName);
    }else if(monthName == "آذر"){
      return await helper.calculateCategoryTypeExpensesPerMonth("${g2j1.formatter.y}-09", categoryPersianName);
    }else if(monthName == "دی"){
      return await helper.calculateCategoryTypeExpensesPerMonth("${g2j1.formatter.y}-10", categoryPersianName);
    }else if(monthName == "بهمن"){
      print("***************************");
      return await helper.calculateCategoryTypeExpensesPerMonth("${g2j1.formatter.y}-11", categoryPersianName);
    }else{
      return await helper.calculateCategoryTypeExpensesPerMonth("${g2j1.formatter.y}-12", categoryPersianName);
    }
  }
}