import 'dart:io';
import 'package:income_and_expenses/model/expense_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper();

  static const _databaseName = "MyDatabase.db";
  static const _databaseVersion = 1;
  static const table = 'my_table';
  static const columnId = 'id';
  static const columnExpenseDate = 'expenseDate';
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
        '$columnExpenseCategory TEXT,'
        '$columnExpense TEXT,'
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

  Future<List<ExpenseModel>> getAllMedicines() async {
    var dbMedicine = await database;
    var listMap = await dbMedicine
        .rawQuery('SELECT DISTINCT * FROM my_table');
    var listMedicines = <ExpenseModel>[];
    for (Map<String, dynamic> m in listMap) {
      listMedicines.add(ExpenseModel.fromJson(m));
    }
    return listMedicines;
  }
}
