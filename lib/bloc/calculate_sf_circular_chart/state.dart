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
    String? farvardinExpenses,
    String? ordibeheshtExpenses,
    String? khordadExpenses,
    String? tirExpenses,
    String? mordadExpenses,
    String? shahrivarExpenses,
    String? mehrExpenses,
    String? abanExpenses,
    String? azarExpenses,
    String? deyExpenses,
    String? bahmanExpenses,
    String? esfandExpenses,

  }): farvardinExpenses = farvardinExpenses ?? "0",
  ordibeheshtExpenses = ordibeheshtExpenses ?? "0",
        khordadExpenses = khordadExpenses ?? "0",
        tirExpenses = tirExpenses ?? "0",
        mordadExpenses = mordadExpenses ?? "0",
        shahrivarExpenses = shahrivarExpenses ?? "0",
        mehrExpenses = mehrExpenses ?? "0",
        abanExpenses = abanExpenses ?? "0",
        azarExpenses = azarExpenses ?? "0",
        deyExpenses = deyExpenses ?? "0",
        bahmanExpenses = bahmanExpenses ?? "0",
        esfandExpenses = esfandExpenses ?? "0";
  final CalculateSFCircularChartStatus status;
  final String farvardinExpenses;
  final String ordibeheshtExpenses;
  final String khordadExpenses;
  final String tirExpenses;
  final String mordadExpenses;
  final String shahrivarExpenses;
  final String mehrExpenses;
  final String abanExpenses;
  final String azarExpenses;
  final String deyExpenses;
  final String bahmanExpenses;
  final String esfandExpenses;


  @override
  // TODO: implement props
  List<Object> get props => [status, farvardinExpenses, ordibeheshtExpenses, khordadExpenses,
  tirExpenses, mordadExpenses, shahrivarExpenses, mehrExpenses, abanExpenses, azarExpenses, deyExpenses,
  bahmanExpenses, esfandExpenses];

  CalculateSFCircularChartState copyWith({
    CalculateSFCircularChartStatus? status,
    String? farvardinExpenses,
    String? ordibeheshtExpenses,
    String? khordadExpenses,
    String? tirExpenses,
    String? mordadExpenses,
    String? shahrivarExpenses,
    String? mehrExpenses,
    String? abanExpenses,
    String? azarExpenses,
    String? deyExpenses,
    String? bahmanExpenses,
    String? esfandExpenses,
  }) {
    return CalculateSFCircularChartState(
      status: status ?? this.status,
      farvardinExpenses: farvardinExpenses ?? this.farvardinExpenses,
      ordibeheshtExpenses: ordibeheshtExpenses ?? this.ordibeheshtExpenses,
      khordadExpenses: khordadExpenses ?? this.khordadExpenses,
      tirExpenses: tirExpenses ?? this.tirExpenses,
      mordadExpenses: mordadExpenses ?? this.mordadExpenses,
      shahrivarExpenses: shahrivarExpenses ?? this.shahrivarExpenses,
      mehrExpenses: mehrExpenses ?? this.mehrExpenses,
      abanExpenses: abanExpenses ?? this.abanExpenses,
      azarExpenses: azarExpenses ?? this.azarExpenses,
      deyExpenses: deyExpenses ?? this.deyExpenses,
      bahmanExpenses: bahmanExpenses ?? this.bahmanExpenses,
      esfandExpenses: esfandExpenses ?? this.esfandExpenses,
    );
  }
}