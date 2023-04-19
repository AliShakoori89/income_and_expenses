abstract class CalculateSFCartesianChartEvent{
  @override
  List<Object> get props => [];
}

class SumExpensesByGroupingTypePerMonthForSFCartesianChartEvent extends CalculateSFCartesianChartEvent{
  final String year;
  final String month;

  SumExpensesByGroupingTypePerMonthForSFCartesianChartEvent(
      {required this.year, required this.month});

  @override
  List<Object> get props => [year, month];
}
