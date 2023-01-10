import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/bloc/change_language_bloc/event.dart';
import 'package:income_and_expenses/bloc/change_language_bloc/state.dart';
import 'package:income_and_expenses/repository/change_language_repository.dart';

class ChangeLanguageBloc extends Bloc<ChangeLanguageEvent, ChangeLanguageState> {

  ChangeLanguageRepository changeLanguageRepository = ChangeLanguageRepository();

  ChangeLanguageBloc(this.changeLanguageRepository) : super( const ChangeLanguageState()){
    on<ChangeToPersianLanguageTypeEvent>(_mapChangeLanguageTypeEventToState);
    on<ChangeToEnglishLanguageTypeEvent>(_mapChangeToEnglishTypeEventToState);
  }

  void _mapChangeLanguageTypeEventToState(
      ChangeToPersianLanguageTypeEvent event, Emitter<ChangeLanguageState> emit) async {
    try {
      emit(state.copyWith(status: ChangeLanguageStatus.loading));
      final bool persianCheckBox =
      changeLanguageRepository.changeLanguageRepository(event.value);
      final bool englishCheckBox =
      changeLanguageRepository.changeLanguageRepository(!event.value);
      emit(
        state.copyWith(
          status: ChangeLanguageStatus.success,
          persianCheckBox: persianCheckBox,
          englishCheckBox: englishCheckBox
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: ChangeLanguageStatus.error));
    }
  }

  void _mapChangeToEnglishTypeEventToState(
      ChangeToEnglishLanguageTypeEvent event, Emitter<ChangeLanguageState> emit) async {
    try {
      emit(state.copyWith(status: ChangeLanguageStatus.loading));
      final bool persianCheckBox =
      changeLanguageRepository.changeLanguageRepository(!event.value);
      final bool englishCheckBox =
      changeLanguageRepository.changeLanguageRepository(event.value);
      emit(
        state.copyWith(
            status: ChangeLanguageStatus.success,
            persianCheckBox: persianCheckBox,
            englishCheckBox: englishCheckBox
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: ChangeLanguageStatus.error));
    }
  }
}