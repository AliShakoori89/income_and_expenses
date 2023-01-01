import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/bloc/expense_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/expense_bloc/event.dart';
import 'package:income_and_expenses/model/expense_model.dart';

import 'app_colors.dart';
import 'dimensions.dart';

class AppButton extends StatelessWidget {

  final String category;
  final String expense;
  final String description;
  final String date;
  final GlobalKey<FormState> formKey;

  const AppButton({Key? key,
    required this.category,
    required this.expense,
    required this.description,
    required this.date,
    required this.formKey
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if (formKey.currentState!.validate()) {
          late ExpenseModel expense = ExpenseModel();
          final expenseBloc = BlocProvider.of<ExpenseBloc>(context);

          expense.expenseDate = date;
          expense.expenseCategory = category;
          expense.expense = expense.toString();
          expense.description = description;

          expenseBloc.add(AddExpenseEvent(expenseModel: expense));
          print("final                                 "+category);
          print("final                                 "+expense.toString());
          print("final                                 "+description);
          print("final                                 "+date);
        }

      },
      child: Container(
        margin: EdgeInsets.only(
            left: Dimensions.width30,
            right: Dimensions.width30,
            bottom: Dimensions.height10
        ),
        // width: Dimensions.buttonWidth,
        height: Dimensions.buttonHeight,
        decoration: BoxDecoration(
          color: AppColors.buttonColor,
          borderRadius: BorderRadius.circular(Dimensions.radius20),
        ),
        child: const Center(
          child: Text("اضافه کردن هزینه",
              style: TextStyle(
                  color: AppColors.backGroundColor
              )),
        ),
      ),
    );
  }
}
