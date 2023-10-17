abstract class ChangeCurrencyEvent{
  List<Object> get props => [];
}

class WriteCurrencyBooleanEvent extends ChangeCurrencyEvent {

  final bool rialCurrencyBoolean;

  WriteCurrencyBooleanEvent(
      {required this.rialCurrencyBoolean});

  @override
  List<Object> get props => [rialCurrencyBoolean];
}

class ReadCurrencyBooleanEvent extends ChangeCurrencyEvent{}