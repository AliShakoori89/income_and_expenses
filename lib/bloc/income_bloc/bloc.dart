// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:income_and_expenses/bloc/income_bloc/event.dart';
// import 'package:income_and_expenses/bloc/income_bloc/state.dart';
// import 'package:income_and_expenses/repository/income_repository.dart';
//
// class IncomeBloc extends Bloc<IncomeEvent, IncomeState> {
//
//   IncomeRepository incomeRepository = IncomeRepository();
//
//   IncomeBloc(this.incomeRepository) : super( const IncomeState()){
//     on<AddIncomeEvent>(_mapAddIncomeEventToState);
//     on<FetchIncomeEvent>(_mapFetchIncomeEventToState);
//   }
//   void _mapAddIncomeEventToState(
//       AddIncomeEvent event, Emitter<IncomeState> emit) async {
//     try {
//       emit(state.copyWith(status: IncomeStatus.loading));
//       await incomeRepository.addIncome(event.cash, event.month);
//       emit(
//         state.copyWith(
//           status: IncomeStatus.success,
//         ),
//       );
//     } catch (error) {
//       emit(state.copyWith(status: IncomeStatus.error));
//     }
//   }
//
//   void _mapFetchIncomeEventToState(
//       FetchIncomeEvent event, Emitter<IncomeState> emit) async {
//     try {
//       emit(state.copyWith(status: IncomeStatus.loading));
//       print("QQQQQQQQQQQQq    "+event.month);
//       final String? income = await incomeRepository.readIncome(event.month);
//       emit(
//         state.copyWith(
//           status: IncomeStatus.success,
//           income: income,
//         ),
//       );
//     } catch (error) {
//       emit(state.copyWith(status: IncomeStatus.error));
//     }
//   }
// }