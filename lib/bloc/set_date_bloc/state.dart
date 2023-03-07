import 'package:equatable/equatable.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

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
    String? expenses,
    String? calculateCash,
    String? income,
    List<ExpenseModel>? expensesDetails,
    String? todayExpenses
  }): date = date ?? '' ,
        dateMonth = dateMonth ?? '',
        selectDate = selectDate ?? '',
        expenses = expenses ?? "",
        calculateCash = calculateCash ?? "",
        income = income ?? '',
        expensesDetails = expensesDetails ?? const [],
        todayExpenses = todayExpenses ?? '';

  final SetDateStatus status;
  final String date;
  final String dateMonth;
  final String selectDate;
  final String expenses;
  final String calculateCash;
  final String income;
  final List<ExpenseModel> expensesDetails;
  final String todayExpenses;

  @override
  // TODO: implement props
  List<Object> get props => [status, date, dateMonth, selectDate, expenses, calculateCash, income, expensesDetails, todayExpenses];

  SetDateState copyWith({
    SetDateStatus? status,
    String? date,
    String? dateMonth,
    String? selectDate,
    String? expenses,
    String? calculateCash,
    String? income,
    List<ExpenseModel>? expensesDetails,
    String? todayExpenses
  }) {
    return SetDateState(
        status: status ?? this.status,
        date: date ?? this.date,
        dateMonth: dateMonth ?? this.dateMonth,
        selectDate: selectDate ?? this.selectDate,
        expenses: expenses ?? this.expenses,
        calculateCash: calculateCash ?? this.calculateCash,
        income: income ?? this.income,
        expensesDetails: expensesDetails ?? this.expensesDetails,
        todayExpenses: todayExpenses ?? this.todayExpenses
    );
  }
}