import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/bloc/calculate_sf_cartesian_chart/state.dart';
import '../../repository/calculate_sf_cartesian_chart_repository.dart';
import 'event.dart';

class CalculateSFCartesianChartBloc extends Bloc<CalculateSFCartesianChartEvent, CalculateSFCartesianChartState> {

  CalculateSFCartesianChartRepository calculateSFCartesianChartRepository = CalculateSFCartesianChartRepository();

  CalculateSFCartesianChartBloc(this.calculateSFCartesianChartRepository) : super( const CalculateSFCartesianChartState()){
    on<SumExpensesByGroupingTypePerMonthForSFCartesianChartEvent>(_mapSumExpensesByGroupingTypePerMonthForSFCartesianChartEventToState);
  }

  void _mapSumExpensesByGroupingTypePerMonthForSFCartesianChartEventToState(
      SumExpensesByGroupingTypePerMonthForSFCartesianChartEvent event, Emitter<CalculateSFCartesianChartState> emit) async {
    try {
      emit(state.copyWith(status: CalculateSFCartesianChartStatus.loading));
      String buyItemsExpenses = await calculateSFCartesianChartRepository.calculateExpenseByGroupingTypePerMonthRepo(event.month ,'buy items' );
      String comestibleExpenses = await calculateSFCartesianChartRepository.calculateExpenseByGroupingTypePerMonthRepo(event.month ,'comestible');
      String transportationExpenses = await calculateSFCartesianChartRepository.calculateExpenseByGroupingTypePerMonthRepo(event.month ,'transportation');
      String giftsExpenses = await calculateSFCartesianChartRepository.calculateExpenseByGroupingTypePerMonthRepo(event.month, 'gifts');
      String treatmentExpenses = await calculateSFCartesianChartRepository.calculateExpenseByGroupingTypePerMonthRepo(event.month, 'treatment');
      String installmentsAndDebtExpenses = await calculateSFCartesianChartRepository.calculateExpenseByGroupingTypePerMonthRepo(event.month, 'installments and debt');
      String renovationExpenses = await calculateSFCartesianChartRepository.calculateExpenseByGroupingTypePerMonthRepo(event.month, 'renovation');
      String pastimeExpenses = await calculateSFCartesianChartRepository.calculateExpenseByGroupingTypePerMonthRepo(event.month, 'pastime');
      String etceteraExpenses = await calculateSFCartesianChartRepository.calculateExpenseByGroupingTypePerMonthRepo(event.month, 'etcetera');

      emit(
        state.copyWith(
          status: CalculateSFCartesianChartStatus.success,
          buyItemsExpenses: buyItemsExpenses,
          comestibleExpenses: comestibleExpenses,
          transportationExpenses: transportationExpenses,
          giftsExpenses: giftsExpenses,
          treatmentExpenses: treatmentExpenses,
          installmentsAndDebtExpenses: installmentsAndDebtExpenses,
          renovationExpenses: renovationExpenses,
          pastimeExpenses: pastimeExpenses,
          etceteraExpenses: etceteraExpenses,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: CalculateSFCartesianChartStatus.error));
    }
  }
}