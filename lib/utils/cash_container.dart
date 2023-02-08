import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:income_and_expenses/bloc/calculate_expense_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/calculate_expense_bloc/state.dart';
import 'package:income_and_expenses/bloc/income_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/income_bloc/state.dart';
import 'package:income_and_expenses/bloc/change_language_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/change_language_bloc/state.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/state.dart';
import 'package:income_and_expenses/const/app_colors.dart';
import 'package:income_and_expenses/const/dimensions.dart';
import 'package:income_and_expenses/const/language.dart';
import 'package:income_and_expenses/utils/widget.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../bloc/calculate_expense_bloc/event.dart';
import '../bloc/change_currency_bloc/event.dart';
import '../bloc/change_language_bloc/event.dart';
import '../bloc/income_bloc/event.dart';
import '../bloc/change_currency_bloc/bloc.dart';
import '../bloc/change_currency_bloc/state.dart';
import '../bloc/set_date_bloc/bloc.dart';
import '../bloc/set_date_bloc/event.dart';
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

    // BlocProvider.of<IncomeBloc>(context).add(FetchIncomeEvent());

    // BlocProvider.of<SetDateBloc>(context).add(ReadDateEvent());

    // BlocProvider.of<CalculateExpenseBloc>(context).add(SumExpensePerMonthEvent());

    // BlocProvider.of<CalculateExpenseBloc>(context).add(CalculateCashPerMonthEvent());

    BlocProvider.of<ChangeLanguageBloc>(context).add(ReadLanguageBooleanEvent());

    BlocProvider.of<ThemeBloc>(context).add(ReadThemeBooleanEvent());

    BlocProvider.of<ChangeCurrencyBloc>(context).add(ReadCurrencyBooleanEvent());

    super.initState();
  }



  late TextEditingController cashController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    BlocProvider.of<SetDateBloc>(context).add(ReadDateEvent());

    return BlocBuilder<SetDateBloc, SetDateState>(builder: (context, state) {

      var dateTime = state.dateMonth;

      BlocProvider.of<IncomeBloc>(context).add(FetchIncomeEvent(month: state.dateMonth));
      BlocProvider.of<CalculateExpenseBloc>(context).add(SumExpensePerMonthEvent(dateMonth: state.dateMonth));
      BlocProvider.of<CalculateExpenseBloc>(context).add(CalculateCashPerMonthEvent(dateMonth: state.dateMonth));

      print("dateTime dateTime dateTime dateTime      "+dateTime);

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
                  bool persianLanguageType = state.englishLanguageBoolean;

                  return BlocBuilder<ChangeCurrencyBloc, ChangeCurrencyState>(
                      builder: (context, state) {

                        bool rialCurrencyType = state.readCurrencyBoolean;

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
                                persianLanguageType == false
                                    ? Row(
                                  children: [
                                    Text(rialCurrencyType == true
                                        ? ("${state.expenses}0").seRagham()
                                        : state.expenses.toString().seRagham(),
                                        style: TextStyle(
                                            color: AppColors.expensesDigitColor,
                                            fontSize: Dimensions.font14)),
                                    SizedBox(width: Dimensions.width10 / 3),
                                    Text(state.expenses == "" || state.expenses == "0"
                                        ? "0"
                                        : rialCurrencyType == true
                                        ? AppLocale.rial.getString(context)
                                        : AppLocale.toman.getString(context),
                                        style: TextStyle(
                                            color: darkThemeBoolean == "true"
                                                ? Colors.white
                                                : AppColors.expensesDigitColor)),
                                  ],
                                )
                                    : Row(
                                  children: [
                                    Text(state.expenses == "" || state.expenses == "0"
                                        ? "0".toPersianDigit()
                                        : rialCurrencyType == true
                                        ? AppLocale.rial.getString(context)
                                        : AppLocale.toman.getString(context),
                                        style: TextStyle(
                                            color: darkThemeBoolean == "true"
                                                ? Colors.white
                                                : Colors.black
                                        )),
                                    SizedBox(width: Dimensions.width10/3),
                                    Text(rialCurrencyType == true
                                        ? ("${state.expenses}0").toPersianDigit().seRagham()
                                        : state.expenses.toString().toPersianDigit().seRagham(),
                                        style: TextStyle(
                                            color: AppColors.expensesDigitColor,
                                            fontSize: Dimensions.font16)),
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
                                  persianLanguageType == false
                                      ? Row(
                                    children: [
                                      Text(rialCurrencyType == true
                                          ? ("${state.calculateCash}0").seRagham()
                                          : state.calculateCash.toString().seRagham(),
                                          style: TextStyle(
                                              color: AppColors.balanceDigitColor,
                                              fontSize: Dimensions.font16)),
                                      SizedBox(width: Dimensions.width10/3),
                                      Text(state.calculateCash == "" || state.calculateCash == "0"
                                          ? "0"
                                          : rialCurrencyType == true
                                          ? AppLocale.rial.getString(context)
                                          : AppLocale.toman.getString(context),
                                          style: TextStyle(
                                              color: darkThemeBoolean == "true"
                                                  ? Colors.white
                                                  : AppColors.balanceDigitColor
                                          )),
                                    ],
                                  )
                                      : Row(
                                    children: [
                                      Text(state.calculateCash == "" || state.calculateCash == "0"
                                          ? "0".toPersianDigit()
                                          : rialCurrencyType == true
                                          ? AppLocale.rial.getString(context)
                                          : AppLocale.toman.getString(context),
                                          style: TextStyle(
                                              color:darkThemeBoolean == "true"
                                                  ? Colors.white
                                                  : Colors.black
                                          )),
                                      SizedBox(width: Dimensions.width10/3),
                                      Text(rialCurrencyType == true
                                          ? ("${state.calculateCash}0").toPersianDigit().seRagham()
                                          : state.calculateCash.toString().toPersianDigit().seRagham(),
                                          style: TextStyle(
                                              color: AppColors.balanceDigitColor,
                                              fontSize: Dimensions.font16)),
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
                                    month: dateTime,
                                  ));
                                  BlocProvider.of<IncomeBloc>(context)
                                      .add(FetchIncomeEvent(month: dateTime));
                                  BlocProvider.of<CalculateExpenseBloc>(context)
                                      .add(CalculateCashPerMonthEvent(dateMonth: dateTime));
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
                            persianLanguageType == true
                                ? Row(
                              children: [
                                Text(state.income.toString() != ""
                                    ? rialCurrencyType == true
                                    ? AppLocale.rial.getString(context)
                                    : AppLocale.toman.getString(context)
                                    : '0'.toPersianDigit(),
                                    style: TextStyle(
                                        color: darkThemeBoolean == "false"
                                            ? Colors.black
                                            : Colors.white
                                    )),
                                SizedBox(width: Dimensions.width10/3),
                                Text(rialCurrencyType == true
                                    ? ('${state.income}0').toPersianDigit().seRagham()
                                    : state.income.toString().toPersianDigit().seRagham(),
                                    style: TextStyle(
                                        color: darkThemeBoolean == "false"
                                            ? Colors.black
                                            : Colors.white,
                                        fontSize: Dimensions.font16)),
                              ],
                            )
                                : Row(
                              children: [
                                Text(rialCurrencyType == true
                                    ? ("${state.income}0").seRagham()
                                    :state.income.toString().seRagham(),
                                    style: TextStyle(
                                        color: darkThemeBoolean == "false"
                                            ? Colors.black
                                            : Colors.white,
                                        fontSize: Dimensions.font14)),
                                SizedBox(width: Dimensions.width10/3),
                                Text(state.income.toString() != ""
                                    ? rialCurrencyType == true
                                    ? AppLocale.rial.getString(context)
                                    : AppLocale.toman.getString(context)
                                    : '0',
                                    style: TextStyle(
                                        color: darkThemeBoolean == "false"
                                            ? Colors.black
                                            : Colors.white,
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
      );});});
  }
}
