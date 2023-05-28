class IncomeModel {
  int? id;
  String? incomeDate;
  String? incomeMonth;
  String? incomeCategory;
  int? income;
  String? incomeDescription;
  String? incomeIconType;


  IncomeModel({
    this.id,
    this.incomeDate,
    this.incomeMonth,
    this.incomeCategory,
    this.income,
    this.incomeDescription,
    this.incomeIconType
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "incomeDate": incomeDate,
      "incomeMonth": incomeMonth,
      "incomeCategory": incomeCategory,
      "income": income,
      "incomeDescription": incomeDescription,
      "incomeIconType": incomeIconType
    };
  }

  factory IncomeModel.fromJson(Map<String, dynamic> parsedJson) {
    return IncomeModel(
      id: parsedJson['id'],
      incomeDate: parsedJson['incomeDate'],
      incomeMonth: parsedJson['incomeMonth'],
      incomeCategory: parsedJson['incomeCategory'],
      income: parsedJson['income'],
      incomeDescription: parsedJson['incomeDescription'],
      incomeIconType: parsedJson['incomeIconType'],
    );
  }

  IncomeModel.fromMap(Map map) {
    id = map[id];
    incomeDate = map[incomeDate];
    incomeMonth = map[incomeMonth];
    incomeCategory = map[incomeCategory];
    income = map[income];
    incomeDescription = map[incomeDescription];
    incomeIconType = map[incomeIconType];
  }
}
