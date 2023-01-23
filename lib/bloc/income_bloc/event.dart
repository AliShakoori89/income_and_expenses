
abstract class IncomeEvent{
  @override
  List<Object> get props => [];
}

class FetchIncomeEvent extends IncomeEvent {}

class AddIncomeEvent extends IncomeEvent {

  final String cash;

  AddIncomeEvent(
      {required this.cash});

  @override
  List<Object> get props => [cash];
}