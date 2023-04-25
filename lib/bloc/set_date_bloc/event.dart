import '../../model/expense_model.dart';

abstract class SetDateEvent{
  @override
  List<Object> get props => [];
}

class InitialDateEvent extends SetDateEvent {}

class ReadDateEvent extends SetDateEvent {}

class ReadDateMonthEvent extends SetDateEvent {}

class WriteDateEvent extends SetDateEvent {
  final String date;
  final String dateMonth;

  WriteDateEvent(
      {required this.date, required this.dateMonth});

  @override
  List<Object> get props => [date, dateMonth];
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

class FetchExpensesEvent extends SetDateEvent {
  final String date;

  FetchExpensesEvent(
      {required this.date});

  @override
  List<Object> get props => [date];
}

class AddOneByOneExpenseEvent extends SetDateEvent {
  final ExpenseModel expenseModel;
  final String date;

  AddOneByOneExpenseEvent(
      {required this.expenseModel, required this.date});

  @override
  List<Object> get props => [expenseModel, date];
}

class EditItemEvent extends SetDateEvent{
  final ExpenseModel expenseModel;

  EditItemEvent(this.expenseModel);

  @override
  List<Object> get props => [expenseModel];
}

class DeleteItemEvent extends SetDateEvent{
  final int id;
  final String date;

  DeleteItemEvent(this.id, this.date);

  @override
  List<Object> get props => [id, date];
}

class AddTodayExpensesEvent extends SetDateEvent {

  final int todayExpensesDetails;

  AddTodayExpensesEvent(
      {required this.todayExpensesDetails});

  @override
  List<Object> get props => [todayExpensesDetails];
}

class ReadTodayExpensesEvent extends SetDateEvent {}