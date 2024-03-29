import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/data/repository/change_currency_repository.dart';
import 'package:income_and_expenses/logic/bloc/change_currency_bloc/state.dart';
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
      changeCurrencyRepository.writeRialCurrencyBoolean(event.rialCurrencyBoolean);
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
      String? currencyBoolean = await changeCurrencyRepository.readRialCurrencyBoolean();
      emit(
        state.copyWith(
          status: ChangeCurrencyStatus.success,
          readCurrencyBoolean: currencyBoolean == "true" ? true : false
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: ChangeCurrencyStatus.error));
    }
  }
}