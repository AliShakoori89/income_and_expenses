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
    String? themeBoolean,
  }): themeBoolean = themeBoolean ?? '' ;

  final ThemeStatus status;
  final String themeBoolean;

  @override
  // TODO: implement props
  List<Object> get props => [status, themeBoolean];

  ThemeState copyWith({
    ThemeStatus? status,
    String? themeBoolean,
  }) {
    return ThemeState(
      status: status ?? this.status,
      themeBoolean: themeBoolean ?? this.themeBoolean,
    );
  }
}