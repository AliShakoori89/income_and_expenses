import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/bloc/change_currency_bloc/state.dart';
import '../../repository/change_currecy_repository.dart';
import 'event.dart';

class ChangeCurrencyBloc extends Bloc<ChangeCurrencyEvent, ChangeCurrencyState> {

  ChangeCurrencyRepository changeCurrencyRepository = ChangeCurrencyRepository();

  ChangeCurrencyBloc(this.changeCurrencyRepository) : super( const ChangeCurrencyState()){
    on<WriteCurrencyBooleanEvent>(_mapWriteCurrencyBooleanEvenToState);
    on<ReadCurrencyBooleanEvent>(_mapReadCurrencyBooleanEvenToState);
  }

  void _mapWriteCurrencyBooleanEvenToState(
      WriteCurrencyBooleanEvent event, Emitter<ChangeCurrencyState> emit) async {
    try {
      emit(state.copyWith(status: ChangeCurrencyStatus.loading));
      changeCurrencyRepository.writeCurrencyBoolean(false);
      emit(
        state.copyWith(
          status: ChangeCurrencyStatus.success,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: ChangeCurrencyStatus.error));
    }
  }

  void _mapReadCurrencyBooleanEvenToState(
      ReadCurrencyBooleanEvent event, Emitter<ChangeCurrencyState> emit) async {
    try {
      emit(state.copyWith(status: ChangeCurrencyStatus.loading));
      String? CurrencyBoolean = await changeCurrencyRepository.readCurrencyBoolean();
      emit(
        state.copyWith(
          status: ChangeCurrencyStatus.success,
          readCurrencyBoolean: CurrencyBoolean == "false" ? false : true
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: ChangeCurrencyStatus.error));
    }
  }
}