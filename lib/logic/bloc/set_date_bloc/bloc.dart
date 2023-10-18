import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/data/model/expense_model.dart';
import 'package:income_and_expenses/data/model/income_model.dart';
import 'package:income_and_expenses/data/repository/calculate_repository.dart';
import 'package:income_and_expenses/data/repository/date_time_repository.dart';
import 'package:income_and_expenses/logic/bloc/set_date_bloc/event.dart';
import 'package:income_and_expenses/logic/bloc/set_date_bloc/state.dart';


class SetDateBloc extends Bloc<SetDateEvent, SetDateState> {

  SetDateRepository setDateRepository = SetDateRepository();
  CalculateRepository calculateExpensesRepository = CalculateRepository();

  SetDateBloc(this.setDateRepository, this.calculateExpensesRepository) : super(
      const SetDateState()){
    on<ReadDateEvent>(_mapReadDateEventToState);
    on<ReadMonthEvent>(_mapReadDateMonthEventToState);
    on<WriteDateEvent>(_mapWriteDateEventToState);
    on<InitialDateEvent>(_mapInitialDateEventToState);
    on<AddToDateEvent>(_mapAddNextDateEventToState);
    on<ReduceDateEvent>(_mapReduceDateEventToState);
    on<AddIncomeEvent>(_mapAddIncomeEventToState);
    on<FetchIncomeEvent>(_mapFetchIncomeEventToState);
    on<SumExpensePerMonthEvent>(_mapSumExpensePerMonthEventToState);
    on<SumExpensePerDateEvent>(_mapSumExpensePerDateEventToState);
    on<CalculateCashPerMonthEvent>(_mapCalculateCashPerMonthEventToState);
    on<FetchExpensesItemsEvent>(_mapFetchExpensesEventToState);
    on<AddOneByOneExpenseEvent>(_mapAddExpenseEventToState);
    on<EditExpenseItemsEvent>(_mapEditExpenseEventToState);
    on<EditIncomeItemsEvent>(_mapEditIncomeEventToState);
    on<AddTodayExpensesEvent>(_mapAddTodayExpensesEventToState);
    on<DeleteExpenseEvent>(_mapDeleteTodayExpensesEventToState);
    on<DeleteIncomeEvent>(_mapDeleteTodayIncomeEventToState);
    on<FetchAllIncomeItemsEvent>(_mapFetchAllIncomeItemsEventEventToState);
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
      ReadMonthEvent event, Emitter<SetDateState> emit) async {
    try {
      emit(state.copyWith(status: SetDateStatus.loading));
      final String month = await setDateRepository.readMonth();
      emit(
        state.copyWith(
            status: SetDateStatus.success,
            month: month
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
      await setDateRepository.writeDate(event.date , event.month);
      emit(
        state.copyWith(
          status: SetDateStatus.success,
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
      final String month = await setDateRepository.readMonth();
      emit(
        state.copyWith(
            status: SetDateStatus.success,
            date: date,
            month: month
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
      await setDateRepository.addToDate(event.date, event.month);

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

      await setDateRepository.reduceDate(event.date, event.month);

      emit(
        state.copyWith(
          status: SetDateStatus.success,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: SetDateStatus.error));
    }
  }

  void _mapFetchExpensesEventToState(
      FetchExpensesItemsEvent event, Emitter<SetDateState> emit) async {
    try {

      final List<ExpenseModel> expensesDetails =
      await setDateRepository.getAllExpensesItemsRepo(event.date);
      final String expensesPerDate =
      await calculateExpensesRepository.calculateDayExpenseRepo(event.date);
      emit(
        state.copyWith(
          status: SetDateStatus.success,
          expenseDetails: expensesDetails,
          expensesPerDate: expensesPerDate
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: SetDateStatus.error));
    }
  }

  void _mapSumExpensePerMonthEventToState(
      SumExpensePerMonthEvent event, Emitter<SetDateState> emit) async {
    try {
      emit(state.copyWith(status: SetDateStatus.loading));
      String expensesPerMonth = await calculateExpensesRepository.calculateExpenseRepo(event.month);
      emit(
        state.copyWith(
          status: SetDateStatus.success,
          expensesPerMonth: expensesPerMonth,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: SetDateStatus.error));
    }
  }

  void _mapSumExpensePerDateEventToState(
      SumExpensePerDateEvent event, Emitter<SetDateState> emit) async {
    try {
      final String expensesPerDate =
      await calculateExpensesRepository.calculateDayExpenseRepo(event.date);
      emit(
        state.copyWith(
          status: SetDateStatus.success,
          expensesPerDate: expensesPerDate,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: SetDateStatus.error));
    }
  }

  void _mapCalculateCashPerMonthEventToState(
      CalculateCashPerMonthEvent event, Emitter<SetDateState> emit) async {
    try {
      emit(state.copyWith(status: SetDateStatus.loading, expenseDetails: []));
      String calculateCash = await calculateExpensesRepository.calculateCash(event.month);
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
      await setDateRepository.addIncome(event.incomeModel);
      final String incomePerMonth = await setDateRepository.readIncome(event.month);
      String calculateCash = await calculateExpensesRepository.calculateCash(event.month);
      emit(
        state.copyWith(
          status: SetDateStatus.success,
          incomePerMonth: incomePerMonth,
          calculateCash: calculateCash
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
      final String incomePerMonth = await setDateRepository.readIncome(event.month);
      emit(
        state.copyWith(
          status: SetDateStatus.success,
          incomePerMonth: incomePerMonth
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: SetDateStatus.error));
    }
  }

  void _mapFetchAllIncomeItemsEventEventToState(
      FetchAllIncomeItemsEvent event, Emitter<SetDateState> emit) async {
    try {
      emit(state.copyWith(status: SetDateStatus.loading));
      final List<IncomeModel> incomeDetails =
      await setDateRepository.getAllIncomeItems(event.month);
      emit(
        state.copyWith(
            status: SetDateStatus.success,
            incomeDetails: incomeDetails
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: SetDateStatus.error));
    }
  }

  void _mapAddExpenseEventToState(
      AddOneByOneExpenseEvent event, Emitter<SetDateState> emit) async {
    try {
      await setDateRepository.initialDate();
      final String date = await setDateRepository.readDate();
      final String month = await setDateRepository.readMonth();
      await setDateRepository.addExpenseRepo(event.expenseModel);
      final List<ExpenseModel> expensesDetails =
      await setDateRepository.getAllExpensesItemsRepo(date);
      String calculateCash = await calculateExpensesRepository.calculateCash(event.month);
      final String expensesPerDate =
      await calculateExpensesRepository.calculateDayExpenseRepo(event.date);
      String expensesPerMonth = await calculateExpensesRepository.calculateExpenseRepo(event.month);
      emit(
        state.copyWith(
          status: SetDateStatus.success,
          expenseDetails: expensesDetails,
          calculateCash: calculateCash,
          expensesPerDate: expensesPerDate,
          expensesPerMonth: expensesPerMonth,

        ),
      );
    } catch (error) {
      emit(state.copyWith(status: SetDateStatus.error));
    }
  }

  void _mapEditExpenseEventToState(
      EditExpenseItemsEvent event, Emitter<SetDateState> emit) async {
    try {
      emit(state.copyWith(status: SetDateStatus.loading));
      await setDateRepository.updateExpenseItem(event.expenseModel);
      final String expensesPerDate =
      await calculateExpensesRepository.calculateDayExpenseRepo(event.date);
      final List<ExpenseModel> expensesDetails =
      await setDateRepository.getAllExpensesItemsRepo(event.date);
      String calculateCash = await calculateExpensesRepository.calculateCash(event.month);
      String expensesPerMonth = await calculateExpensesRepository.calculateExpenseRepo(event.month);
      emit(
        state.copyWith(
          status: SetDateStatus.success,
          expensesPerDate: expensesPerDate,
          expenseDetails: expensesDetails,
          calculateCash: calculateCash,
          expensesPerMonth: expensesPerMonth,

        ),
      );
    } catch (error) {
      emit(state.copyWith(status: SetDateStatus.error));
    }
  }

  void _mapEditIncomeEventToState(
      EditIncomeItemsEvent event, Emitter<SetDateState> emit) async {
    try {
      emit(state.copyWith(status: SetDateStatus.loading));
      await setDateRepository.updateIncomeItem(event.incomeModel);
      emit(
        state.copyWith(
          status: SetDateStatus.success,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: SetDateStatus.error));
    }
  }

  void _mapDeleteTodayExpensesEventToState(
      DeleteExpenseEvent event, Emitter<SetDateState> emit) async {
    try {
      emit(state.copyWith(status: SetDateStatus.loading));
      await setDateRepository.deleteExpenseRepo(event.id);
      final List<ExpenseModel> expenses = await setDateRepository.getAllExpensesItemsRepo(event.date);
      String calculateCash = await calculateExpensesRepository.calculateCash(event.month);
      await calculateExpensesRepository.calculateDayExpenseRepo(event.date);
      final String incomePerMonth = await setDateRepository.readIncome(event.month);
      final String expensesPerDate =
      await calculateExpensesRepository.calculateDayExpenseRepo(event.date);
      emit(
        state.copyWith(
          status: SetDateStatus.success,
          expenseDetails : expenses,
          calculateCash: calculateCash,
          incomePerMonth: incomePerMonth,
          expensesPerDate: expensesPerDate,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: SetDateStatus.error));
    }
  }

  void _mapDeleteTodayIncomeEventToState(
      DeleteIncomeEvent event, Emitter<SetDateState> emit) async {
    try {
      emit(state.copyWith(status: SetDateStatus.loading));
      await setDateRepository.deleteIncomeRepo(event.id);
      final List<IncomeModel> incomes = await setDateRepository.getAllIncomeItems(event.date);
      String calculateCash = await calculateExpensesRepository.calculateCash(event.month);
      await calculateExpensesRepository.calculateDayExpenseRepo(event.date);
      final String incomePerMonth = await setDateRepository.readIncome(event.month);
      emit(
        state.copyWith(
          status: SetDateStatus.success,
          incomeDetails: incomes,
          calculateCash: calculateCash,
          incomePerMonth: incomePerMonth
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
}