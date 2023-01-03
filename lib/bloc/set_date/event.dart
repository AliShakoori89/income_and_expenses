
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

class AddToDate extends SetDateEvent{
  final DateTime date;

  AddToDate(
      {required this.date});

  @override
  List<Object> get props => [date];
}

class ReduceDate extends SetDateEvent{
  final DateTime date;

  ReduceDate(
      {required this.date});

  @override
  List<Object> get props => [date];
}