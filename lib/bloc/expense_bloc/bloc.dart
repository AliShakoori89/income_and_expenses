import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/bloc/expense_bloc/event.dart';
import 'package:income_and_expenses/bloc/expense_bloc/state.dart';
import 'package:income_and_expenses/repository/expense_repository.dart';

import '../../model/expense_model.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {

  ExpenseRepository expenseRepository = ExpenseRepository();

  ExpenseBloc(this.expenseRepository) : super( const ExpenseState()){
    on<FetchExpensesEvent>(_mapFetchExpensesEventToState);
    on<AddExpenseEvent>(_mapAddExpenseEventToState);
  }

  void _mapFetchExpensesEventToState(
      FetchExpensesEvent event, Emitter<ExpenseState> emit) async {
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
      AddExpenseEvent event, Emitter<ExpenseState> emit) async {
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