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
    bool? persianCheckBox,
    bool? englishCheckBox,
    bool? readLanguageBoolean,
  }): persianCheckBox = persianCheckBox ?? true ,
        englishCheckBox = englishCheckBox ?? false,
        readLanguageBoolean = readLanguageBoolean ?? false
  ;

  final ChangeLanguageStatus status;
  final bool persianCheckBox;
  final bool englishCheckBox;
  final bool readLanguageBoolean;

  @override
  List<Object> get props => [status, persianCheckBox, englishCheckBox, readLanguageBoolean];

  ChangeLanguageState copyWith({
    ChangeLanguageStatus? status,
    bool? persianCheckBox,
    bool? englishCheckBox,
    bool? readLanguageBoolean,
  }) {
    return ChangeLanguageState(
      status: status ?? this.status,
      persianCheckBox: persianCheckBox ?? this.persianCheckBox,
      englishCheckBox: englishCheckBox ?? this.englishCheckBox,
      readLanguageBoolean: readLanguageBoolean ?? this.readLanguageBoolean,
    );
  }
}