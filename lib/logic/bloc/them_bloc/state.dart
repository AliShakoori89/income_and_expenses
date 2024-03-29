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
    int? index
  }): darkThemeBoolean = themeBoolean ?? 'false',
        pageNumber = index ?? 0;

  final ThemeStatus status;
  final String darkThemeBoolean;
  final int pageNumber;

  @override
  // TODO: implement props
  List<Object> get props => [status, darkThemeBoolean, pageNumber];

  ThemeState copyWith({
    ThemeStatus? status,
    String? themeBoolean,
    int? index
  }) {
    return ThemeState(
      status: status ?? this.status,
      themeBoolean: themeBoolean ?? darkThemeBoolean,
      index: index ?? pageNumber
    );
  }
}