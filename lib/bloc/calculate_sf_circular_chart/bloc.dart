import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/bloc/calculate_sf_circular_chart/state.dart';
import 'package:income_and_expenses/repository/calculate_sf_circular_chart_repository.dart';
import 'event.dart';

class CalculateSFCircularChartBloc extends Bloc<CalculateSFCircularChartEvent, CalculateSFCircularChartState> {

  CalculateSFCircularChartRepository calculateSFCircularChartRepository = CalculateSFCircularChartRepository();

  CalculateSFCircularChartBloc(this.calculateSFCircularChartRepository) : super( const CalculateSFCircularChartState()){
    on<SumExpenseForCircularChartEvent>(_mapSumExpenseForCircularChartEventToState);
  }

  void _mapSumExpenseForCircularChartEventToState(
      SumExpenseForCircularChartEvent event, Emitter<CalculateSFCircularChartState> emit) async {
    try {
      emit(state.copyWith(status: CalculateSFCircularChartStatus.loading));
    // String expenses = await calculateSFCircularChartRepository.calculateSFCircularChartRepo();
    // print("*********  "+ expenses.toString());
      emit(
        state.copyWith(
          status: CalculateSFCircularChartStatus.success,
          // expenses: expenses,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: CalculateSFCircularChartStatus.error));
    }
  }
}