import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:income_and_expenses/bloc/calculate_expense_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/calculate_expense_bloc/state.dart';
import 'package:income_and_expenses/bloc/cash_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/cash_bloc/state.dart';
import 'package:income_and_expenses/utils/app_colors.dart';
import 'package:income_and_expenses/utils/dimensions.dart';
import 'package:income_and_expenses/utils/language.dart';
import 'package:income_and_expenses/utils/widget.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../bloc/calculate_expense_bloc/event.dart';
import '../bloc/cash_bloc/event.dart';

class CashContainer extends StatefulWidget {
  CashContainer({Key? key}) : super(key: key);

  @override
  State<CashContainer> createState() => _CashContainerState();
}

class _CashContainerState extends State<CashContainer> {

  @override
  void initState() {

    final cashBloc = BlocProvider.of<CashBloc>(context);
    cashBloc.add(FetchCashEvent());

    final calculateExpenseBloc = BlocProvider.of<CalculateExpenseBloc>(context);
    calculateExpenseBloc.add(SumExpensePerMonthEvent());
    calculateExpenseBloc.add(CalculateSpentPerMonthEvent());

    super.initState();
  }

  late TextEditingController cashController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: AppColors.mainPageCardBorderColor),
          borderRadius:
          BorderRadius.circular(Dimensions.radius8)),
      child: Container(
        margin: EdgeInsets.only(
            left: Dimensions.width30,
            right: Dimensions.width30,
            top: Dimensions.height10,
            bottom: Dimensions.height10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocBuilder<CalculateExpenseBloc, CalculateExpenseState>(
                builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                      "assets/main_page_first_container_logo/expenses.png"),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  Text(state.expenses.toString().toPersianDigit().seRagham(),
                      style: TextStyle(
                          color: AppColors.expensesDigitColor,
                          fontSize: Dimensions.font18)),
                  Text(AppLocale.expenses.getString(context),
                      style: TextStyle(
                          color: AppColors.mainPageFirstContainerFontColor,
                          fontSize: Dimensions.font16,
                          fontWeight: FontWeight.w400)),
                ],
              );
            }),
            BlocBuilder<CalculateExpenseBloc, CalculateExpenseState>(builder: (context, state) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                        "assets/main_page_first_container_logo/balance.png"),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Text(state.spent.toPersianDigit().seRagham(),
                        style: TextStyle(
                            color: AppColors.balanceDigitColor,
                            fontSize: Dimensions.font18)),
                    Text(AppLocale.spent.getString(context),
                        style: TextStyle(
                            color: AppColors.mainPageFirstContainerFontColor,
                            fontSize: Dimensions.font16,
                            fontWeight: FontWeight.w400)),
                  ]);
            }),

            GestureDetector(
              onTap: (){
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text(AppLocale.totalInventory.getString(context),
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: Dimensions.font16
                    ),),
                    content: Text(AppLocale.pleaseEnterYourBalanceAmount.getString(context),
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            fontSize: Dimensions.font14
                        )),
                    actions: <Widget>[
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: SizedBox(
                          height: Dimensions.height45,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: cashController,
                            decoration: textInputDecoration.copyWith(
                                border: InputBorder.none,
                              suffixText: AppLocale.toman.getString(context)
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          BlocProvider.of<CashBloc>(context)
                              .add(AddCashEvent(cash: cashController.text,));
                          BlocProvider.of<CashBloc>(context)
                              .add(FetchCashEvent());
                          BlocProvider.of<CalculateExpenseBloc>(context)
                              .add(CalculateSpentPerMonthEvent());
                          Navigator.of(ctx).pop();
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: Dimensions.width10),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(AppLocale.ok.getString(context))),
                        ),
                      ),
                    ],
                  ),
                );
              },
                child: BlocBuilder<CashBloc, CashState>(
                    builder: (context, state) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                              "assets/main_page_first_container_logo/income.png"),
                          SizedBox(height: Dimensions.height10,),
                          Text(state.cash == '' ? "0".toPersianDigit() : state.cash.toPersianDigit().seRagham(),
                              style: TextStyle(
                                  color: AppColors.appBarProfileName,
                                  fontSize: Dimensions.font18)),
                          Text(AppLocale.cash.getString(context),
                              style: TextStyle(
                                  color: AppColors
                                      .mainPageFirstContainerFontColor,
                                  fontSize: Dimensions.font16,
                                  fontWeight: FontWeight.w400)),
                        ],
                      );
                    })

            ),
          ],
        ),
      ),
    );
  }
}
