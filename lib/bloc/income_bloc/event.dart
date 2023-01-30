
abstract class IncomeEvent{
  @override
  List<Object> get props => [];
}

class FetchIncomeEvent extends IncomeEvent {}

class AddIncomeEvent extends IncomeEvent {

  final String cash;
  final String month;

  AddIncomeEvent(
      {required this.cash, required this.month});

  @override
  List<Object> get props => [cash, month];
}