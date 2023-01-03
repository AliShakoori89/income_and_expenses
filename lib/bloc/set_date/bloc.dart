import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/bloc/set_date/event.dart';
import 'package:income_and_expenses/bloc/set_date/state.dart';
import 'package:income_and_expenses/repository/date_time_repository.dart';

class SetDateBloc extends Bloc<SetDateEvent, SetDateState> {

  SetDateRepository setDateRepository = SetDateRepository();

  SetDateBloc(this.setDateRepository) : super( const SetDateState()){
    on<ReadDateEvent>(_mapReadDateEventToState);
    on<WriteDateEvent>(_mapWriteDateEventToState);
    on<AddToDate>(_mapAddNextDateEventToState);
    on<ReduceDate>(_mapReduceDateEventToState);
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

  void _mapWriteDateEventToState(
      WriteDateEvent event, Emitter<SetDateState> emit) async {
    try {
      emit(state.copyWith(status: SetDateStatus.loading));
      await setDateRepository.writeDate(event.date);
      await setDateRepository.readDate();

      emit(
        state.copyWith(
          status: SetDateStatus.success,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: SetDateStatus.error));
    }
  }

  void _mapAddNextDateEventToState(
      AddToDate event, Emitter<SetDateState> emit) async {
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
      ReduceDate event, Emitter<SetDateState> emit) async {
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
}