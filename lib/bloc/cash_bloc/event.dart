
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