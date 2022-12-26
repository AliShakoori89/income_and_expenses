class ExpenseModel {
  int? id;
  String? expenseDate;
  String? expenseCategory;
  String? expense;
  String? description;
  String? useTime;


  ExpenseModel({
    this.id,
    this.expenseDate,
    this.expenseCategory,
    this.expense,
    this.description,
  });

  static const String tableName = "my_table";

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "expenseDate": expenseDate,
      "expenseCategory": expenseCategory,
      "expense": expense,
      "description": description,
      "useTime": useTime,
    };
  }

  factory ExpenseModel.fromJson(Map<String, dynamic> parsedJson) {
    return ExpenseModel(
      id: parsedJson['id'],
      expenseDate: parsedJson['expenseDate'],
      expenseCategory: parsedJson['expenseCategory'],
      expense: parsedJson['expense'],
      description: parsedJson['description'],
    );
  }
}
