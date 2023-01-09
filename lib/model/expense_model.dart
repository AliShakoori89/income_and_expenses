class ExpenseModel {
  int? id;
  String? expenseDate;
  String? expenseDateMonth;
  String? expenseCategory;
  int? expense;
  String? description;
  String? iconType;


  ExpenseModel({
    this.id,
    this.expenseDate,
    this.expenseDateMonth,
    this.expenseCategory,
    this.expense,
    this.description,
    this.iconType
  });

  static const String tableName = "my_table";

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "expenseDate": expenseDate,
      "expenseDateMonth": expenseDateMonth,
      "expenseCategory": expenseCategory,
      "expense": expense,
      "description": description,
      "iconType": iconType
    };
  }

  factory ExpenseModel.fromJson(Map<String, dynamic> parsedJson) {
    return ExpenseModel(
      id: parsedJson['id'],
      expenseDate: parsedJson['expenseDate'],
      expenseDateMonth: parsedJson['expenseDateMonth'],
      expenseCategory: parsedJson['expenseCategory'],
      expense: parsedJson['expense'],
      description: parsedJson['description'],
      iconType: parsedJson['iconType']
    );
  }
}
