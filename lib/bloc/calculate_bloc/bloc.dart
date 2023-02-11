// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:income_and_expenses/bloc/calculate_bloc/event.dart';
// import 'package:income_and_expenses/bloc/calculate_bloc/state.dart';
// import 'package:income_and_expenses/repository/calculate_repository.dart';
//
// class CalculateBloc extends Bloc<CalculateEvent, CalculateState> {
//
//   CalculateRepository calculateExpensesRepository = CalculateRepository();
//
//   CalculateBloc(this.calculateExpensesRepository) : super( const CalculateState()){
//     on<SumExpensePerMonthEvent>(_mapSumExpenseByMonthEventToState);
//     on<CalculateCashPerMonthEvent>(_mapCalculateCashPerMonthEventToState);
//   }
//
//   void _mapSumExpenseByMonthEventToState(
//       SumExpensePerMonthEvent event, Emitter<CalculateState> emit) async {
//     try {
//       emit(state.copyWith(status: CalculateExpenseStatus.loading));
//     String expenses = await calculateExpensesRepository.calculateExpenseRepo(event.dateMonth);
//       emit(
//         state.copyWith(
//           status: CalculateExpenseStatus.success,
//           expenses: expenses,
//         ),
//       );
//     } catch (error) {
//       emit(state.copyWith(status: CalculateExpenseStatus.error));
//     }
//   }
//
//   void _mapCalculateCashPerMonthEventToState(
//       CalculateCashPerMonthEvent event, Emitter<CalculateState> emit) async {
//     try {
//       emit(state.copyWith(status: CalculateExpenseStatus.loading));
//       String calculateCash = await calculateExpensesRepository.calculateCashRepo(event.dateMonth);
//       emit(
//         state.copyWith(
//           status: CalculateExpenseStatus.success,
//           calculateCash: calculateCash,
//         ),
//       );
//     } catch (error) {
//       emit(state.copyWith(status: CalculateExpenseStatus.error));
//     }
//   }
//
// }