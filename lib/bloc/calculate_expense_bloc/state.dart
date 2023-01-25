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
    String? tomaExpenses,
    String? rialExpenses,
    String? calculateTomanCash,
    String? calculateRialCash
  }): tomanExpenses = tomaExpenses ?? "",
      rialExpenses = rialExpenses ?? "",
      calculateTomanCash = calculateTomanCash ?? "",
      calculateRialCash = calculateRialCash ?? "";

  final CalculateExpenseStatus status;
  final String tomanExpenses;
  final String rialExpenses;
  final String calculateTomanCash;
  final String calculateRialCash;

  @override
  // TODO: implement props
  List<Object> get props => [status, tomanExpenses, rialExpenses, calculateTomanCash, calculateRialCash];

  CalculateExpenseState copyWith({
    CalculateExpenseStatus? status,
    String? tomanExpenses,
    String? rialExpenses,
    String? calculateTomanCash,
    String? calculateRialCash
  }) {
    return CalculateExpenseState(
      status: status ?? this.status,
      tomaExpenses: tomanExpenses ?? this.tomanExpenses,
      rialExpenses: rialExpenses ?? this.rialExpenses,
      calculateTomanCash: calculateTomanCash ?? this.calculateTomanCash,
      calculateRialCash: calculateRialCash ?? this.calculateRialCash
    );
  }
}