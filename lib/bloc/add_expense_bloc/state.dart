import 'package:equatable/equatable.dart';
import 'package:income_and_expenses/model/expense_model.dart';

enum ExpenseStatus { initial, success, error, loading }

extension ExpenseStatusX on ExpenseStatus {
  bool get isInitial => this == ExpenseStatus.initial;
  bool get isSuccess => this == ExpenseStatus.success;
  bool get isError => this == ExpenseStatus.error;
  bool get isLoading => this == ExpenseStatus.loading;
}

class AddExpenseState extends Equatable {

  const AddExpenseState({
    this.status = ExpenseStatus.initial,
    List<ExpenseModel>? expenses,
    String? todayExpenses
  }): expenses = expenses ?? const [], todayExpenses = todayExpenses ?? '';

  final ExpenseStatus status;
  final List<ExpenseModel> expenses;
  final String todayExpenses;

  @override
  // TODO: implement props
  List<Object> get props => [status, expenses, todayExpenses];

  AddExpenseState copyWith({
    ExpenseStatus? status,
    List<ExpenseModel>? expenses,
    String? todayExpenses
  }) {
    return AddExpenseState(
      status: status ?? this.status,
      expenses: expenses ?? this.expenses,
      todayExpenses: todayExpenses ?? this.todayExpenses
    );
  }
}