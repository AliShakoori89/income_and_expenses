
abstract class ThemEvent{
  @override
  List<Object> get props => [];
}

class ReadThemeBooleanEvent extends ThemEvent {}

class WriteThemeBooleanEvent extends ThemEvent {
  final DateTime date;

  WriteThemeBooleanEvent(
      {required this.date});

  @override
  List<Object> get props => [date];
}