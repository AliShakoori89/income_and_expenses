
abstract class ThemEvent{
  @override
  List<Object> get props => [];
}

class ReadThemeBooleanEvent extends ThemEvent {}

class WriteThemeBooleanEvent extends ThemEvent {
  final bool themeBoolean;

  WriteThemeBooleanEvent(
      {required this.themeBoolean});

  @override
  List<Object> get props => [themeBoolean];
}