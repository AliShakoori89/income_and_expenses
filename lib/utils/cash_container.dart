import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:income_and_expenses/bloc/calculate_expense_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/calculate_expense_bloc/state.dart';
import 'package:income_and_expenses/bloc/cash_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/cash_bloc/state.dart';
import 'package:income_and_expenses/bloc/change_language_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/change_language_bloc/event.dart';
import 'package:income_and_expenses/bloc/change_language_bloc/state.dart';
import 'package:income_and_expenses/const/app_colors.dart';
import 'package:income_and_expenses/const/dimensions.dart';
import 'package:income_and_expenses/const/language.dart';
import 'package:income_and_expenses/utils/widget.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../bloc/calculate_expense_bloc/event.dart';
import '../bloc/cash_bloc/event.dart';
import '../bloc/them_bloc/bloc.dart';
import '../bloc/them_bloc/event.dart';
import '../bloc/them_bloc/state.dart';

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

    BlocProvider.of<ThemeBloc>(context).add(ReadThemeBooleanEvent());

    super.initState();
  }



  late TextEditingController cashController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    BlocProvider.of<ChangeLanguageBloc>(context).add(ReadLanguageBooleanEvent());

    BlocProvider.of<ThemeBloc>(context).add(ReadThemeBooleanEvent());

    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {

      var darkThemeBoolean = state.themeBoolean;

      return Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: darkThemeBoolean == "false"
                    ? AppColors.mainPageCardBorderColor
                    : AppColors.darkThemeBorderColor),
            borderRadius:
            BorderRadius.circular(Dimensions.radius8)),
        child: Container(
            margin: EdgeInsets.only(
                left: Dimensions.width30,
                right: Dimensions.width30,
                top: Dimensions.height10,
                bottom: Dimensions.height10),
            child: BlocBuilder<ChangeLanguageBloc, ChangeLanguageState>(
                builder: (context, state) {
                  bool lBool = state.readLanguageBoolean;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocBuilder<CalculateExpenseBloc, CalculateExpenseState>(
                          builder: (context, state) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                darkThemeBoolean == "false"
                                    ? Image.asset(
                                    "assets/main_page_first_container_logo/expenses.png")
                                    : Image.asset(
                                    "assets/main_page_first_container_logo/darkExpenses.png"),
                                SizedBox(
                                  height: Dimensions.height10,
                                ),
                                Text(
                                    lBool == false
                                        ? state.expenses.toString().toPersianDigit().seRagham()
                                        : state.expenses.toString().seRagham(),
                                    style: TextStyle(
                                        color: AppColors.expensesDigitColor,
                                        fontSize: lBool == false
                                            ? Dimensions.font18
                                            : Dimensions.font14)),
                                SizedBox(
                                  height: Dimensions.height10 / 2,
                                ),
                                Text(AppLocale.expenses.getString(context),
                                    style: TextStyle(
                                        color: darkThemeBoolean == "false"
                                            ? AppColors.mainPageFirstContainerFontColor
                                            : Colors.white,
                                        fontSize: Dimensions.font16,
                                        fontWeight: FontWeight.w400)),
                              ],
                            );
                          }),
                      BlocBuilder<CalculateExpenseBloc, CalculateExpenseState>(
                          builder: (context, state) {
                            return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  darkThemeBoolean == "false"
                                      ? Image.asset(
                                      "assets/main_page_first_container_logo/balance.png")
                                      : Image.asset(
                                      "assets/main_page_first_container_logo/darkBalance.png"),
                                  SizedBox(
                                    height: Dimensions.height10,
                                  ),
                                  Text(
                                      lBool == false
                                          ? state.spent.toString().toPersianDigit().seRagham()
                                          : state.spent.toString().seRagham(),
                                      style: TextStyle(
                                          color: AppColors.balanceDigitColor,
                                          fontSize: lBool == false
                                              ? Dimensions.font18
                                              : Dimensions.font14)),
                                  SizedBox(
                                    height: Dimensions.height10 / 2,
                                  ),
                                  Text(AppLocale.spent.getString(context),
                                      style: TextStyle(
                                          color:
                                          darkThemeBoolean == "false"
                                              ? AppColors.mainPageFirstContainerFontColor
                                              : Colors.white,
                                          fontSize: Dimensions.font16,
                                          fontWeight: FontWeight.w400)),
                                ]);
                          }),
                      GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                            title: Text(
                              AppLocale.totalInventory.getString(context),
                              textDirection: TextDirection.rtl,
                              style: TextStyle(fontSize: Dimensions.font16),
                            ),
                            content: Text(
                                AppLocale.pleaseEnterYourBalanceAmount
                                    .getString(context),
                                textDirection: TextDirection.rtl,
                                style: TextStyle(fontSize: Dimensions.font14)),
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
                                        suffixText:
                                        AppLocale.toman.getString(context)),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  BlocProvider.of<CashBloc>(context).add(AddCashEvent(
                                    cash: cashController.text,
                                  ));
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
                      }, child:
                      BlocBuilder<CashBloc, CashState>(builder: (context, state) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            darkThemeBoolean == "false"
                                ? Image.asset(
                                "assets/main_page_first_container_logo/income.png")
                                : Image.asset(
                                "assets/main_page_first_container_logo/darkIncome.png"),
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            Text(
                                state.cash == ''
                                    ? lBool == false
                                    ? "0".toPersianDigit()
                                    : "0"
                                    : lBool == false
                                    ? state.cash.toPersianDigit().seRagham()
                                    : state.cash.seRagham(),
                                style: TextStyle(
                                    color: darkThemeBoolean == "false"
                                        ? AppColors.appBarProfileName
                                        : Colors.white,
                                    fontSize: lBool == false
                                        ? Dimensions.font18
                                        : Dimensions.font14)),
                            SizedBox(
                              height: Dimensions.height10 / 2,
                            ),
                            Text(AppLocale.cash.getString(context),
                                style: TextStyle(
                                    color: darkThemeBoolean == "false"
                                        ? AppColors.mainPageFirstContainerFontColor
                                        : Colors.white,
                                    fontSize: Dimensions.font16,
                                    fontWeight: FontWeight.w400)),
                          ],
                        );
                      })),
                    ],
                  );
                })
        ),
      );});
  }
}
