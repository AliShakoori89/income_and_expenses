import 'package:equatable/equatable.dart';
import 'package:income_and_expenses/model/expense_model.dart';

enum ExpenseStatus { initial, success, error, loading }

extension MedicineStatusX on ExpenseStatus {
  bool get isInitial => this == ExpenseStatus.initial;
  bool get isSuccess => this == ExpenseStatus.success;
  bool get isError => this == ExpenseStatus.error;
  bool get isLoading => this == ExpenseStatus.loading;
}

class ExpenseState extends Equatable {

  const ExpenseState({
    this.status = ExpenseStatus.initial,
    List<ExpenseModel>? medicines,
  }): medicines = medicines ?? const [];

  final ExpenseStatus status;
  final List<ExpenseModel> medicines;

  @override
  // TODO: implement props
  List<Object> get props => [status, medicines];

  ExpenseState copyWith({
    ExpenseStatus? status,
    List<ExpenseModel>? medicines
  }) {
    return ExpenseState(
      status: status ?? this.status,
      medicines: medicines ?? this.medicines,
    );
  }
}