abstract class ChangeLanguageEvent{
  @override
  List<Object> get props => [];
}

class ChangeToPersianLanguageTypeEvent extends ChangeLanguageEvent {

  final bool value;

  ChangeToPersianLanguageTypeEvent(
      {required this.value});

  @override
  List<Object> get props => [value];
}

class ChangeToEnglishLanguageTypeEvent extends ChangeLanguageEvent {

  final bool value;

  ChangeToEnglishLanguageTypeEvent(
      {required this.value});

  @override
  List<Object> get props => [value];
}