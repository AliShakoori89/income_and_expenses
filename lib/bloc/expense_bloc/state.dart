import 'package:equatable/equatable.dart';
import 'package:income_and_expenses/model/expense_model.dart';

enum ExpenseStatus { initial, success, error, loading }

extension ExpenseStatusX on ExpenseStatus {
  bool get isInitial => this == ExpenseStatus.initial;
  bool get isSuccess => this == ExpenseStatus.success;
  bool get isError => this == ExpenseStatus.error;
  bool get isLoading => this == ExpenseStatus.loading;
}

class ExpenseState extends Equatable {

  const ExpenseState({
    this.status = ExpenseStatus.initial,
    List<ExpenseModel>? expenses,
  }): expenses = expenses ?? const [];

  final ExpenseStatus status;
  final List<ExpenseModel> expenses;

  @override
  // TODO: implement props
  List<Object> get props => [status, expenses];

  ExpenseState copyWith({
    ExpenseStatus? status,
    List<ExpenseModel>? expenses
  }) {
    return ExpenseState(
      status: status ?? this.status,
      expenses: expenses ?? this.expenses,
    );
  }
}