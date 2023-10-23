
abstract class ThemEvent{
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

class ChangeIndexEvent extends ThemEvent {
  final int index;

  ChangeIndexEvent(
      {required this.index});

  @override
  List<Object> get props => [index];
}