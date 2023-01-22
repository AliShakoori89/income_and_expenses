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

class WriteLanguageBooleanEvent extends ChangeLanguageEvent {

  final bool persianLanguageBoolean;

  WriteLanguageBooleanEvent(
      {required this.persianLanguageBoolean});

  @override
  List<Object> get props => [persianLanguageBoolean];
}

class ReadLanguageBooleanEvent extends ChangeLanguageEvent{}