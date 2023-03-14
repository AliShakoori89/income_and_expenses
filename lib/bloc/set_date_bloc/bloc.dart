import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/event.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/state.dart';
import 'package:income_and_expenses/repository/date_time_repository.dart';
import '../../model/expense_model.dart';
import '../../repository/calculate_repository.dart';
import '../../repository/income_repository.dart';

class SetDateBloc extends Bloc<SetDateEvent, SetDateState> {

  SetDateRepository setDateRepository = SetDateRepository();
  IncomeRepository incomeRepository = IncomeRepository();
  CalculateRepository calculateExpensesRepository = CalculateRepository();

  SetDateBloc(this.setDateRepository, this.calculateExpensesRepository, this.incomeRepository) : super(
      const SetDateState()){
    on<ReadDateEvent>(_mapReadDateEventToState);
    on<ReadDateMonthEvent>(_mapReadDateMonthEventToState);
    on<WriteDateEvent>(_mapWriteDateEventToState);
    on<InitialDateEvent>(_mapInitialDateEventToState);
    on<AddToDateEvent>(_mapAddNextDateEventToState);
    on<ReduceDateEvent>(_mapReduceDateEventToState);
    on<AddIncomeEvent>(_mapAddIncomeEventToState);
    on<FetchIncomeEvent>(_mapFetchIncomeEventToState);
    on<SumExpensePerMonthEvent>(_mapSumExpenseByMonthEventToState);
    on<CalculateCashPerMonthEvent>(_mapCalculateCashPerMonthEventToState);
    on<FetchExpensesEvent>(_mapFetchExpensesEventToState);
    on<AddOneByOneExpenseEvent>(_mapAddExpenseEventToState);
    on<EditItemEvent>(_mapEditExpenseEventToState);
    on<AddTodayExpensesEvent>(_mapAddTodayExpensesEventToState);
    on<ReadTodayExpensesEvent>(_mapReadTodayExpensesEventToState);
  }

  void _mapReadDateEventToState(
      ReadDateEvent event, Emitter<SetDateState> emit) async {
    try {
      emit(state.copyWith(status: SetDateStatus.loading));
      final String date = await setDateRepository.readDate();
      emit(
        state.copyWith(
            status: SetDateStatus.success,
            date: date,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: SetDateStatus.error));
    }
  }

  void _mapReadDateMonthEventToState(
      ReadDateMonthEvent event, Emitter<SetDateState> emit) async {
    try {
      emit(state.copyWith(status: SetDateStatus.loading));
      final String dateMonth = await setDateRepository.readDateMonth();
      emit(
        state.copyWith(
            status: SetDateStatus.success,
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
      await setDateRepository.writeDate(event.date , event.dateMonth);
      // final String date = await setDateRepository.readDate();
      // final String dateMonth = await setDateRepository.readDateMonth();
      emit(
        state.copyWith(
          status: SetDateStatus.success,
          // date: date,
          // dateMonth: dateMonth
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

  void _mapFetchExpensesEventToState(
      FetchExpensesEvent event, Emitter<SetDateState> emit) async {
    try {
      emit(state.copyWith(status: SetDateStatus.loading));

      final List<ExpenseModel> expensesDetails =
      await setDateRepository.getAllExpensesRepo(event.date);
      emit(
        state.copyWith(
          status: SetDateStatus.success,
          expensesDetails: expensesDetails,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: SetDateStatus.error));
    }
  }

  void _mapAddExpenseEventToState(
      AddOneByOneExpenseEvent event, Emitter<SetDateState> emit) async {
    try {
      emit(state.copyWith(status: SetDateStatus.loading));
      await setDateRepository.addExpenseRepo(event.expenseModel);
      emit(
        state.copyWith(
          status: SetDateStatus.success,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: SetDateStatus.error));
    }
  }

  void _mapEditExpenseEventToState(
      EditItemEvent event, Emitter<SetDateState> emit) async {
    try {
      emit(state.copyWith(status: SetDateStatus.loading));
      await setDateRepository.updateItem(event.expenseModel);
      emit(
        state.copyWith(
          status: SetDateStatus.success,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: SetDateStatus.error));
    }
  }

  void _mapAddTodayExpensesEventToState(
      AddTodayExpensesEvent event, Emitter<SetDateState> emit) async {
    try {
      emit(state.copyWith(status: SetDateStatus.loading));
      await setDateRepository.addTodayExpensesRepo(event.todayExpensesDetails);
      emit(
        state.copyWith(
          status: SetDateStatus.success,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: SetDateStatus.error));
    }
  }

  void _mapReadTodayExpensesEventToState(
      ReadTodayExpensesEvent event, Emitter<SetDateState> emit) async {
    try {
      emit(state.copyWith(status: SetDateStatus.loading));
      final String? todayExpensesDetails = await setDateRepository.readTodayExpensesRepo();
      emit(
        state.copyWith(
            status: SetDateStatus.success,
            todayExpenses: todayExpensesDetails
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: SetDateStatus.error));
    }
  }
}