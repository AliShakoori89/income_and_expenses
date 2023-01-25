abstract class ChangeLanguageEvent{
  @override
  List<Object> get props => [];
}

class WriteLanguageBooleanEvent extends ChangeLanguageEvent {

  final bool persianLanguageBoolean;

  WriteLanguageBooleanEvent(
      {required this.persianLanguageBoolean});

  @override
  List<Object> get props => [persianLanguageBoolean];
}

class ReadLanguageBooleanEvent extends ChangeLanguageEvent{}