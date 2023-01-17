import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/bloc/them_bloc/event.dart';
import 'package:income_and_expenses/bloc/them_bloc/state.dart';
import 'package:income_and_expenses/repository/theme_repository.dart';

class ThemBloc extends Bloc<ThemEvent, ThemeState> {

  ChangeThemeRepository changeThemeRepository = ChangeThemeRepository();

  ThemBloc(this.changeThemeRepository) : super( const ThemeState()){
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
      await changeThemeRepository.writeThemeBoolean(event.themeBoolean);
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