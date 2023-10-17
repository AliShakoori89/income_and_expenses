import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/data/repository/theme_repository.dart';
import 'package:income_and_expenses/logic/bloc/them_bloc/event.dart';
import 'package:income_and_expenses/logic/bloc/them_bloc/state.dart';

class ThemeBloc extends Bloc<ThemEvent, ThemeState> {

  ChangeThemeRepository changeThemeRepository = ChangeThemeRepository();

  ThemeBloc(this.changeThemeRepository) : super( const ThemeState()){
    on<ReadThemeBooleanEvent>(_mapReadThemeBooleanEventToState);
    on<WriteThemeBooleanEvent>(_mapWriteThemeBooleanEventToState);
  }

  void _mapReadThemeBooleanEventToState(
      ReadThemeBooleanEvent event, Emitter<ThemeState> emit) async {
    try {
      emit(state.copyWith(status: ThemeStatus.loading));
      final String? themeBoolean = await changeThemeRepository.readThemeBoolean();
      emit(
        state.copyWith(
          status: ThemeStatus.success,
          themeBoolean: themeBoolean,
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
      await changeThemeRepository.writeThemeBoolean(event.darkThemeBoolean);
      await changeThemeRepository.readThemeBoolean();

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