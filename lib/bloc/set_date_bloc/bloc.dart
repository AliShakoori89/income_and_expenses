import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/event.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/state.dart';
import 'package:income_and_expenses/repository/date_time_repository.dart';

import '../../repository/calculate_repository.dart';
import '../../repository/expense_repository.dart';
import '../../repository/income_repository.dart';

class SetDateBloc extends Bloc<SetDateEvent, SetDateState> {

  SetDateRepository setDateRepository = SetDateRepository();
  IncomeRepository incomeRepository = IncomeRepository();
  CalculateRepository calculateExpensesRepository = CalculateRepository();

  SetDateBloc(this.setDateRepository, this.calculateExpensesRepository, this.incomeRepository) : super(
      const SetDateState()){
    on<ReadDateEvent>(_mapReadDateEventToState);
    on<WriteDateEvent>(_mapWriteDateEventToState);
    on<InitialDateEvent>(_mapInitialDateEventToState);
    on<AddToDateEvent>(_mapAddNextDateEventToState);
    on<ReduceDateEvent>(_mapReduceDateEventToState);
    on<AddIncomeEvent>(_mapAddIncomeEventToState);
    on<FetchIncomeEvent>(_mapFetchIncomeEventToState);
    on<SumExpensePerMonthEvent>(_mapSumExpenseByMonthEventToState);
    on<CalculateCashPerMonthEvent>(_mapCalculateCashPerMonthEventToState);
  }

  void _mapReadDateEventToState(
      ReadDateEvent event, Emitter<SetDateState> emit) async {
    try {
      emit(state.copyWith(status: SetDateStatus.loading));
      final String date = await setDateRepository.readDate();
      final String dateMonth = await setDateRepository.readDateMonth();
      emit(
        state.copyWith(
            status: SetDateStatus.success,
            date: date,
            dateMonth: dateMonth
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: SetDateStatus.error));
    }
  }

  void _mapWriteDateEventToState(
      WriteDateEvent event, Emitter<SetDateState> emit) async {
    try {
      emit(state.copyWith(status: SetDateStatus.loading));
      await setDateRepository.writeDate(event.date);
      final String date = await setDateRepository.readDate();
      final String dateMonth = await setDateRepository.readDateMonth();
      emit(
        state.copyWith(
          status: SetDateStatus.success,
          date: date,
          dateMonth: dateMonth
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: SetDateStatus.error));
    }
  }

  void _mapInitialDateEventToState(
      InitialDateEvent event, Emitter<SetDateState> emit) async {
    try {
      emit(state.copyWith(status: SetDateStatus.loading));
      await setDateRepository.initialDate();
      final String date = await setDateRepository.readDate();
      final String dateMonth = await setDateRepository.readDateMonth();
      emit(
        state.copyWith(
            status: SetDateStatus.success,
            date: date,
            dateMonth: dateMonth
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: SetDateStatus.error));
    }
  }

  void _mapAddNextDateEventToState(
      AddToDateEvent event, Emitter<SetDateState> emit) async {
    try {
      emit(state.copyWith(status: SetDateStatus.loading));
      await setDateRepository.addToDate(event.date);

      emit(
        state.copyWith(
          status: SetDateStatus.success,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: SetDateStatus.error));
    }
  }

  void _mapReduceDateEventToState(
      ReduceDateEvent event, Emitter<SetDateState> emit) async {
    try {
      emit(state.copyWith(status: SetDateStatus.loading));
      await setDateRepository.reduceDate(event.date);

      emit(
        state.copyWith(
          status: SetDateStatus.success,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: SetDateStatus.error));
    }
  }

  void _mapSumExpenseByMonthEventToState(
      SumExpensePerMonthEvent event, Emitter<SetDateState> emit) async {
    try {
      emit(state.copyWith(status: SetDateStatus.loading));
      String expenses = await calculateExpensesRepository.calculateExpenseRepo(event.dateMonth);
      emit(
        state.copyWith(
          status: SetDateStatus.success,
          expenses: expenses,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: SetDateStatus.error));
    }
  }

  void _mapCalculateCashPerMonthEventToState(
      CalculateCashPerMonthEvent event, Emitter<SetDateState> emit) async {
    try {
      emit(state.copyWith(status: SetDateStatus.loading));
      String calculateCash = await calculateExpensesRepository.calculateCashRepo(event.dateMonth);
      emit(
        state.copyWith(
          status: SetDateStatus.success,
          calculateCash: calculateCash,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: SetDateStatus.error));
    }
  }

  void _mapAddIncomeEventToState(
      AddIncomeEvent event, Emitter<SetDateState> emit) async {
    try {
      emit(state.copyWith(status: SetDateStatus.loading));
      await incomeRepository.addIncome(event.cash, event.month);
      emit(
        state.copyWith(
          status: SetDateStatus.success,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: SetDateStatus.error));
    }
  }

  void _mapFetchIncomeEventToState(
      FetchIncomeEvent event, Emitter<SetDateState> emit) async {
    try {
      emit(state.copyWith(status: SetDateStatus.loading));
      print("QQQQQQQQQQQQq    "+event.month);
      final String? income = await incomeRepository.readIncome(event.month);
      emit(
        state.copyWith(
          status: SetDateStatus.success,
          income: income,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: SetDateStatus.error));
    }
  }
}