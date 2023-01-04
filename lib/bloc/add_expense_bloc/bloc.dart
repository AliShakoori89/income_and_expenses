import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/bloc/add_expense_bloc/event.dart';
import 'package:income_and_expenses/bloc/add_expense_bloc/state.dart';
import 'package:income_and_expenses/repository/expense_repository.dart';

import '../../model/expense_model.dart';

class AddExpenseBloc extends Bloc<AddExpenseEvent, AddExpenseState> {

  ExpenseRepository expenseRepository = ExpenseRepository();

  AddExpenseBloc(this.expenseRepository) : super( const AddExpenseState()){
    on<FetchExpensesEvent>(_mapFetchExpensesEventToState);
    on<AddOneByOneExpenseEvent>(_mapAddExpenseEventToState);
  }

  void _mapFetchExpensesEventToState(
      FetchExpensesEvent event, Emitter<AddExpenseState> emit) async {
    try {
      emit(state.copyWith(status: ExpenseStatus.loading));
      final List<ExpenseModel> expenses =
      await expenseRepository.getAllExpensesRepo();
      emit(
        state.copyWith(
          status: ExpenseStatus.success,
          expenses: expenses,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: ExpenseStatus.error));
    }
  }

  void _mapAddExpenseEventToState(
      AddOneByOneExpenseEvent event, Emitter<AddExpenseState> emit) async {
    try {
      emit(state.copyWith(status: ExpenseStatus.loading));
      await expenseRepository.addExpenseRepo(event.expenseModel);
      final List<ExpenseModel> expenses = await expenseRepository
          .getAllExpensesRepo();
      emit(
        state.copyWith(
          status: ExpenseStatus.success,
          expenses: expenses,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: ExpenseStatus.error));
    }
  }
}