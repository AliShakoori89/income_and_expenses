import 'package:equatable/equatable.dart';
import 'package:income_and_expenses/model/expense_model.dart';

enum SetDateStatus { initial, success, error, loading }

extension SetDateStatusX on SetDateStatus {
  bool get isInitial => this == SetDateStatus.initial;
  bool get isSuccess => this == SetDateStatus.success;
  bool get isError => this == SetDateStatus.error;
  bool get isLoading => this == SetDateStatus.loading;
}

class SetDateState extends Equatable {

  const SetDateState({
    this.status = SetDateStatus.initial,
    String? date,
  }): date = date ?? '';

  final SetDateStatus status;
  final String date;

  @override
  // TODO: implement props
  List<Object> get props => [status, date];

  SetDateState copyWith({
    SetDateStatus? status,
    String? date
  }) {
    return SetDateState(
      status: status ?? this.status,
      date: date ?? this.date,
    );
  }
}