import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/bloc/calculate_expense_bloc/event.dart';
import 'package:income_and_expenses/bloc/calculate_expense_bloc/state.dart';
import 'package:income_and_expenses/repository/expense_repository.dart';

class CalculateExpenseBloc extends Bloc<CalculateExpenseEvent, CalculateExpenseState> {

  ExpenseRepository expenseRepository = ExpenseRepository();

  CalculateExpenseBloc(this.expenseRepository) : super( const CalculateExpenseState()){
    on<SumExpenseByMonthEvent>(_mapSumExpenseByMonthEventToState);
  }

  void _mapSumExpenseByMonthEventToState(
      SumExpenseByMonthEvent event, Emitter<CalculateExpenseState> emit) async {
    try {
      emit(state.copyWith(status: CalculateExpenseStatus.loading));
      String calculateExpense = await expenseRepository.calculateExpenseRepo(event.date);
      emit(
        state.copyWith(
          status: CalculateExpenseStatus.success,
          expenses: calculateExpense,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: CalculateExpenseStatus.error));
    }
  }
}