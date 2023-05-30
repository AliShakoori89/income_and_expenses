import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/event.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/state.dart';
import 'package:income_and_expenses/model/income_model.dart';
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
    on<DeleteItemEvent>(_mapDeleteTodayExpensesEventToState);
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
      emit(state.copyWith(status: SetDateStatus.loading));
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
      await incomeRepository.addIncome(event.incomeModel);
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
      final String incomePerMonth = await incomeRepository.readIncome(event.month);
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
    print("222222222222222222222222222222");
    try {
      emit(state.copyWith(status: SetDateStatus.loading));
      print("222222222222222222222222222222");
      final List<IncomeModel> incomeDetails =
      await incomeRepository.getAllIncomeItems(event.month);
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
      await setDateRepository.addExpenseRepo(event.expenseModel);
      final List<ExpenseModel> expensesDetails =
      await setDateRepository.getAllExpensesItemsRepo(event.date);
      emit(
        state.copyWith(
          status: SetDateStatus.success,
          expenseDetails: expensesDetails,
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
      emit(
        state.copyWith(
          status: SetDateStatus.success,
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
      DeleteItemEvent event, Emitter<SetDateState> emit) async {
    try {
      emit(state.copyWith(status: SetDateStatus.loading));
      await setDateRepository.deleteExpensesRepo(event.id);
      final List<ExpenseModel> expenses = await setDateRepository.getAllExpensesItemsRepo(event.date);
      emit(
        state.copyWith(
          status: SetDateStatus.success,
          expenseDetails : expenses,
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