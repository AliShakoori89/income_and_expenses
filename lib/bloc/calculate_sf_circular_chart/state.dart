import 'package:equatable/equatable.dart';

enum CalculateSFCircularChartStatus { initial, success, error, loading }

extension CalculateSFCircularChartStatusX on CalculateSFCircularChartStatus {
  bool get isInitial => this == CalculateSFCircularChartStatus.initial;
  bool get isSuccess => this == CalculateSFCircularChartStatus.success;
  bool get isError => this == CalculateSFCircularChartStatus.error;
  bool get isLoading => this == CalculateSFCircularChartStatus.loading;
}

class CalculateSFCircularChartState extends Equatable {

  const CalculateSFCircularChartState({
    this.status = CalculateSFCircularChartStatus.initial,
    String? expenses,
    String? calculateCash,
  }): expenses = expenses ?? "",
      calculateCash = calculateCash ?? "";

  final CalculateSFCircularChartStatus status;
  final String expenses;
  final String calculateCash;

  @override
  // TODO: implement props
  List<Object> get props => [status, expenses, calculateCash];

  CalculateSFCircularChartState copyWith({
    CalculateSFCircularChartStatus? status,
    String? expenses,
    String? calculateTomanCash,
  }) {
    return CalculateSFCircularChartState(
      status: status ?? this.status,
      expenses: expenses ?? this.expenses,
      calculateCash: calculateTomanCash ?? this.calculateCash,
    );
  }
}