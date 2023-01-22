abstract class ChangeCurrencyEvent{
  @override
  List<Object> get props => [];
}

class WriteCurrencyBooleanEvent extends ChangeCurrencyEvent {

  final bool currencyBoolean;

  WriteCurrencyBooleanEvent(
      {required this.currencyBoolean});

  @override
  List<Object> get props => [currencyBoolean];
}

class ReadCurrencyBooleanEvent extends ChangeCurrencyEvent{}