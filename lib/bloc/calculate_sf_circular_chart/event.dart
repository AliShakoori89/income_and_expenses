abstract class CalculateSFCircularChartEvent{
  @override
  List<Object> get props => [];
}

class SumExpensesPerMonthForCircularChartEvent extends CalculateSFCircularChartEvent{
  final String year;

  SumExpensesPerMonthForCircularChartEvent(this.year);

  @override
  List<Object> get props => [year];
}
