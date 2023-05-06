abstract class ChangeLanguageEvent{
  List<Object> get props => [];
}

class WriteLanguageBooleanEvent extends ChangeLanguageEvent {

  final bool englishLanguageBoolean;

  WriteLanguageBooleanEvent(
      {required this.englishLanguageBoolean});

  @override
  List<Object> get props => [englishLanguageBoolean];
}

class ReadLanguageBooleanEvent extends ChangeLanguageEvent{}