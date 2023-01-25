abstract class CalculateExpenseEvent{
  @override
  List<Object> get props => [];
}

class SumTomanExpensePerMonthEvent extends CalculateExpenseEvent {}

class CalculateTomanSpentPerMonthEvent extends CalculateExpenseEvent{}

class SumRialExpensePerMonthEvent extends CalculateExpenseEvent {}

class CalculateRialSpentPerMonthEvent extends CalculateExpenseEvent{}