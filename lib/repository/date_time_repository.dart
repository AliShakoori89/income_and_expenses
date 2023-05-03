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


  writeDate(String date , String dateMonth) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('date', date);
    await prefs.setString('dateMonth', dateMonth);
  }

  Future<String> reduceDate(String date) async{
    final prefs = await SharedPreferences.getInstance();
    print("44444444444444444           "+date);
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

  Future<List<ExpenseModel>> getAllExpensesItemsRepo(String date) async {
    return await helper.getAllExpensesItems(date);
  }

  Future<bool> addExpenseRepo(ExpenseModel expenseModel) async {
    return await helper.saveExpense(expenseModel);
  }

  deleteExpensesRepo(int id) async {
    return await helper.deleteItem(id);
  }

  Future<int> updateItem(ExpenseModel expenseModel) async {
    var helper = DatabaseHelper();
    return await helper.updateItem(expenseModel);
  }

  addTodayExpensesRepo(int todayExpenses) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('todayExpenses', todayExpenses.toString());
  }

  Future<String?> readTodayExpensesRepo() async {
    print("**********************************");
    final prefs = await SharedPreferences.getInstance();
    final String? todayExpenses = prefs.getString('todayExpenses');
    return todayExpenses;
  }
}