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
      String? buyItemsExpenses = await calculateSFCartesianChartRepository.calculateExpenseByGroupingTypePerMonthRepo(event.year, event.month ,'خرید اقلام');
      String? comestibleExpenses = await calculateSFCartesianChartRepository.calculateExpenseByGroupingTypePerMonthRepo(event.year,event.month ,'خوراکی');
      String? transportationExpenses = await calculateSFCartesianChartRepository.calculateExpenseByGroupingTypePerMonthRepo(event.year,event.month ,'حمل و نقل');
      String? giftsExpenses = await calculateSFCartesianChartRepository.calculateExpenseByGroupingTypePerMonthRepo(event.year,event.month, 'هدایا');
      String? treatmentExpenses = await calculateSFCartesianChartRepository.calculateExpenseByGroupingTypePerMonthRepo(event.year,event.month, 'درمانی');
      String? installmentsAndDebtExpenses = await calculateSFCartesianChartRepository.calculateExpenseByGroupingTypePerMonthRepo(event.year,event.month, 'اقساط و بدهی');
      String? renovationExpenses = await calculateSFCartesianChartRepository.calculateExpenseByGroupingTypePerMonthRepo(event.year,event.month, 'تعمیرات');
      String? pastimeExpenses = await calculateSFCartesianChartRepository.calculateExpenseByGroupingTypePerMonthRepo(event.year,event.month, 'تفریح' );
      String? etceteraExpenses = await calculateSFCartesianChartRepository.calculateExpenseByGroupingTypePerMonthRepo(event.year,event.month, 'سایر');

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