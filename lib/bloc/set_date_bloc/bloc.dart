import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/event.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/state.dart';
import 'package:income_and_expenses/repository/date_time_repository.dart';

class SetDateBloc extends Bloc<SetDateEvent, SetDateState> {

  SetDateRepository setDateRepository = SetDateRepository();

  SetDateBloc(this.setDateRepository) : super( const SetDateState()){
    on<ReadDateEvent>(_mapReadDateEventToState);
    on<WriteDateEvent>(_mapWriteDateEventToState);
    on<AddToDateEvent>(_mapAddNextDateEventToState);
    on<ReduceDateEvent>(_mapReduceDateEventToState);
    on<SelectDateEvent>(_mapSelectDateEventToState);
  }

  void _mapReadDateEventToState(
      ReadDateEvent event, Emitter<SetDateState> emit) async {
    try {
      emit(state.copyWith(status: SetDateStatus.loading));
      final String date = await setDateRepository.readDate();
      final String dateMonth = await setDateRepository.readDateMonth();
      emit(
        state.copyWith(
          status: SetDateStatus.success,
          date: date,
          dateMonth: dateMonth
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
      final String date = await setDateRepository.readDate();
      final String dateMonth = await setDateRepository.readDateMonth();
      emit(
        state.copyWith(
          status: SetDateStatus.success,
          date: date,
          dateMonth: dateMonth
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
      ReduceDateEvent event, Emitter<SetDateState> emit) async {
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

  void _mapSelectDateEventToState(
      SelectDateEvent event, Emitter<SetDateState> emit) async {
    try {
      emit(state.copyWith(status: SetDateStatus.loading));
      final String selectDate = await setDateRepository.selectDate(event.context);

      print("EEEEEEEEEEEEEE   "+selectDate);
      // final String date = await setDateRepository.readDate();
      // final String dateMonth = await setDateRepository.readDateMonth();
      // await setDateRepository.writeDate(DateTime.parse(date) , DateTime.parse(dateMonth));
      emit(
        state.copyWith(
          status: SetDateStatus.success,
          // date: date,
          // dateMonth: dateMonth,
          selectDate: selectDate
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: SetDateStatus.error));
    }
  }
}