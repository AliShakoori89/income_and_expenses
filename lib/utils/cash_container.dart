import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:income_and_expenses/bloc/change_language_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/change_language_bloc/state.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/state.dart';
import 'package:income_and_expenses/const/app_colors.dart';
import 'package:income_and_expenses/const/dimensions.dart';
import 'package:income_and_expenses/const/language.dart';
import 'package:income_and_expenses/utils/date_picker_calendar.dart';
import 'package:income_and_expenses/utils/widget.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../bloc/change_currency_bloc/bloc.dart';
import '../bloc/change_currency_bloc/state.dart';
import '../bloc/set_date_bloc/bloc.dart';
import '../bloc/set_date_bloc/event.dart';
import '../bloc/them_bloc/bloc.dart';
import '../bloc/them_bloc/state.dart';

class CashContainer extends StatefulWidget {
  const CashContainer({Key? key}) : super(key: key);

  @override
  State<CashContainer> createState() => _CashContainerState();
}

class _CashContainerState extends State<CashContainer> {


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
                  bool englishLanguageBoolean = state.englishLanguageBoolean;

                  return BlocBuilder<ChangeCurrencyBloc, ChangeCurrencyState>(
                      builder: (context, state) {

                        bool rialCurrencyType = state.rialCurrencyBoolean;

                        return BlocBuilder<SetDateBloc, SetDateState>(
                            builder: (context, state) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      darkThemeBoolean == "false"
                                          ? Image.asset(
                                          "assets/main_page_first_container_logo/expenses.png")
                                          : Image.asset(
                                          "assets/main_page_first_container_logo/darkExpenses.png"),
                                      SizedBox(
                                        height: Dimensions.height10,
                                      ),
                                      englishLanguageBoolean == false
                                          ? Row(
                                        children: [
                                          Text(
                                              state.expenses != ""
                                                  ? rialCurrencyType == true
                                                  ? AppLocale.rial
                                                  .getString(context)
                                                  : AppLocale.toman
                                                  .getString(context)
                                                  : ''.toPersianDigit(),
                                              style: TextStyle(
                                                  color: darkThemeBoolean == "false"
                                                      ? Colors.black
                                                      : Colors.white)),
                                          SizedBox(width: Dimensions.width10 / 3),
                                          Text(
                                              state.expenses != ""
                                                  ? rialCurrencyType == true
                                                  ? ('${state.expenses}0')
                                                  .toPersianDigit()
                                                  .seRagham()
                                                  : state.expenses
                                                  .toPersianDigit()
                                                  .seRagham()
                                                  : "0".toPersianDigit(),
                                              style: TextStyle(
                                                  color: darkThemeBoolean == "false"
                                                      ? AppColors.expensesDigitColor
                                                      : Colors.white,
                                                  fontSize: Dimensions.font16)),
                                        ],
                                      )
                                          : Row(
                                        children: [
                                          Text(
                                              state.expenses != ""
                                                  ? rialCurrencyType == true
                                                  ? ("${state.expenses}0")
                                                  .seRagham()
                                                  : state.expenses.seRagham()
                                                  : "0",
                                              style: TextStyle(
                                                  color: darkThemeBoolean == "false"
                                                      ? Colors.black
                                                      : Colors.white,
                                                  fontSize: Dimensions.font14)),
                                          SizedBox(width: Dimensions.width10 / 3),
                                          Text(
                                              state.expenses != ""
                                                  ? rialCurrencyType == true
                                                  ? AppLocale.rial
                                                  .getString(context)
                                                  : AppLocale.toman
                                                  .getString(context)
                                                  : '',
                                              style: TextStyle(
                                                color: darkThemeBoolean == "false"
                                                    ? Colors.black
                                                    : Colors.white,
                                              )),
                                          darkThemeBoolean == "false"
                                              ? Image.asset(
                                              "assets/main_page_first_container_logo/balance.png")
                                              : Image.asset(
                                              "assets/main_page_first_container_logo/darkBalance.png"),
                                          SizedBox(
                                            height: Dimensions.height10,
                                          ),
                                          englishLanguageBoolean == false
                                              ? Row(
                                            children: [
                                              Text(
                                                  state.calculateCash != ""
                                                      ? rialCurrencyType ==
                                                      true
                                                      ? AppLocale.rial
                                                      .getString(
                                                      context)
                                                      : AppLocale.toman
                                                      .getString(
                                                      context)
                                                      : '',
                                                  style: TextStyle(
                                                      color:
                                                      darkThemeBoolean ==
                                                          "false"
                                                          ? Colors.black
                                                          : Colors
                                                          .white)),
                                              SizedBox(
                                                  width:
                                                  Dimensions.width10 / 3),
                                              Text(
                                                  state.calculateCash != ""
                                                      ? rialCurrencyType ==
                                                      true
                                                      ? ('${state.calculateCash}0')
                                                      .toPersianDigit()
                                                      .seRagham()
                                                      : state
                                                      .calculateCash
                                                      .toString()
                                                      .toPersianDigit()
                                                      .seRagham()
                                                      : "0".toPersianDigit(),
                                                  style: TextStyle(
                                                      color: darkThemeBoolean ==
                                                          "false"
                                                          ? AppColors
                                                          .balanceDigitColor
                                                          : Colors.white,
                                                      fontSize:
                                                      Dimensions.font16)),
                                            ],
                                          )
                                              : Row(
                                            children: [
                                              Text(
                                                  state.calculateCash != ""
                                                      ? rialCurrencyType ==
                                                      true
                                                      ? ("${state.calculateCash}0")
                                                      .seRagham()
                                                      : state
                                                      .calculateCash
                                                      .toString()
                                                      .seRagham()
                                                      : "0",
                                                  style: TextStyle(
                                                      color:
                                                      darkThemeBoolean ==
                                                          "false"
                                                          ? Colors.black
                                                          : Colors.white,
                                                      fontSize:
                                                      Dimensions.font14)),
                                              SizedBox(
                                                  width:
                                                  Dimensions.width10 / 3),
                                              Text(
                                                  state.calculateCash != ""
                                                      ? rialCurrencyType ==
                                                      true
                                                      ? AppLocale.rial
                                                      .getString(
                                                      context)
                                                      : AppLocale.toman
                                                      .getString(
                                                      context)
                                                      : '',
                                                  style: TextStyle(
                                                    color: darkThemeBoolean ==
                                                        "false"
                                                        ? Colors.black
                                                        : Colors.white,
                                                  )),
                                            ],
                                          ),
                                          SizedBox(
                                            height: Dimensions.height10 / 2,
                                          ),
                                          Text(AppLocale.cash.getString(context),
                                              style: TextStyle(
                                                  color: darkThemeBoolean == "false"
                                                      ? AppColors
                                                      .mainPageFirstContainerFontColor
                                                      : Colors.white,
                                                  fontSize: Dimensions.font16,
                                                  fontWeight: FontWeight.w400)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: Dimensions.height10 / 2,
                                      ),
                                      Text(AppLocale.expenses.getString(context),
                                          style: TextStyle(
                                              color: darkThemeBoolean == "false"
                                                  ? AppColors
                                                  .mainPageFirstContainerFontColor
                                                  : Colors.white,
                                              fontSize: Dimensions.font16,
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      darkThemeBoolean == "false"
                                          ? Image.asset(
                                          "assets/main_page_first_container_logo/balance.png")
                                          : Image.asset(
                                          "assets/main_page_first_container_logo/darkBalance.png"),
                                      SizedBox(
                                        height: Dimensions.height10,
                                      ),
                                      englishLanguageBoolean == false
                                          ? Row(
                                        children: [
                                          Text(
                                              state.calculateCash != ""
                                                  ? rialCurrencyType == true
                                                  ? AppLocale.rial
                                                  .getString(context)
                                                  : AppLocale.toman
                                                  .getString(context)
                                                  : ''.toPersianDigit(),
                                              style: TextStyle(
                                                  color: darkThemeBoolean == "false"
                                                      ? Colors.black
                                                      : Colors.white)),
                                          SizedBox(width: Dimensions.width10 / 3),
                                          Text(
                                              state.calculateCash != ""
                                                  ? rialCurrencyType == true
                                                  ? ('${state.calculateCash}0')
                                                  .toPersianDigit()
                                                  .seRagham()
                                                  : state.calculateCash
                                                  .toPersianDigit()
                                                  .seRagham()
                                                  : "0".toPersianDigit(),
                                              style: TextStyle(
                                                  color: darkThemeBoolean == "false"
                                                      ? AppColors.balanceDigitColor
                                                      : Colors.white,
                                                  fontSize: Dimensions.font16)),
                                        ],
                                      )
                                          : Row(
                                        children: [
                                          Text(
                                              state.expenses != ""
                                                  ? rialCurrencyType == true
                                                  ? ("${state.expenses}0")
                                                  .seRagham()
                                                  : state.expenses.seRagham()
                                                  : "0",
                                              style: TextStyle(
                                                  color: darkThemeBoolean == "false"
                                                      ? Colors.black
                                                      : Colors.white,
                                                  fontSize: Dimensions.font14)),
                                          SizedBox(width: Dimensions.width10 / 3),
                                          Text(
                                              state.expenses != ""
                                                  ? rialCurrencyType == true
                                                  ? AppLocale.rial
                                                  .getString(context)
                                                  : AppLocale.toman
                                                  .getString(context)
                                                  : '',
                                              style: TextStyle(
                                                color: darkThemeBoolean == "false"
                                                    ? Colors.black
                                                    : Colors.white,
                                              )),
                                          darkThemeBoolean == "false"
                                              ? Image.asset(
                                              "assets/main_page_first_container_logo/balance.png")
                                              : Image.asset(
                                              "assets/main_page_first_container_logo/darkBalance.png"),
                                          SizedBox(
                                            height: Dimensions.height10,
                                          ),
                                          englishLanguageBoolean == false
                                              ? Row(
                                            children: [
                                              Text(
                                                  state.calculateCash != ""
                                                      ? rialCurrencyType ==
                                                      true
                                                      ? AppLocale.rial
                                                      .getString(
                                                      context)
                                                      : AppLocale.toman
                                                      .getString(
                                                      context)
                                                      : '',
                                                  style: TextStyle(
                                                      color:
                                                      darkThemeBoolean ==
                                                          "false"
                                                          ? Colors.black
                                                          : Colors
                                                          .white)),
                                              SizedBox(
                                                  width:
                                                  Dimensions.width10 / 3),
                                              Text(
                                                  state.calculateCash != ""
                                                      ? rialCurrencyType ==
                                                      true
                                                      ? ('${state.calculateCash}0')
                                                      .toPersianDigit()
                                                      .seRagham()
                                                      : state
                                                      .calculateCash
                                                      .toString()
                                                      .toPersianDigit()
                                                      .seRagham()
                                                      : "0".toPersianDigit(),
                                                  style: TextStyle(
                                                      color: darkThemeBoolean ==
                                                          "false"
                                                          ? AppColors
                                                          .balanceDigitColor
                                                          : Colors.white,
                                                      fontSize:
                                                      Dimensions.font16)),
                                            ],
                                          )
                                              : Row(
                                            children: [
                                              Text(
                                                  state.calculateCash != ""
                                                      ? rialCurrencyType ==
                                                      true
                                                      ? ("${state.calculateCash}0")
                                                      .seRagham()
                                                      : state
                                                      .calculateCash
                                                      .toString()
                                                      .seRagham()
                                                      : "0",
                                                  style: TextStyle(
                                                      color:
                                                      darkThemeBoolean ==
                                                          "false"
                                                          ? Colors.black
                                                          : Colors.white,
                                                      fontSize:
                                                      Dimensions.font14)),
                                              SizedBox(
                                                  width:
                                                  Dimensions.width10 / 3),
                                              Text(
                                                  state.calculateCash != ""
                                                      ? rialCurrencyType ==
                                                      true
                                                      ? AppLocale.rial
                                                      .getString(
                                                      context)
                                                      : AppLocale.toman
                                                      .getString(
                                                      context)
                                                      : '',
                                                  style: TextStyle(
                                                    color: darkThemeBoolean ==
                                                        "false"
                                                        ? Colors.black
                                                        : Colors.white,
                                                  )),
                                            ],
                                          ),
                                          SizedBox(
                                            height: Dimensions.height10 / 2,
                                          ),
                                          Text(AppLocale.cash.getString(context),
                                              style: TextStyle(
                                                  color: darkThemeBoolean == "false"
                                                      ? AppColors
                                                      .mainPageFirstContainerFontColor
                                                      : Colors.white,
                                                  fontSize: Dimensions.font16,
                                                  fontWeight: FontWeight.w400)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: Dimensions.height10 / 2,
                                      ),
                                      Text(AppLocale.cash.getString(context),
                                          style: TextStyle(
                                              color: darkThemeBoolean == "false"
                                                  ? AppColors
                                                  .mainPageFirstContainerFontColor
                                                  : Colors.white,
                                              fontSize: Dimensions.font16,
                                              fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        // BlocProvider.of<SetDateBloc>(context)
                                        //     .add(InitialDateEvent());

                                        showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            title: Text(
                                              AppLocale.totalInventory.getString(context),
                                              textDirection: TextDirection.rtl,
                                              style:
                                              TextStyle(fontSize: Dimensions.font16),
                                            ),
                                            content: Text(
                                                AppLocale.pleaseEnterYourBalanceAmount
                                                    .getString(context),
                                                textDirection: TextDirection.rtl,
                                                style: TextStyle(
                                                    fontSize: Dimensions.font14)),
                                            actions: <Widget>[
                                              Directionality(
                                                textDirection: TextDirection.rtl,
                                                child: SizedBox(
                                                  height: Dimensions.height45,
                                                  child: TextFormField(
                                                    keyboardType: TextInputType.number,
                                                    controller: cashController,
                                                    decoration:
                                                    textInputDecoration.copyWith(
                                                        border: InputBorder.none,
                                                        suffixText: AppLocale.toman
                                                            .getString(context)),
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  BlocProvider.of<SetDateBloc>(context)
                                                      .add(AddIncomeEvent(
                                                    cash: cashController.text,
                                                    month: "${DatePickerCalendarState().picked.year}-${DatePickerCalendarState().picked.month}",
                                                  ));
                                                  BlocProvider.of<SetDateBloc>(context)
                                                      .add(FetchIncomeEvent(month: "${DatePickerCalendarState().picked.year}-${DatePickerCalendarState().picked.month}"));
                                                  BlocProvider.of<SetDateBloc>(context)
                                                      .add(CalculateCashPerMonthEvent(
                                                      dateMonth: "${DatePickerCalendarState().picked.year}-${DatePickerCalendarState().picked.month}"));
                                                  Navigator.of(ctx).pop();
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: Dimensions.width10),
                                                  child: Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Text(AppLocale.ok
                                                          .getString(context))),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      child: Column(
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
                                          englishLanguageBoolean == false
                                              ? Row(
                                            children: [
                                              Text(
                                                  state.income != ""
                                                      ? rialCurrencyType == true
                                                      ? AppLocale.rial
                                                      .getString(context)
                                                      : AppLocale.toman
                                                      .getString(context)
                                                      : '',
                                                  style: TextStyle(
                                                      color: darkThemeBoolean ==
                                                          "false"
                                                          ? Colors.black
                                                          : Colors.white)),
                                              SizedBox(
                                                  width: Dimensions.width10 / 3),
                                              Text(
                                                  state.income != ""
                                                      ? rialCurrencyType == true
                                                      ? ('${state.income}0')
                                                      .toPersianDigit()
                                                      .seRagham()
                                                      : state.income
                                                      .toPersianDigit()
                                                      .seRagham()
                                                      : "0".toPersianDigit(),
                                                  style: TextStyle(
                                                      color: darkThemeBoolean ==
                                                          "false"
                                                          ? Colors.black
                                                          : Colors.white,
                                                      fontSize: Dimensions.font16)),
                                            ],
                                          )
                                              : Row(
                                            children: [
                                              Text(
                                                  state.income != ""
                                                      ? rialCurrencyType == true
                                                      ? ("${state.income}0")
                                                      .seRagham()
                                                      : state.income.seRagham()
                                                      : "",
                                                  style: TextStyle(
                                                      color: darkThemeBoolean ==
                                                          "false"
                                                          ? Colors.black
                                                          : Colors.white,
                                                      fontSize: Dimensions.font14)),
                                              SizedBox(
                                                  width: Dimensions.width10 / 3),
                                              Text(
                                                  state.income != ""
                                                      ? rialCurrencyType == true
                                                      ? AppLocale.rial
                                                      .getString(context)
                                                      : AppLocale.toman
                                                      .getString(context)
                                                      : "0",
                                                  style: TextStyle(
                                                    color:
                                                    darkThemeBoolean == "false"
                                                        ? Colors.black
                                                        : Colors.white,
                                                  )),
                                            ],
                                          ),
                                          SizedBox(
                                            height: Dimensions.height10 / 2,
                                          ),
                                          Text(AppLocale.income.getString(context),
                                              style: TextStyle(
                                                  color: darkThemeBoolean == "false"
                                                      ? AppColors
                                                      .mainPageFirstContainerFontColor
                                                      : Colors.white,
                                                  fontSize: Dimensions.font16,
                                                  fontWeight: FontWeight.w400)),
                                        ],
                                      )),
                                ],
                              );
                            });});
                })
        ),
      );});
  }
}
