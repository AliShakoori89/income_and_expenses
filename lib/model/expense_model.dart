class ExpenseModel {
  int? id;
  String? expenseDate;
  String? expenseDateMonth;
  String? expenseCategory;
  int? tomanExpense;
  int? rialExpense;
  String? description;
  String? iconType;


  ExpenseModel({
    this.id,
    this.expenseDate,
    this.expenseDateMonth,
    this.expenseCategory,
    this.tomanExpense,
    this.rialExpense,
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
      "tomanExpense": tomanExpense,
      "rialExpense": rialExpense,
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
      tomanExpense: parsedJson['tomanExpense'],
      rialExpense: parsedJson['rialExpense'],
      description: parsedJson['description'],
      iconType: parsedJson['iconType']
    );
  }
}
