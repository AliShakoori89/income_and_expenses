import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:income_and_expenses/bloc/calculate_expense_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/calculate_expense_bloc/state.dart';
import 'package:income_and_expenses/bloc/income_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/income_bloc/state.dart';
import 'package:income_and_expenses/bloc/change_language_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/change_language_bloc/state.dart';
import 'package:income_and_expenses/const/app_colors.dart';
import 'package:income_and_expenses/const/dimensions.dart';
import 'package:income_and_expenses/const/language.dart';
import 'package:income_and_expenses/utils/widget.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../bloc/calculate_expense_bloc/event.dart';
import '../bloc/income_bloc/event.dart';
import '../bloc/change_currency_bloc/bloc.dart';
import '../bloc/change_currency_bloc/state.dart';
import '../bloc/them_bloc/bloc.dart';
import '../bloc/them_bloc/state.dart';

class CashContainer extends StatefulWidget {
  CashContainer({Key? key}) : super(key: key);

  @override
  State<CashContainer> createState() => _CashContainerState();
}

class _CashContainerState extends State<CashContainer> {

  @override
  void initState() {

    final cashBloc = BlocProvider.of<IncomeBloc>(context);
    cashBloc.add(FetchIncomeEvent());
    //
    final calculateExpenseBloc = BlocProvider.of<CalculateExpenseBloc>(context);
    calculateExpenseBloc.add(SumExpensePerMonthEvent());
    calculateExpenseBloc.add(CalculateSpentPerMonthEvent());

    // BlocProvider.of<ThemeBloc>(context).add(ReadThemeBooleanEvent());
    //
    // BlocProvider.of<ChangeLanguageBloc>(context).add(ReadLanguageBooleanEvent());
    //
    // BlocProvider.of<ThemeBloc>(context).add(ReadThemeBooleanEvent());
    //
    // BlocProvider.of<ChangeCurrencyBloc>(context).add(ReadCurrencyBooleanEvent());

    super.initState();
  }



  late TextEditingController cashController = TextEditingController();

  @override
  Widget build(BuildContext context) {



    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {

      var darkThemeBoolean = state.darkThemeBoolean;

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
                  bool englishLanguageType = state.readLanguageBoolean;

                  print("lBoollBoollBoollBoollBoollBool     "+englishLanguageType.toString());
                  return BlocBuilder<ChangeCurrencyBloc, ChangeCurrencyState>(
                      builder: (context, state) {

                        bool currencyType = state.readCurrencyBoolean;

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
                                englishLanguageType == false
                                    ? Row(
                                  children: [
                                    Text(
                                        state.expenses.toString() != ""
                                            ? currencyType == true
                                            ? AppLocale.rial.getString(context)
                                            : AppLocale.toman.getString(context)
                                            : "0".toPersianDigit(),
                                        style: const TextStyle(
                                            color: Colors.white)),
                                    SizedBox(width: Dimensions.width10 / 3),
                                    Text(
                                        state.expenses
                                            .toPersianDigit()
                                            .toString()
                                            .seRagham(),
                                        style: TextStyle(
                                            color: AppColors.expensesDigitColor,
                                            fontSize: Dimensions.font14)),
                                  ],
                                )
                              : Row(
                                  children: [
                                    Text(state.expenses.toString().seRagham(),
                                        style: TextStyle(
                                            color: AppColors.expensesDigitColor,
                                            fontSize: Dimensions.font14)),
                                    SizedBox(width: Dimensions.width10/3),
                                    Text(state.expenses.toString() != ""
                                        ? currencyType == true
                                        ? AppLocale.rial.getString(context)
                                        : AppLocale.toman.getString(context)
                                        : "0",
                                        style: const TextStyle(
                                            color: Colors.white
                                        )),
                                  ],
                                ) ,
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
                                  englishLanguageType == false
                                      ? Row(
                                    children: [
                                      Text(state.cash.toString() != ""
                                          ? currencyType == true
                                          ? AppLocale.rial.getString(context)
                                          : AppLocale.toman.getString(context)
                                          : "0".toPersianDigit(),
                                          style: const TextStyle(
                                              color: Colors.white
                                          )),
                                      SizedBox(width: Dimensions.width10/3),
                                      Text(state.cash.toString().toPersianDigit().seRagham(),
                                          style: TextStyle(
                                              color: AppColors.balanceDigitColor,
                                              fontSize: Dimensions.font16)),
                                    ],
                                  )
                                      : Row(
                                    children: [
                                      Text(state.cash.toString().seRagham(),
                                          style: TextStyle(
                                              color: AppColors.balanceDigitColor,
                                              fontSize: Dimensions.font14)),
                                      SizedBox(width: Dimensions.width10/3),
                                      Text(state.cash.toString() != ""
                                          ? currencyType == true
                                          ? AppLocale.rial.getString(context)
                                          : AppLocale.toman
                                          .getString(context)
                                          : "0",
                                          style: const TextStyle(
                                              color: Colors.white
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Dimensions.height10 / 2,
                                  ),
                                  Text(AppLocale.cash.getString(context),
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
                                  BlocProvider.of<IncomeBloc>(context).add(AddIncomeEvent(
                                    cash: cashController.text,
                                  ));
                                  BlocProvider.of<IncomeBloc>(context)
                                      .add(FetchIncomeEvent());
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
                      BlocBuilder<IncomeBloc, IncomeState>(builder: (context, state) {
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
                            englishLanguageType == false
                                ? Row(
                              children: [
                                Text(state.income.toString() != ""
                                    ? currencyType == true
                                    ? AppLocale.rial.getString(context)
                                    : AppLocale.toman.getString(context)
                                    : '0'.toPersianDigit(),
                                    style: const TextStyle(
                                        color: Colors.white
                                    )),
                                SizedBox(width: Dimensions.width10/3),
                                Text(state.income.toString().toPersianDigit().seRagham(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: Dimensions.font16)),
                              ],
                            )
                                : Row(
                              children: [
                                Text(state.income.toString().seRagham(),
                                    style: TextStyle(
                                        color: AppColors.expensesDigitColor,
                                        fontSize: Dimensions.font14)),
                                SizedBox(width: Dimensions.width10/3),
                                Text(state.income.toString() != ""
                                    ? currencyType == true
                                    ? AppLocale.toman
                                    .getString(context)
                                    : AppLocale.toman
                                    .getString(context)
                                    : '0',
                                    style: const TextStyle(
                                        color: Colors.white
                                    )),
                              ],
                            ) ,
                            SizedBox(
                              height: Dimensions.height10 / 2,
                            ),
                            Text(AppLocale.income.getString(context),
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
                  );});
                })
        ),
      );});
  }
}
