abstract class CalculateExpenseEvent{
  @override
  List<Object> get props => [];
}

class SumExpenseByMonthEvent extends CalculateExpenseEvent {

  final String date;

  SumExpenseByMonthEvent(
      {required this.date});

  @override
  List<Object> get props => [date];
}