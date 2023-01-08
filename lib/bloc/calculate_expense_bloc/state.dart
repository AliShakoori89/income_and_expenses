import 'package:equatable/equatable.dart';

enum CalculateExpenseStatus { initial, success, error, loading }

extension CalculateExpenseStatusX on CalculateExpenseStatus {
  bool get isInitial => this == CalculateExpenseStatus.initial;
  bool get isSuccess => this == CalculateExpenseStatus.success;
  bool get isError => this == CalculateExpenseStatus.error;
  bool get isLoading => this == CalculateExpenseStatus.loading;
}

class CalculateExpenseState extends Equatable {

  const CalculateExpenseState({
    this.status = CalculateExpenseStatus.initial,
    String? expenses,
    String? spent,
  }): expenses = expenses ?? "", spent = spent ?? "";

  final CalculateExpenseStatus status;
  final String expenses;
  final String spent;

  @override
  // TODO: implement props
  List<Object> get props => [status, expenses, spent];

  CalculateExpenseState copyWith({
    CalculateExpenseStatus? status,
    String? expenses,
    String? spent
  }) {
    return CalculateExpenseState(
      status: status ?? this.status,
      expenses: expenses ?? this.expenses,
      spent: spent ?? this.spent,
    );
  }
}