import 'package:equatable/equatable.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

enum SetDateStatus { initial, success, error, loading }

extension SetDateStatusX on SetDateStatus {
  bool get isInitial => this == SetDateStatus.initial;
  bool get isSuccess => this == SetDateStatus.success;
  bool get isError => this == SetDateStatus.error;
  bool get isLoading => this == SetDateStatus.loading;
}

class SetDateState extends Equatable {

  SetDateState({
    this.status = SetDateStatus.initial,
    String? date,
    String? dateMonth,
    String? selectDate,
  }): date = date ?? '${Jalali.now().year}-${Jalali.now().month}-${Jalali.now().day}' ,
        dateMonth = dateMonth ?? '${Jalali.now().year}-${Jalali.now().month}}',
        selectDate = selectDate ?? '${Jalali.now().year}-${Jalali.now().month}-${Jalali.now().day}';

  final SetDateStatus status;
  final String date;
  final String dateMonth;
  final String selectDate;

  @override
  // TODO: implement props
  List<Object> get props => [status, date, dateMonth, selectDate];

  SetDateState copyWith({
    SetDateStatus? status,
    String? date,
    String? dateMonth,
    String? selectDate
  }) {
    return SetDateState(
      status: status ?? this.status,
      date: date ?? this.date,
      dateMonth: dateMonth ?? this.dateMonth,
      selectDate: selectDate ?? this.selectDate
    );
  }
}