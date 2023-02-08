import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/bloc/calculate_expense_bloc/event.dart';
import 'package:income_and_expenses/bloc/calculate_expense_bloc/state.dart';
import 'package:income_and_expenses/repository/calculate_Espense_repository.dart';

class CalculateExpenseBloc extends Bloc<CalculateExpenseEvent, CalculateExpenseState> {

  CalculateExpensesRepository calculateExpensesRepository = CalculateExpensesRepository();

  CalculateExpenseBloc(this.calculateExpensesRepository) : super( const CalculateExpenseState()){
    on<SumExpensePerMonthEvent>(_mapSumExpenseByMonthEventToState);
    on<CalculateCashPerMonthEvent>(_mapCalculateCashPerMonthEventToState);
  }

  void _mapSumExpenseByMonthEventToState(
      SumExpensePerMonthEvent event, Emitter<CalculateExpenseState> emit) async {
    try {
      emit(state.copyWith(status: CalculateExpenseStatus.loading));
    String expenses = await calculateExpensesRepository.calculateExpenseRepo(event.dateMonth);
      emit(
        state.copyWith(
          status: CalculateExpenseStatus.success,
          expenses: expenses,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: CalculateExpenseStatus.error));
    }
  }

  void _mapCalculateCashPerMonthEventToState(
      CalculateCashPerMonthEvent event, Emitter<CalculateExpenseState> emit) async {
    try {
      emit(state.copyWith(status: CalculateExpenseStatus.loading));
      String calculateCash = await calculateExpensesRepository.calculateCashRepo(event.dateMonth);
      emit(
        state.copyWith(
          status: CalculateExpenseStatus.success,
          calculateCash: calculateCash,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: CalculateExpenseStatus.error));
    }
  }

}