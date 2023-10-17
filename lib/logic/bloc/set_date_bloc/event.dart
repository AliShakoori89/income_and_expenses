

import 'package:income_and_expenses/data/model/expense_model.dart';
import 'package:income_and_expenses/data/model/income_model.dart';

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

class FetchAllIncomeItemsEvent extends SetDateEvent {
  final String month;

  FetchAllIncomeItemsEvent(
      {required this.month});

  @override
  List<Object> get props => [month];
}

class AddIncomeEvent extends SetDateEvent {

  final IncomeModel incomeModel;
  final String month;

  AddIncomeEvent(
      {required this.incomeModel, required this.month});

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
  final String month;

  AddOneByOneExpenseEvent(
      {required this.expenseModel, required this.date, required this.month});

  @override
  List<Object> get props => [expenseModel, date];
}

class EditExpenseItemsEvent extends SetDateEvent{
  final ExpenseModel expenseModel;
  final String date;
  final String month;

  EditExpenseItemsEvent(this.expenseModel, this.date, this.month);

  @override
  List<Object> get props => [expenseModel, date, month];
}

class EditIncomeItemsEvent extends SetDateEvent{
  final IncomeModel incomeModel;

  EditIncomeItemsEvent(this.incomeModel);

  @override
  List<Object> get props => [incomeModel];
}

class DeleteExpenseEvent extends SetDateEvent{
  final int id;
  final String date;
  final String month;

  DeleteExpenseEvent(this.id, this.date, this.month);

  @override
  List<Object> get props => [id, date, month];
}

class DeleteIncomeEvent extends SetDateEvent{
  final int id;
  final String date;
  final String month;

  DeleteIncomeEvent(this.id, this.date, this.month);

  @override
  List<Object> get props => [id, date, month];
}

class AddTodayExpensesEvent extends SetDateEvent {

  final int todayExpensesDetails;

  AddTodayExpensesEvent(
      {required this.todayExpensesDetails});

  @override
  List<Object> get props => [todayExpensesDetails];
}

class ReadTodayExpensesEvent extends SetDateEvent {}