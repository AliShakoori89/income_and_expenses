import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/bloc/change_language_bloc/event.dart';
import 'package:income_and_expenses/bloc/change_language_bloc/state.dart';
import 'package:income_and_expenses/repository/change_language_repository.dart';

class ChangeLanguageBloc extends Bloc<ChangeLanguageEvent, ChangeLanguageState> {

  ChangeLanguageRepository changeLanguageRepository = ChangeLanguageRepository();

  ChangeLanguageBloc(this.changeLanguageRepository) : super( const ChangeLanguageState()){
    on<WriteLanguageBooleanEvent>(_mapWriteLanguageBooleanEvenToState);
    on<ReadLanguageBooleanEvent>(_mapReadLanguageBooleanEvenToState);
  }

  void _mapWriteLanguageBooleanEvenToState(
      WriteLanguageBooleanEvent event, Emitter<ChangeLanguageState> emit) async {
    try {
      emit(state.copyWith(status: ChangeLanguageStatus.loading));
      changeLanguageRepository.writeLanguageBoolean(event.englishLanguageBoolean);
      emit(
        state.copyWith(
          status: ChangeLanguageStatus.success,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: ChangeLanguageStatus.error));
    }
  }

  void _mapReadLanguageBooleanEvenToState(
      ReadLanguageBooleanEvent event, Emitter<ChangeLanguageState> emit) async {
    try {
      emit(state.copyWith(status: ChangeLanguageStatus.loading));
      String? languageBoolean = await changeLanguageRepository.readLanguageBoolean();
      emit(
        state.copyWith(
          status: ChangeLanguageStatus.success,
          englishLanguageBoolean: languageBoolean == "false" ? false : true
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: ChangeLanguageStatus.error));
    }
  }
}