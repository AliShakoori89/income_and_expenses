import 'dart:io';
import 'package:income_and_expenses/model/expense_model.dart';
import 'package:income_and_expenses/model/income_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper();

  static const _databaseName = "MyDatabase.db";
  static const _databaseVersion = 1;

  static const expenseTable = 'expenseTable';
  static const columnExpenseId = 'id';
  static const columnExpenseDate = 'expenseDate';
  static const columnExpenseMonth = 'expenseMonth';
  static const columnExpenseCategory = 'expenseCategory';
  static const columnExpense = 'expense';
  static const columnExpenseDescription = 'expenseDescription';
  static const columnExpenseIconType = 'expenseIconType';

  static const incomeTable = 'incomeTable';
  static const columnIncomeId = 'id';
  static const columnIncomeDate = 'incomeDate';
  static const columnIncomeMonth = 'incomeMonth';
  static const columnIncomeCategory = "incomeCategory";
  static const columnIncome = "income";
  static const columnIncomeDescription = "incomeDescription";
  static const columnIncomeIconType = "incomeIconType";


  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async =>
      _database ??= await _initiateDatabase();

  _initiateDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE $expenseTable ('
        '$columnExpenseId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
        '$columnExpenseDate TEXT,'
        '$columnExpenseMonth TEXT,'
        '$columnExpenseCategory TEXT,'
        '$columnExpense INTEGER,'
        '$columnExpenseDescription TEXT,'
        '$columnExpenseIconType TEXT'
        ')'
    );

    await db.execute('CREATE TABLE $incomeTable ('
        '$columnIncomeId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
        '$columnIncomeDate TEXT,'
        '$columnIncomeMonth TEXT,'
        '$columnIncomeCategory TEXT,'
        '$columnIncome INTEGER,'
        '$columnIncomeDescription TEXT,'
        '$columnIncomeIconType TEXT'
        ')'
    );
  }

  Future<bool> saveIncome(IncomeModel incomeModel) async {
    print("saveIncome         saveIncome         saveIncome           ${incomeModel.income}      ${incomeModel.incomeMonth}" );
    var dbExpense = await database;
    await dbExpense.insert(incomeTable, incomeModel.toJson());
    return true;
  }

  Future<int> updateIncome(IncomeModel incomeModel) async {
    var dbExpense = await database;
    return await dbExpense.update(incomeTable, incomeModel.toJson(),
        where: '$columnIncomeId = ?', whereArgs: [incomeModel.id]);
  }

  Future<int> deleteIncome(int id) async {
    var dbExpense = await database;
    return await dbExpense.delete(incomeTable,
        where: '$columnIncomeId = ?', whereArgs: [id]);
  }

  Future<List<IncomeModel>> getAllIncomeItems(String month) async {
    var dbExpense = await database;
    var listMap = await dbExpense.rawQuery('SELECT * FROM incomeTable WHERE $columnIncomeMonth = "$month"');
    var listIncomeItems = <IncomeModel>[];
    for (Map<String, dynamic> m in listMap) {
      listIncomeItems.add(IncomeModel.fromJson(m));
    }
    return listIncomeItems;
  }

  Future<String> fetchIncomePerMonth(String? month) async {

    var dbExpense = await database;
    var result = await dbExpense.rawQuery("SELECT SUM($columnIncome) FROM incomeTable WHERE $columnIncomeMonth ='$month'");
    Object? value = result[0]["SUM($columnIncome)"];
    if (value == null){
      return '0';
    }else{
      return "$value";
    }
  }

//******************************************************************************

  Future<bool> saveExpense(ExpenseModel expense) async {
    var dbExpense = await database;
    await dbExpense.insert(expenseTable, expense.toJson());
    return true;
  }

  Future<int> updateExpense(ExpenseModel expense) async {
    var dbExpense = await database;
    return await dbExpense.update(expenseTable, expense.toJson(),
        where: '$columnExpenseId = ?', whereArgs: [expense.id]);
  }

  Future<int> deleteExpense(int id) async {
    var dbExpense = await database;
    return await dbExpense.delete(expenseTable,
        where: '$columnExpenseId = ?', whereArgs: [id]);
  }

  Future<List<ExpenseModel>> getAllExpensesItems(String date) async {
    var dbExpense = await database;
    var listMap = await dbExpense.rawQuery('SELECT * FROM expenseTable WHERE $columnExpenseDate = "$date"');
    var listExpensesItems = <ExpenseModel>[];
    for (Map<String, dynamic> m in listMap) {
      listExpensesItems.add(ExpenseModel.fromJson(m));
    }
    return listExpensesItems;
  }


  Future<String> calculateDayExpenses(String? day) async {

    var dbExpense = await database;
    var result = await dbExpense.rawQuery("SELECT SUM($columnExpense) FROM expenseTable WHERE $columnExpenseDate ='$day'");
    Object? value = result[0]["SUM($columnExpense)"];
    if (value == null){
      return '0';
    }else{
      return "$value";
    }
  }

  Future<String> calculateTotalExpenses(String? dateMonth) async {

    var dbExpense = await database;
    var result = await dbExpense.rawQuery("SELECT SUM($columnExpense) FROM expenseTable WHERE $columnExpenseMonth ='$dateMonth'");
    Object? value = result[0]["SUM($columnExpense)"];
    if (value == null){
      return '0';
    }else{
      return "$value";
    }
  }

  calculateCategoryTypeExpensesPerMonth(String? dateMonth, String categoryPersianName) async {
    var dbExpense = await database;
    var result = await dbExpense.rawQuery("SELECT SUM($columnExpense) FROM expenseTable WHERE $columnExpenseMonth ='$dateMonth' AND $columnExpenseCategory ='$categoryPersianName' ");
    Object? value = result[0]["SUM($columnExpense)"];
    if (value == null){
      return '0';
    }else{
      return "$value";
    }
  }

  calculateExpensesInYearPerMonth(String? dateMonth) async {
    var dbExpense = await database;
    var result = await dbExpense.rawQuery("SELECT SUM($columnExpense) FROM expenseTable WHERE $columnExpenseMonth ='$dateMonth'");
    Object? value = result[0]["SUM($columnExpense)"];
    if (value == null){
      return '0';
    }else{
      return "$value";
    }
  }

  Future<String> calculateCash(String? dateMonth, String? income) async {
    late String cash;
    var dbExpense = await database;
    var result = await dbExpense.rawQuery("SELECT SUM($columnExpense) FROM expenseTable WHERE $columnExpenseMonth ='$dateMonth'");
    Object? value = result[0]["SUM($columnExpense)"];
    if(income == null){
      cash = "";
    }else{
      cash = value == null ? income :(int.parse(income) - int.parse(value.toString())).toString();
    }
    return cash.toString();
  }
}