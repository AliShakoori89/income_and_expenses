import 'package:equatable/equatable.dart';

enum ThemeStatus { initial, success, error, loading }

extension ThemeStatusX on ThemeStatus {
  bool get isInitial => this == ThemeStatus.initial;
  bool get isSuccess => this == ThemeStatus.success;
  bool get isError => this == ThemeStatus.error;
  bool get isLoading => this == ThemeStatus.loading;
}

class ThemeState extends Equatable {

  const ThemeState({
    this.status = ThemeStatus.initial,
    String? date,
    String? dateMonth,
  }): date = date ?? '' , dateMonth = dateMonth ?? '';

  final ThemeStatus status;
  final String date;
  final String dateMonth;

  @override
  // TODO: implement props
  List<Object> get props => [status, date, dateMonth];

  ThemeState copyWith({
    ThemeStatus? status,
    String? date,
    String? dateMonth
  }) {
    return ThemeState(
      status: status ?? this.status,
      date: date ?? this.date,
      dateMonth: dateMonth ?? this.dateMonth
    );
  }
}