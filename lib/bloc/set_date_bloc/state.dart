import 'package:equatable/equatable.dart';
import 'package:income_and_expenses/model/income_model.dart';
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
    String? month,
    String? selectDate,
    String? expensesPerMonth,
    String? expensesPerDate,
    String? calculateCash,
    String? incomePerDate,
    String? incomePerMonth,
    List<IncomeModel>? incomeModel,
    List<ExpenseModel>? expensesDetails,
    String? todayExpenses
  }): date = date ?? '' ,
        month = month ?? '',
        selectDate = selectDate ?? '',
        expensesPerMonth = expensesPerMonth ?? "",
        expensesPerDate = expensesPerDate ?? "",
        calculateCash = calculateCash ?? "",
        incomePerDate = incomePerDate ?? "",
        incomePerMonth = incomePerMonth?? "",
        incomeModel = incomeModel ?? const [],
        expensesDetails = expensesDetails ?? const [];

  final SetDateStatus status;
  final String date;
  final String month;
  final String selectDate;
  final String expensesPerMonth;
  final String expensesPerDate;
  final String calculateCash;
  final String incomePerDate;
  final String incomePerMonth;
  final List<IncomeModel> incomeModel;
  final List<ExpenseModel> expensesDetails;

  @override
  // TODO: implement props
  List<Object> get props => [status, date, month, selectDate, expensesPerMonth, expensesPerDate, calculateCash, incomePerDate, incomePerMonth, incomeModel, expensesDetails];

  SetDateState copyWith({
    SetDateStatus? status,
    String? date,
    String? month,
    String? selectDate,
    String? expensesPerMonth,
    String? expensesPerDate,
    String? calculateCash,
    String? incomePerDate,
    String? incomePerMonth,
    List<IncomeModel>? incomeModel,
    List<ExpenseModel>? expensesDetails,
  }) {
    return SetDateState(
        status: status ?? this.status,
        date: date ?? this.date,
        month: month ?? this.month,
        selectDate: selectDate ?? this.selectDate,
        expensesPerMonth: expensesPerMonth ?? this.expensesPerMonth,
        expensesPerDate: expensesPerDate ?? this.expensesPerDate,
        calculateCash: calculateCash ?? this.calculateCash,
        incomePerDate: incomePerDate ?? this.incomePerDate,
        incomePerMonth: incomePerMonth ?? this.incomePerMonth,
        incomeModel: incomeModel ?? this.incomeModel,
        expensesDetails: expensesDetails ?? this.expensesDetails,
    );
  }
}