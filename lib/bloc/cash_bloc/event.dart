
abstract class CashEvent{
  @override
  List<Object> get props => [];
}

class FetchCashEvent extends CashEvent {}

class AddCashEvent extends CashEvent {

  final String cash;

  AddCashEvent(
      {required this.cash});

  @override
  List<Object> get props => [cash];
}

class AllExpensesEvent extends CashEvent {

  final String date;
  final String expense;

  AllExpensesEvent(
      {required this.date, required this.expense});

  @override
  List<Object> get props => [date, expense];
}