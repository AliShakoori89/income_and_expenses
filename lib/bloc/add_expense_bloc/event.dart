import 'package:income_and_expenses/model/expense_model.dart';

abstract class AddExpenseEvent{
  @override
  List<Object> get props => [];
}

class FetchExpensesEvent extends AddExpenseEvent {}

class AddOneByOneExpenseEvent extends AddExpenseEvent {

  final ExpenseModel expenseModel;

  AddOneByOneExpenseEvent(
      {required this.expenseModel});

  @override
  List<Object> get props => [expenseModel];
}