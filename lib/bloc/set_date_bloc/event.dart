abstract class SetDateEvent{
  @override
  List<Object> get props => [];
}

class InitialDateEvent extends SetDateEvent {}

class ReadDateEvent extends SetDateEvent {}

class WriteDateEvent extends SetDateEvent {
  final String date;

  WriteDateEvent(
      {required this.date});

  @override
  List<Object> get props => [date];
}

class AddToDateEvent extends SetDateEvent{
  final String date;

  AddToDateEvent(
      {required this.date});

  @override
  List<Object> get props => [date];
}

class ReduceDateEvent extends SetDateEvent{
  final String date;

  ReduceDateEvent(
      {required this.date});

  @override
  List<Object> get props => [date];
}

class SumExpensePerMonthEvent extends SetDateEvent {
  final String dateMonth;

  SumExpensePerMonthEvent(
      {required this.dateMonth});

  @override
  List<Object> get props => [dateMonth];
}

class CalculateCashPerMonthEvent extends SetDateEvent{
  final String dateMonth;

  CalculateCashPerMonthEvent(
      {required this.dateMonth});

  @override
  List<Object> get props => [dateMonth];
}

class FetchIncomeEvent extends SetDateEvent {
  final String month;

  FetchIncomeEvent(
      {required this.month});

  @override
  List<Object> get props => [month];
}

class AddIncomeEvent extends SetDateEvent {

  final String cash;
  final String month;

  AddIncomeEvent(
      {required this.cash, required this.month});

  @override
  List<Object> get props => [cash, month];
}