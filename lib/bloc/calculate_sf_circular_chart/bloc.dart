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
      String farvardinExpenses = await calculateSFCircularChartRepository.calculateExpensePerMonthRepo('farvardin');
      String ordibeheshtExpenses = await calculateSFCircularChartRepository.calculateExpensePerMonthRepo('ordibehesht');
      String khordadExpenses = await calculateSFCircularChartRepository.calculateExpensePerMonthRepo('khordad');
      String tirExpenses = await calculateSFCircularChartRepository.calculateExpensePerMonthRepo('tir');
      String mordadExpenses = await calculateSFCircularChartRepository.calculateExpensePerMonthRepo('mordad');
      String shahrivarExpenses = await calculateSFCircularChartRepository.calculateExpensePerMonthRepo('shahrivar');
      String mehrExpenses = await calculateSFCircularChartRepository.calculateExpensePerMonthRepo('mehr');
      String abanExpenses = await calculateSFCircularChartRepository.calculateExpensePerMonthRepo('aban');
      String azarExpenses = await calculateSFCircularChartRepository.calculateExpensePerMonthRepo('azar');
      String deyExpenses = await calculateSFCircularChartRepository.calculateExpensePerMonthRepo('dey');
      String bahmanExpenses = await calculateSFCircularChartRepository.calculateExpensePerMonthRepo('bahman');
      String esfandExpenses = await calculateSFCircularChartRepository.calculateExpensePerMonthRepo('esfand');

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