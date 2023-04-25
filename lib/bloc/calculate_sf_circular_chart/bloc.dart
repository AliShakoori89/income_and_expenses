import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/bloc/calculate_sf_circular_chart/state.dart';
import 'package:income_and_expenses/repository/calculate_sf_circular_chart_repository.dart';
import 'event.dart';

class CalculateSFCircularChartBloc extends Bloc<CalculateSFCircularChartEvent, CalculateSFCircularChartState> {

  CalculateSFCircularChartRepository calculateSFCircularChartRepository = CalculateSFCircularChartRepository();

  CalculateSFCircularChartBloc(this.calculateSFCircularChartRepository) : super( const CalculateSFCircularChartState()){
    on<SumExpensesPerMonthForCircularChartEvent>(_mapSumExpensesPerMonthForCircularChartEventToState);
  }

  void _mapSumExpensesPerMonthForCircularChartEventToState(
      SumExpensesPerMonthForCircularChartEvent event, Emitter<CalculateSFCircularChartState> emit) async {
    try {
      emit(state.copyWith(status: CalculateSFCircularChartStatus.loading));
      print('22222222222           '+event.year);
      String farvardinExpenses = await calculateSFCircularChartRepository.calculateExpensePerMonthRepo(event.year, 'farvardin');
      String ordibeheshtExpenses = await calculateSFCircularChartRepository.calculateExpensePerMonthRepo(event.year, 'ordibehesht');
      String khordadExpenses = await calculateSFCircularChartRepository.calculateExpensePerMonthRepo(event.year, 'khordad');
      String tirExpenses = await calculateSFCircularChartRepository.calculateExpensePerMonthRepo(event.year, 'tir');
      String mordadExpenses = await calculateSFCircularChartRepository.calculateExpensePerMonthRepo(event.year, 'mordad');
      String shahrivarExpenses = await calculateSFCircularChartRepository.calculateExpensePerMonthRepo(event.year, 'shahrivar');
      String mehrExpenses = await calculateSFCircularChartRepository.calculateExpensePerMonthRepo(event.year, 'mehr');
      String abanExpenses = await calculateSFCircularChartRepository.calculateExpensePerMonthRepo(event.year, 'aban');
      String azarExpenses = await calculateSFCircularChartRepository.calculateExpensePerMonthRepo(event.year, 'azar');
      String deyExpenses = await calculateSFCircularChartRepository.calculateExpensePerMonthRepo(event.year, 'dey');
      String bahmanExpenses = await calculateSFCircularChartRepository.calculateExpensePerMonthRepo(event.year, 'bahman');
      String esfandExpenses = await calculateSFCircularChartRepository.calculateExpensePerMonthRepo(event.year, 'esfand');

      emit(
        state.copyWith(
          status: CalculateSFCircularChartStatus.success,
          farvardinExpenses: farvardinExpenses,
          ordibeheshtExpenses: ordibeheshtExpenses,
          khordadExpenses: khordadExpenses,
          tirExpenses: tirExpenses,
          mordadExpenses: mordadExpenses,
          shahrivarExpenses: shahrivarExpenses,
          mehrExpenses: mehrExpenses,
          abanExpenses: abanExpenses,
          azarExpenses: azarExpenses,
          deyExpenses: deyExpenses,
          bahmanExpenses: bahmanExpenses,
          esfandExpenses: esfandExpenses
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: CalculateSFCircularChartStatus.error));
    }
  }
}