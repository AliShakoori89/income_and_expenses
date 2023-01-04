import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/bloc/cash_bloc/event.dart';
import 'package:income_and_expenses/bloc/cash_bloc/state.dart';
import 'package:income_and_expenses/bloc/expense_bloc/event.dart';
import 'package:income_and_expenses/bloc/expense_bloc/state.dart';
import 'package:income_and_expenses/repository/cash_repository.dart';
import 'package:income_and_expenses/repository/expense_repository.dart';

import '../../model/expense_model.dart';

class CashBloc extends Bloc<CashEvent, CashState> {

  CashRepository cashRepository = CashRepository();

  CashBloc(this.cashRepository) : super( const CashState()){
    on<AddCashEvent>(_mapAddCashEventToState);
    on<FetchCashEvent>(_mapFetchCashEventToState);
    on<AllExpensesEvent>(_mapAllExpensesEventToState);
  }
  void _mapAddCashEventToState(
      AddCashEvent event, Emitter<CashState> emit) async {
    try {
      emit(state.copyWith(status: CashStatus.loading));
      await cashRepository.addCash(event.cash);
      emit(
        state.copyWith(
          status: CashStatus.success,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: CashStatus.error));
    }
  }

  void _mapFetchCashEventToState(
      FetchCashEvent event, Emitter<CashState> emit) async {
    try {
      emit(state.copyWith(status: CashStatus.loading));
      final String? cash = await cashRepository.readCash();
      emit(
        state.copyWith(
          status: CashStatus.success,
          cash: cash,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: CashStatus.error));
    }
  }

  void _mapAllExpensesEventToState(
      AllExpensesEvent event, Emitter<CashState> emit) async {
    try {
      emit(state.copyWith(status: CashStatus.loading));
      final String? cash = await cashRepository.allExpenses(event.date, event.expense);
      emit(
        state.copyWith(
          status: CashStatus.success,
          cash: cash,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: CashStatus.error));
    }
  }
}