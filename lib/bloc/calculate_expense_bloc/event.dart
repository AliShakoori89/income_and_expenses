abstract class CalculateExpenseEvent{
  @override
  List<Object> get props => [];
}

class SumExpensePerMonthEvent extends CalculateExpenseEvent {}

class CalculateCashPerMonthEvent extends CalculateExpenseEvent{}
