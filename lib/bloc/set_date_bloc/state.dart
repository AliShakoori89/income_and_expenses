import 'package:equatable/equatable.dart';

import '../../model/expense_model.dart';

enum SetDateStatus { initial, success, error, loading }

extension SetDateStatusX on SetDateStatus {
  bool get isInitial => this == SetDateStatus.initial;
  bool get isSuccess => this == SetDateStatus.success;
  bool get isError => this == SetDateStatus.error;
  bool get isLoading => this == SetDateStatus.loading;
}

class SetDateState extends Equatable {

  const SetDateState({
    this.status = SetDateStatus.initial,
    String? date,
    String? dateMonth,
    String? selectDate,
    String? expensesPerMonth,
    String? expensesPerDate,
    String? calculateCash,
    String? income,
    List<ExpenseModel>? expensesDetails,
    String? todayExpenses
  }): date = date ?? '' ,
        dateMonth = dateMonth ?? '',
        selectDate = selectDate ?? '',
        expensesPerMonth = expensesPerMonth ?? "",
        expensesPerDate = expensesPerDate ?? "",
        calculateCash = calculateCash ?? "",
        income = income ?? '',
        expensesDetails = expensesDetails ?? const [];

  final SetDateStatus status;
  final String date;
  final String dateMonth;
  final String selectDate;
  final String expensesPerMonth;
  final String expensesPerDate;
  final String calculateCash;
  final String income;
  final List<ExpenseModel> expensesDetails;

  @override
  // TODO: implement props
  List<Object> get props => [status, date, dateMonth, selectDate, expensesPerMonth, expensesPerDate, calculateCash, income, expensesDetails];

  SetDateState copyWith({
    SetDateStatus? status,
    String? date,
    String? dateMonth,
    String? selectDate,
    String? expensesPerMonth,
    String? expensesPerDate,
    String? calculateCash,
    String? income,
    List<ExpenseModel>? expensesDetails,
  }) {
    return SetDateState(
        status: status ?? this.status,
        date: date ?? this.date,
        dateMonth: dateMonth ?? this.dateMonth,
        selectDate: selectDate ?? this.selectDate,
        expensesPerMonth: expensesPerMonth ?? this.expensesPerMonth,
        expensesPerDate: expensesPerDate ?? this.expensesPerDate,
        calculateCash: calculateCash ?? this.calculateCash,
        income: income ?? this.income,
        expensesDetails: expensesDetails ?? this.expensesDetails,
    );
  }
}