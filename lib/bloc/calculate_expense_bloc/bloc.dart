import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/bloc/calculate_expense_bloc/event.dart';
import 'package:income_and_expenses/bloc/calculate_expense_bloc/state.dart';
import 'package:income_and_expenses/repository/calculate_Espense_repository.dart';

class CalculateExpenseBloc extends Bloc<CalculateExpenseEvent, CalculateExpenseState> {

  CalculateExpensesRepository calculateExpensesRepository = CalculateExpensesRepository();

  CalculateExpenseBloc(this.calculateExpensesRepository) : super( const CalculateExpenseState()){
    on<SumTomanExpensePerMonthEvent>(_mapSumTomanExpenseByMonthEventToState);
    // on<SumRialExpensePerMonthEvent>(_mapSumRialExpenseByMonthEventToState);
    on<CalculateTomanSpentPerMonthEvent>(_mapCalculateTomanSpentPerMonthEventToState);
    // on<CalculateRialSpentPerMonthEvent>(_mapCalculateRialSpentPerMonthEventToState);
  }

  void _mapSumTomanExpenseByMonthEventToState(
      SumTomanExpensePerMonthEvent event, Emitter<CalculateExpenseState> emit) async {
    try {
      emit(state.copyWith(status: CalculateExpenseStatus.loading));
    String tomanExpenses = await calculateExpensesRepository.calculateTomanExpenseRepo();
    String rialExpenses = await calculateExpensesRepository.calculateRialExpenseRepo();
    print("*********  "+ tomanExpenses.toString());
      emit(
        state.copyWith(
          status: CalculateExpenseStatus.success,
          tomanExpenses: tomanExpenses,
          rialExpenses: rialExpenses
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: CalculateExpenseStatus.error));
    }
  }

  // void _mapSumRialExpenseByMonthEventToState(
  //     SumRialExpensePerMonthEvent event, Emitter<CalculateExpenseState> emit) async {
  //   try {
  //     emit(state.copyWith(status: CalculateExpenseStatus.loading));
  //     String calculateExpense = await calculateExpensesRepository.calculateRialExpenseRepo();
  //     print("*********  "+ calculateExpense.toString());
  //     emit(
  //       state.copyWith(
  //         status: CalculateExpenseStatus.success,
  //         expenses: calculateExpense,
  //       ),
  //     );
  //   } catch (error) {
  //     emit(state.copyWith(status: CalculateExpenseStatus.error));
  //   }
  // }

  void _mapCalculateTomanSpentPerMonthEventToState(
      CalculateTomanSpentPerMonthEvent event, Emitter<CalculateExpenseState> emit) async {
    try {
      emit(state.copyWith(status: CalculateExpenseStatus.loading));
      String calculateTomanCash = await calculateExpensesRepository.calculateTomanCashRepo();
      String calculateRialCash = await calculateExpensesRepository.calculateRialCashRepo();
      emit(
        state.copyWith(
          status: CalculateExpenseStatus.success,
          calculateTomanCash: calculateTomanCash,
          calculateRialCash: calculateRialCash
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: CalculateExpenseStatus.error));
    }
  }
  //
  // void _mapCalculateRialSpentPerMonthEventToState(
  //     CalculateRialSpentPerMonthEvent event, Emitter<CalculateExpenseState> emit) async {
  //   try {
  //     emit(state.copyWith(status: CalculateExpenseStatus.loading));
  //     String calculateCash = await calculateExpensesRepository.calculateRialCashRepo();
  //     emit(
  //       state.copyWith(
  //         status: CalculateExpenseStatus.success,
  //         cash: calculateCash,
  //       ),
  //     );
  //   } catch (error) {
  //     emit(state.copyWith(status: CalculateExpenseStatus.error));
  //   }
  // }
}