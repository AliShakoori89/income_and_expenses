import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:income_and_expenses/model/expense_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../const/app_colors.dart';

class DatabaseHelper {
  DatabaseHelper();

  static const _databaseName = "MyDatabase.db";
  static const _databaseVersion = 1;
  static const table = 'my_table';
  static const columnId = 'id';
  static const columnExpenseDate = 'expenseDate';
  static const columnExpenseDateMonth = 'expenseDateMonth';
  static const columnExpenseCategory = 'expenseCategory';
  static const columnExpense = 'expense';
  static const columnDescription = 'description';
  static const columnIconType = 'iconType';

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
    await db.execute('CREATE TABLE $table ('
        '$columnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
        '$columnExpenseDate TEXT,'
        '$columnExpenseDateMonth TEXT,'
        '$columnExpenseCategory TEXT,'
        '$columnExpense INTEGER,'
        '$columnDescription TEXT,'
        '$columnIconType Text'
        ')'
    );
  }

  Future<bool> saveExpense(ExpenseModel expense) async {
    var dbExpense = await database;
    await dbExpense.insert(table, expense.toJson());
    return true;
  }

  Future<List<ExpenseModel>> getAllExpenses(String date) async {
    var dbExpense = await database;
    var listMap = await dbExpense
        .rawQuery('SELECT * FROM my_table WHERE $columnExpenseDate = "$date"');
    var listMedicines = <ExpenseModel>[];
    for (Map<String, dynamic> m in listMap) {
      listMedicines.add(ExpenseModel.fromJson(m));
    }
    return listMedicines;
  }



  Future<String> calculateTotalExpenses(String? dateMonth) async {
    var dbExpense = await database;
    var result = await dbExpense.rawQuery("SELECT SUM($columnExpense) FROM my_table WHERE $columnExpenseDateMonth ='$dateMonth'");
    Object? value = result[0]["SUM($columnExpense)"];
    if (value == null){
      return '';
    }else{
      return "$value";
    }
  }

  Future<String> calculateCash(String? dateMonth, String? income) async {
    late String cash;
    var dbExpense = await database;
    var result = await dbExpense.rawQuery("SELECT SUM($columnExpense) FROM my_table WHERE $columnExpenseDateMonth ='$dateMonth'");
    Object? value = result[0]["SUM($columnExpense)"];
    if(income == null){
      Get.rawSnackbar(
        backgroundColor: AppColors.snackBarColor,
      snackPosition: SnackPosition.TOP,
      titleText: const Text("توجه",
      textDirection: TextDirection.rtl),
        messageText: const Text('برای نمایش موجودی، مقدار ورودی را وارد نمایید! ',
            textDirection: TextDirection.rtl)
      );
      cash = "";
    }else{
      cash = value == null ? income :(int.parse(income) - int.parse(value.toString())).toString();
    }
    return cash.toString();
  }
}
