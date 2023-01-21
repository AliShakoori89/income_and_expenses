
abstract class ThemEvent{
  @override
  List<Object> get props => [];
}

class ReadThemeBooleanEvent extends ThemEvent {}

class WriteThemeBooleanEvent extends ThemEvent {
  final bool darkThemeBoolean;

  WriteThemeBooleanEvent(
      {required this.darkThemeBoolean});

  @override
  List<Object> get props => [darkThemeBoolean];
}