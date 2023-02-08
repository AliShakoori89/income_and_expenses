import 'package:equatable/equatable.dart';

enum ChangeLanguageStatus { initial, success, error, loading }

extension ChangeLanguageStatusX on ChangeLanguageStatus {
  bool get isInitial => this == ChangeLanguageStatus.initial;
  bool get isSuccess => this == ChangeLanguageStatus.success;
  bool get isError => this == ChangeLanguageStatus.error;
  bool get isLoading => this == ChangeLanguageStatus.loading;
}

class ChangeLanguageState extends Equatable {

  const ChangeLanguageState({
    this.status = ChangeLanguageStatus.initial,
    bool? englishLanguageBoolean,
  }):
        englishLanguageBoolean = englishLanguageBoolean ?? false;

  final ChangeLanguageStatus status;
  final bool englishLanguageBoolean;

  @override
  List<Object> get props => [status,
    englishLanguageBoolean];

  ChangeLanguageState copyWith({
    ChangeLanguageStatus? status,
    bool? englishLanguageBoolean,
  }) {
    return ChangeLanguageState(
      status: status ?? this.status,
      englishLanguageBoolean: englishLanguageBoolean ?? this.englishLanguageBoolean,
    );
  }
}