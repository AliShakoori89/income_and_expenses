import 'package:income_and_expenses/data_base/data_base.dart';
import 'package:income_and_expenses/model/income_model.dart';
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
    String dateMonthString = Jalali.now().month.toString().length != 1
        ? '${Jalali.now().year}-${Jalali.now().month}'
        : '${Jalali.now().year}-0${Jalali.now().month}';
    String dateString = Jalali.now().month.toString().length != 1 && Jalali.now().day.toString().length != 1
        ? '${Jalali.now().year}-${Jalali.now().month}-${Jalali.now().day}'
        : Jalali.now().month.toString().length != 1 && Jalali.now().day.toString().length == 1
        ? '${Jalali.now().year}-${Jalali.now().month}-0${Jalali.now().day}'
        : Jalali.now().month.toString().length == 1 && Jalali.now().day.toString().length != 1
        ? '${Jalali.now().year}-0${Jalali.now().month}-${Jalali.now().day}'
        : '${Jalali.now().year}-0${Jalali.now().month}-0${Jalali.now().day}';
    await prefs.setString('dateMonth', dateMonthString);
    await prefs.setString('date', dateString);
  }


  writeDate(String date , String month) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('date', date);
    await prefs.setString('dateMonth', month);
  }

  reduceDate(String date, String month) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('date', date);
    await prefs.setString('dateMonth', month);
  }

  Future<String> readMonth() async{
    final prefs = await SharedPreferences.getInstance();
    final String? dateMonth = prefs.getString('dateMonth');
    if(dateMonth == ""){
      String monthString = '${Jalali.now().year}-${Jalali.now().month}';
      return monthString;
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

  addToDate(String date, String month) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('date', date);
    await prefs.setString('dateMonth', month);
  }

  Future<List<ExpenseModel>> getAllExpensesItemsRepo(String date) async {
    return await helper.getAllExpensesItems(date);
  }

  Future<bool> addExpenseRepo(ExpenseModel expenseModel) async {
    return await helper.saveExpense(expenseModel);
  }

  deleteExpensesRepo(int id) async {
    return await helper.deleteItem(id);
  }

  Future<int> updateExpenseItem(ExpenseModel expenseModel) async {
    var helper = DatabaseHelper();
    return await helper.updateExpense(expenseModel);
  }

  Future<int> updateIncomeItem(IncomeModel incomeModel) async {
    var helper = DatabaseHelper();
    return await helper.updateIncome(incomeModel);
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