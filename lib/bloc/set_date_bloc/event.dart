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

class AddToDateEvent extends SetDateEvent{
  final DateTime date;

  AddToDateEvent(
      {required this.date});

  @override
  List<Object> get props => [date];
}

class ReduceDateEvent extends SetDateEvent{
  final DateTime date;

  ReduceDateEvent(
      {required this.date});

  @override
  List<Object> get props => [date];
}

// class SelectDateEvent extends SetDateEvent{
//   final BuildContext context;
//   final DateTime date;
//
//   SelectDateEvent({required this.context, required this.date});
//   @override
//   List<Object> get props => [context, date];
// }