import 'package:equatable/equatable.dart';

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
    String? dateMonth,
  }): date = date ?? '' , dateMonth = dateMonth ?? '';

  final SetDateStatus status;
  final String date;
  final String dateMonth;

  @override
  // TODO: implement props
  List<Object> get props => [status, date, dateMonth];

  SetDateState copyWith({
    SetDateStatus? status,
    String? date,
    String? dateMonth
  }) {
    return SetDateState(
      status: status ?? this.status,
      date: date ?? this.date,
      dateMonth: dateMonth ?? this.dateMonth
    );
  }
}