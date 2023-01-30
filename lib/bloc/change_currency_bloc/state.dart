import 'package:equatable/equatable.dart';

enum ChangeCurrencyStatus { initial, success, error, loading }

extension ChangeCurrencyStatusX on ChangeCurrencyStatus {
  bool get isInitial => this == ChangeCurrencyStatus.initial;
  bool get isSuccess => this == ChangeCurrencyStatus.success;
  bool get isError => this == ChangeCurrencyStatus.error;
  bool get isLoading => this == ChangeCurrencyStatus.loading;
}

class ChangeCurrencyState extends Equatable {

  const ChangeCurrencyState({
    this.status = ChangeCurrencyStatus.initial,
    bool? readCurrencyBoolean,
  }): readCurrencyBoolean = readCurrencyBoolean ?? true
  ;

  final ChangeCurrencyStatus status;
  final bool readCurrencyBoolean;

  @override
  List<Object> get props => [status, readCurrencyBoolean];

  ChangeCurrencyState copyWith({
    ChangeCurrencyStatus? status,
    bool? readCurrencyBoolean,
  }) {
    return ChangeCurrencyState(
      status: status ?? this.status,
      readCurrencyBoolean: readCurrencyBoolean ?? this.readCurrencyBoolean,
    );
  }
}