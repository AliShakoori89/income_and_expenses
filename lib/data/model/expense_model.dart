class ExpenseModel {
  int? id;
  String? expenseDate;
  String? expenseMonth;
  String? expenseCategory;
  int? expense;
  String? expensesDescription;
  String? expensesIconType;


  ExpenseModel({
    this.id,
    this.expenseDate,
    this.expenseMonth,
    this.expenseCategory,
    this.expense,
    this.expensesDescription,
    this.expensesIconType
  });

  static const String tableName = "my_table";

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "expenseDate": expenseDate,
      "expenseMonth": expenseMonth,
      "expenseCategory": expenseCategory,
      "expense": expense,
      "expenseDescription": expensesDescription,
      "expenseIconType": expensesIconType
    };
  }

  factory ExpenseModel.fromJson(Map<String, dynamic> parsedJson) {
    return ExpenseModel(
      id: parsedJson['id'],
      expenseDate: parsedJson['expenseDate'],
      expenseMonth: parsedJson['expenseMonth'],
      expenseCategory: parsedJson['expenseCategory'],
      expense: parsedJson['expense'],
      expensesDescription: parsedJson['expenseDescription'],
      expensesIconType: parsedJson['expenseIconType']
    );
  }
}
