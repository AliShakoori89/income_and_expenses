import 'package:income_and_expenses/data_base/data_base.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/expense_model.dart';

class SetDateRepository {

  late final DatabaseHelper helper;

  SetDateRepository() {
    helper = DatabaseHelper();
  }

  initialDate() async{
    final prefs = await SharedPreferences.getInstance();
    String dateMonthString = '${Jalali.now().year}-${Jalali.now().month}';
    String dateString = '${Jalali.now().year}-${Jalali.now().month}-${Jalali.now().day}';
    await prefs.setString('dateMonth', dateMonthString);
    await prefs.setString('date', dateString);
  }


  writeDate(String date , String dateMonth) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('date', date);
    await prefs.setString('dateMonth', dateMonth);
  }

  Future<String> reduceDate(String date) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('date', date);
    return date;
  }

  Future<String> readDateMonth() async{
    final prefs = await SharedPreferences.getInstance();
    final String? dateMonth = prefs.getString('dateMonth');
    if(dateMonth == ""){
      String dateMonthString = '${Jalali.now().year}-${Jalali.now().month}';
      return dateMonthString;
    }else{
      return dateMonth!;
    }
  }

  Future<String> readDate() async{
    final prefs = await SharedPreferences.getInstance();
    final String? date = prefs.getString('date');
    if(date == ""){
      String dateString = '${Jalali.now().year}-${Jalali.now().month}-${Jalali.now().day}';
      return dateString;
    }else{
      return date!;
    }
  }

  addToDate(String date) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('date', date);
  }

  Future<List<ExpenseModel>> getAllExpensesRepo(String date) async {
    return await helper.getAllExpenses(date);
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