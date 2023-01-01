
abstract class SetDateEvent{
  @override
  List<Object> get props => [];
}

class ReadDateEvent extends SetDateEvent {}

class WriteDateEvent extends SetDateEvent {
  final DateTime date;

  WriteDateEvent(
      {required this.date});

  @override
  List<Object> get props => [date];
}

class AddNextDate extends SetDateEvent{
  final DateTime date;

  AddNextDate(
      {required this.date});

  @override
  List<Object> get props => [date];
}