import '../../model/expense_model.dart';
import '../../model/income_model.dart';

abstract class SetDateEvent{
  List<Object> get props => [];
}

class InitialDateEvent extends SetDateEvent {}

class ReadDateEvent extends SetDateEvent {}

class ReadMonthEvent extends SetDateEvent {}

class WriteDateEvent extends SetDateEvent {
  final String date;
  final String month;

  WriteDateEvent(
      {required this.date, required this.month});

  @override
  List<Object> get props => [date, month];
}

class AddToDateEvent extends SetDateEvent{
  final String date;
  final String month;

  AddToDateEvent(
      {required this.date, required this.month});

  @override
  List<Object> get props => [date, month];
}

class ReduceDateEvent extends SetDateEvent{
  final String date;
  final String month;

  ReduceDateEvent(
      {required this.date, required this.month});

  @override
  List<Object> get props => [date, month];
}

class SumExpensePerMonthEvent extends SetDateEvent {
  final String month;

  SumExpensePerMonthEvent(
      {required this.month});

  @override
  List<Object> get props => [month];
}

class SumExpensePerDateEvent extends SetDateEvent {
  final String date;

  SumExpensePerDateEvent(
      {required this.date});

  @override
  List<Object> get props => [date];
}

class CalculateCashPerMonthEvent extends SetDateEvent{
  final String month;

  CalculateCashPerMonthEvent(
      {required this.month});

  @override
  List<Object> get props => [month];
}

class FetchIncomeEvent extends SetDateEvent {
  final String month;

  FetchIncomeEvent(
      {required this.month});

  @override
  List<Object> get props => [month];
}

class AddIncomeEvent extends SetDateEvent {

  final IncomeModel incomeModel;

  AddIncomeEvent(
      {required this.incomeModel});

  @override
  List<Object> get props => [incomeModel];
}

class FetchExpensesItemsEvent extends SetDateEvent {
  final String date;

  FetchExpensesItemsEvent(
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