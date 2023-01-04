import 'package:equatable/equatable.dart';

enum CashStatus { initial, success, error, loading }

extension CashStatusX on CashStatus {
  bool get isInitial => this == CashStatus.initial;
  bool get isSuccess => this == CashStatus.success;
  bool get isError => this == CashStatus.error;
  bool get isLoading => this == CashStatus.loading;
}

class CashState extends Equatable {

  const CashState({
    this.status = CashStatus.initial,
    String? cash,
  }): cash = cash ?? '';

  final CashStatus status;
  final String cash;

  @override
  // TODO: implement props
  List<Object> get props => [status, cash];

  CashState copyWith({
    CashStatus? status,
    String? cash
  }) {
    return CashState(
      status: status ?? this.status,
      cash: cash ?? this.cash,
    );
  }
}