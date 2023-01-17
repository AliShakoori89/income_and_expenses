import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/bloc/them_bloc/event.dart';
import 'package:income_and_expenses/bloc/them_bloc/state.dart';
import 'package:income_and_expenses/repository/date_time_repository.dart';

class ThemBloc extends Bloc<ThemEvent, ThemeState> {

  SetDateRepository setDateRepository = SetDateRepository();

  ThemBloc(this.setDateRepository) : super( const ThemeState()){
    on<ReadThemeBooleanEvent>(_mapReadThemeBooleanEventToState);
    on<WriteThemeBooleanEvent>(_mapWriteThemeBooleanEventToState);
  }

  void _mapReadThemeBooleanEventToState(
      ReadThemeBooleanEvent event, Emitter<ThemeState> emit) async {
    try {
      emit(state.copyWith(status: ThemeStatus.loading));
      final String date = await setDateRepository.readDate();
      final String dateMonth = await setDateRepository.readDateMonth();
      emit(
        state.copyWith(
          status: ThemeStatus.success,
          date: date,
          dateMonth: dateMonth
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: ThemeStatus.error));
    }
  }

  void _mapWriteThemeBooleanEventToState(
      WriteThemeBooleanEvent event, Emitter<ThemeState> emit) async {
    try {
      emit(state.copyWith(status: ThemeStatus.loading));
      await setDateRepository.writeDate(event.date);
      await setDateRepository.readDate();

      emit(
        state.copyWith(
          status: ThemeStatus.success,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: ThemeStatus.error));
    }
  }
}