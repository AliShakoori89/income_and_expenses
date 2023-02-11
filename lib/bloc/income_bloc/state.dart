// import 'package:equatable/equatable.dart';
//
// enum IncomeStatus { initial, success, error, loading }
//
// extension CashStatusX on IncomeStatus {
//   bool get isInitial => this == IncomeStatus.initial;
//   bool get isSuccess => this == IncomeStatus.success;
//   bool get isError => this == IncomeStatus.error;
//   bool get isLoading => this == IncomeStatus.loading;
// }
//
// class IncomeState extends Equatable {
//
//   const IncomeState({
//     this.status = IncomeStatus.initial,
//     String? income,
//   }): income = income ?? '';
//
//   final IncomeStatus status;
//   final String income;
//
//   @override
//   // TODO: implement props
//   List<Object> get props => [status, income];
//
//   IncomeState copyWith({
//     IncomeStatus? status,
//     String? income
//   }) {
//     return IncomeState(
//       status: status ?? this.status,
//       income: income ?? this.income,
//     );
//   }
// }