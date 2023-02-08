abstract class CalculateExpenseEvent{
  @override
  List<Object> get props => [];
}

class SumExpensePerMonthEvent extends CalculateExpenseEvent {
  final String dateMonth;

  SumExpensePerMonthEvent(
      {required this.dateMonth});

  @override
  List<Object> get props => [dateMonth];
}

class CalculateCashPerMonthEvent extends CalculateExpenseEvent{
  final String dateMonth;

  CalculateCashPerMonthEvent(
      {required this.dateMonth});

  @override
  List<Object> get props => [dateMonth];
}
