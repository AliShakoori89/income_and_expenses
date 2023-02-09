import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/event.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/state.dart';
import 'package:income_and_expenses/repository/date_time_repository.dart';

import '../../repository/calculate_repository.dart';
import '../../repository/expense_repository.dart';
import '../../repository/income_repository.dart';

class SetDateBloc extends Bloc<SetDateEvent, SetDateState> {

  SetDateRepository setDateRepository = SetDateRepository();

  SetDateBloc(this.setDateRepository) : super( SetDateState()){
    // on<ReadShamsiDateEvent>(_mapReadShamsiDateEventToState);
    on<ReadDateEvent>(_mapReadDateEventToState);
    on<WriteDateEvent>(_mapWriteDateEventToState);
    on<WriteDateFirstEvent>(_mapWriteDateFirstEventToState);
    on<AddToDateEvent>(_mapAddNextDateEventToState);
    on<ReduceDateEvent>(_mapReduceDateEventToState);
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

  // void _mapReadShamsiDateEventToState(
  //     ReadShamsiDateEvent event, Emitter<SetDateState> emit) async {
  //   try {
  //     emit(state.copyWith(status: SetDateStatus.loading));
  //     final String date = await setDateRepository.readShamsiDate();
  //     final String dateMonth = await setDateRepository.readShamsiDateMonth();
  //     emit(
  //       state.copyWith(
  //           status: SetDateStatus.success,
  //           date: date,
  //           dateMonth: dateMonth
  //       ),
  //     );
  //   } catch (error) {
  //     emit(state.copyWith(status: SetDateStatus.error));
  //   }
  // }

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

  void _mapWriteDateFirstEventToState(
      WriteDateFirstEvent event, Emitter<SetDateState> emit) async {
    try {
      emit(state.copyWith(status: SetDateStatus.loading));
      await setDateRepository.writeDateFirst(event.date);
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
}