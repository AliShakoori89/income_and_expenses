abstract class CalculateSFCartesianChartEvent{
  @override
  List<Object> get props => [];
}

class SumExpensesByGroupingTypePerMonthForSFCartesianChartEvent extends CalculateSFCartesianChartEvent{
  final String month;

  SumExpensesByGroupingTypePerMonthForSFCartesianChartEvent(
      {required this.month});

  @override
  List<Object> get props => [month];
}
