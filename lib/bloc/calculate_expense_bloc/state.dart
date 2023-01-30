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
    String? calculateCash,
  }): expenses = expenses ?? "",
      calculateCash = calculateCash ?? "";

  final CalculateExpenseStatus status;
  final String expenses;
  final String calculateCash;

  @override
  // TODO: implement props
  List<Object> get props => [status, expenses, calculateCash];

  CalculateExpenseState copyWith({
    CalculateExpenseStatus? status,
    String? expenses,
    String? calculateCash,
  }) {
    return CalculateExpenseState(
      status: status ?? this.status,
      expenses: expenses ?? this.expenses,
      calculateCash: calculateCash ?? this.calculateCash,
    );
  }
}