import 'package:equatable/equatable.dart';

enum CalculateSFCartesianChartStatus { initial, success, error, loading }

extension CalculateSFCartesianChartStatusX on CalculateSFCartesianChartStatus {
  bool get isInitial => this == CalculateSFCartesianChartStatus.initial;
  bool get isSuccess => this == CalculateSFCartesianChartStatus.success;
  bool get isError => this == CalculateSFCartesianChartStatus.error;
  bool get isLoading => this == CalculateSFCartesianChartStatus.loading;
}

class CalculateSFCartesianChartState extends Equatable {

  const CalculateSFCartesianChartState({
    this.status = CalculateSFCartesianChartStatus.initial,
    String? buyItemsExpenses,
    String? comestibleExpenses,
    String? transportationExpenses,
    String? giftsExpenses,
    String? treatmentExpenses,
    String? installmentsAndDebtExpenses,
    String? renovationExpenses,
    String? pastimeExpenses,
    String? etceteraExpenses,

  }): buyItemsExpenses = buyItemsExpenses ?? "0",
        comestibleExpenses = comestibleExpenses ?? "0",
        transportationExpenses = transportationExpenses ?? "0",
        giftsExpenses = giftsExpenses ?? "0",
        treatmentExpenses = treatmentExpenses ?? "0",
        installmentsAndDebtExpenses = installmentsAndDebtExpenses ?? "0",
        renovationExpenses = renovationExpenses ?? "0",
        pastimeExpenses = pastimeExpenses ?? "0",
        etceteraExpenses = etceteraExpenses ?? "0";
  final CalculateSFCartesianChartStatus status;
  final String buyItemsExpenses;
  final String comestibleExpenses;
  final String transportationExpenses;
  final String giftsExpenses;
  final String treatmentExpenses;
  final String installmentsAndDebtExpenses;
  final String renovationExpenses;
  final String pastimeExpenses;
  final String etceteraExpenses;


  @override
  // TODO: implement props
  List<Object> get props => [status, buyItemsExpenses, comestibleExpenses, transportationExpenses,
    giftsExpenses, treatmentExpenses, installmentsAndDebtExpenses, renovationExpenses, pastimeExpenses, etceteraExpenses];


  CalculateSFCartesianChartState copyWith({
    CalculateSFCartesianChartStatus? status,
    String? buyItemsExpenses,
    String? comestibleExpenses,
    String? transportationExpenses,
    String? giftsExpenses,
    String? treatmentExpenses,
    String? installmentsAndDebtExpenses,
    String? renovationExpenses,
    String? pastimeExpenses,
    String? etceteraExpenses,
  }) {
    return CalculateSFCartesianChartState(
      status: status ?? this.status,
      buyItemsExpenses: buyItemsExpenses ?? this.buyItemsExpenses,
      comestibleExpenses: comestibleExpenses ?? this.comestibleExpenses,
      transportationExpenses: transportationExpenses ?? this.transportationExpenses,
      giftsExpenses: giftsExpenses ?? this.giftsExpenses,
      treatmentExpenses: treatmentExpenses ?? this.treatmentExpenses,
      installmentsAndDebtExpenses: installmentsAndDebtExpenses ?? this.installmentsAndDebtExpenses,
      renovationExpenses: renovationExpenses ?? this.renovationExpenses,
      pastimeExpenses: pastimeExpenses ?? this.pastimeExpenses,
      etceteraExpenses: etceteraExpenses ?? this.etceteraExpenses,
    );
  }
}