import 'package:income_and_expenses/model/expense_model.dart';

abstract class SetDateEvent{
  @override
  List<Object> get props => [];
}

class ReadDateEvent extends SetDateEvent {}

class WriteDateEvent extends SetDateEvent {
  final String date;

  WriteDateEvent(
      {required this.date});

  @override
  List<Object> get props => [date];
}