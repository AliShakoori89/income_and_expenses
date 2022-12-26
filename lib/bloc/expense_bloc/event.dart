import 'package:income_and_expenses/model/expense_model.dart';

abstract class ExpenseEvent{
  @override
  List<Object> get props => [];
}

class FetchExpensesEvent extends ExpenseEvent {}

class AddExpenseEvent extends ExpenseEvent {

  final ExpenseModel expenseModel;

  AddExpenseEvent(
      {required this.expenseModel});

  @override
  List<Object> get props => [expenseModel];
}