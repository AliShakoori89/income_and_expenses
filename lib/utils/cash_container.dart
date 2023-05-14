import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:income_and_expenses/bloc/change_currency_bloc/event.dart';
import 'package:income_and_expenses/bloc/change_language_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/change_language_bloc/state.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/state.dart';
import 'package:income_and_expenses/const/app_colors.dart';
import 'package:income_and_expenses/const/language.dart';
import 'package:income_and_expenses/utils/widget.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../bloc/change_currency_bloc/bloc.dart';
import '../bloc/change_currency_bloc/state.dart';
import '../bloc/set_date_bloc/bloc.dart';
import '../bloc/set_date_bloc/event.dart';
import '../bloc/them_bloc/bloc.dart';
import '../bloc/them_bloc/state.dart';

class CashContainer extends StatefulWidget {

  CashContainer({Key? key}) : super(key: key);

  @override
  State<CashContainer> createState() => _CashContainerState();
}

class _CashContainerState extends State<CashContainer> with TickerProviderStateMixin  {

  late AnimationController animationController;

  @override
  void initState() {
    BlocProvider.of<ChangeCurrencyBloc>(context).add(ReadCurrencyBooleanEvent());
    animationController = AnimationController(
      vsync: this,
      lowerBound: 0.7,
      duration: const Duration(seconds: 1),
    )
      ..forward()
      ..repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {

      return Container(
        height: MediaQuery.of(context).size.height / 4,
        margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width / 15,
          right: MediaQuery.of(context).size.width / 15,
        ),
        decoration: BoxDecoration(
            color: AppColors.cashContainerColor,
            borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.width / 10)),
        child: BlocBuilder<ChangeLanguageBloc, ChangeLanguageState>(
            builder: (context, state) {
          bool englishLanguageBoolean = state.englishLanguageBoolean;

          return BlocBuilder<ChangeCurrencyBloc, ChangeCurrencyState>(
              builder: (context, state) {
            bool rialCurrencyType = state.rialCurrencyBoolean;

            return BlocBuilder<SetDateBloc, SetDateState>(
                builder: (context, state) {
              String dateMonth = state.dateMonth;

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  leftSideCashContainer(context, englishLanguageBoolean, state, rialCurrencyType),
                  rightSideCashContainer(context, englishLanguageBoolean, state, rialCurrencyType, dateMonth)
                ],
              );
            });
          });
        }),
      );
    });
  }

  Expanded rightSideCashContainer(BuildContext context, bool englishLanguageBoolean, SetDateState state, bool rialCurrencyType, String dateMonth) {
    return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      cashSlice(context, englishLanguageBoolean, state, rialCurrencyType),
                      incomeSlice(context, dateMonth, englishLanguageBoolean, state, rialCurrencyType),
                    ],
                  ),
                );
  }

  Align incomeSlice(BuildContext context, String dateMonth, bool englishLanguageBoolean, SetDateState state, bool rialCurrencyType) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        height: MediaQuery.of(context).size.height / 9,
        decoration: BoxDecoration(
            border: Border.all(
                color: AppColors.cashContainerShapeBorderColor, width: 2),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(
                MediaQuery.of(context).size.width / 10,
              ),
              bottomLeft: Radius.circular(
                MediaQuery.of(context).size.width / 10,
              ),
              topRight: Radius.circular(
                MediaQuery.of(context).size.width / 10,
              ),
            )),
        child: GestureDetector(
            onTap: () {
              TextEditingController cashController = TextEditingController();
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text(
                    AppLocale.totalInventory.getString(context),
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  content: Text(
                      AppLocale.pleaseEnterYourBalanceAmount.getString(context),
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: MediaQuery.of(context).size.width / 22,
                      )),
                  actions: <Widget>[
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.width / 10,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: cashController,
                          decoration: textInputDecoration.copyWith(
                              border: InputBorder.none,
                              suffixText: AppLocale.toman.getString(context)),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        BlocProvider.of<SetDateBloc>(context).add(
                            AddIncomeEvent(
                                cash: cashController.text, month: dateMonth));
                        BlocProvider.of<SetDateBloc>(context)
                            .add(FetchIncomeEvent(month: dateMonth));
                        BlocProvider.of<SetDateBloc>(context).add(
                            CalculateCashPerMonthEvent(dateMonth: dateMonth));
                        Navigator.of(ctx).pop();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 50),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(AppLocale.ok.getString(context))),
                      ),
                    ),
                  ],
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 20,
                      right: MediaQuery.of(context).size.width / 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 50,
                      ),
                      Text(AppLocale.income.getString(context),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: MediaQuery.of(context).size.width / 22,
                          )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 18,
                      ),
                      SizedBox(
                        child: Image.asset(
                          "assets/main_page_first_container_logo/darkIncome.png",
                          color: Colors.white,
                          scale: MediaQuery.of(context).size.width / 500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 200,
                ),
                englishLanguageBoolean == false
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              state.income != ""
                                  ? rialCurrencyType == true
                                      ? AppLocale.rial.getString(context)
                                      : AppLocale.toman.getString(context)
                                  : '',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white)),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 50,
                          ),
                          Text(
                              state.income != ""
                                  ? rialCurrencyType == true
                                      ? ('${state.income}0')
                                          .toPersianDigit()
                                          .seRagham()
                                      : state.income.toPersianDigit().seRagham()
                                  : "0".toPersianDigit(),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize:
                                    MediaQuery.of(context).size.width / 20,
                              )),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              state.income != ""
                                  ? rialCurrencyType == true
                                      ? ("${state.income}0").seRagham()
                                      : state.income.seRagham()
                                  : "",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize:
                                    MediaQuery.of(context).size.width / 22,
                              )),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 50,
                          ),
                          Text(
                              state.income != ""
                                  ? rialCurrencyType == true
                                      ? AppLocale.rial.getString(context)
                                      : AppLocale.toman.getString(context)
                                  : "0",
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width / 30,
                              )),
                        ],
                      ),
              ],
            )),
      ),
    );
  }

  Column cashSlice(BuildContext context, bool englishLanguageBoolean, SetDateState state, bool rialCurrencyType) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocale.cash.getString(context),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width / 22,
                  fontWeight: FontWeight.w800,
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width / 18,
            ),
            Image.asset("assets/main_page_first_container_logo/darkBalance.png",
                scale: MediaQuery.of(context).size.width / 500),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 200,
        ),
        englishLanguageBoolean == false
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      state.calculateCash != ""
                          ? rialCurrencyType == true
                              ? AppLocale.rial.getString(context)
                              : AppLocale.toman.getString(context)
                          : ''.toPersianDigit(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w800, color: Colors.white)),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 50,
                  ),
                  Text(
                      state.calculateCash != ""
                          ? rialCurrencyType == true
                              ? ('${state.calculateCash}0')
                                  .toPersianDigit()
                                  .seRagham()
                              : state.calculateCash.toPersianDigit().seRagham()
                          : "0".toPersianDigit(),
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width / 22,
                      )),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      state.calculateCash != ""
                          ? rialCurrencyType == true
                              ? ("${state.calculateCash}0").seRagham()
                              : state.calculateCash.seRagham()
                          : "0",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width / 22,
                      )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 50,
                  ),
                  Text(
                      state.calculateCash != ""
                          ? rialCurrencyType == true
                              ? AppLocale.rial.getString(context)
                              : AppLocale.toman.getString(context)
                          : '',
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      )),
                ],
              ),
      ],
    );
  }

  Expanded leftSideCashContainer(BuildContext context, bool englishLanguageBoolean, SetDateState state, bool rialCurrencyType) {
    return Expanded(
      child: Column(
        children: [
          shapeSlice(context),
          SizedBox(
            height: MediaQuery.of(context).size.height / 25,
          ),
          expensesSlice(
              context, englishLanguageBoolean, state, rialCurrencyType),
        ],
      ),
    );
  }

  Column expensesSlice(BuildContext context, bool englishLanguageBoolean, SetDateState state, bool rialCurrencyType) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocale.expenses.getString(context),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width / 22,
                  fontWeight: FontWeight.w800,
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width / 18,
            ),
            // const AnimatedModalBarrierApp(),
            Image.asset(
              "assets/main_page_first_container_logo/darkExpenses.png",
              scale: MediaQuery.of(context).size.width / 500,
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 100,
        ),
        englishLanguageBoolean == false
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      (state.expensesPerMonth != "" &&
                              state.expensesPerMonth != 0.toString())
                          ? rialCurrencyType == true
                              ? AppLocale.rial.getString(context)
                              : AppLocale.toman.getString(context)
                          : ''.toPersianDigit(),
                      style: const TextStyle(color: Colors.white)),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 25,
                  ),
                  Text(
                      state.expensesPerMonth != ""
                          ? rialCurrencyType == true
                              ? ('${state.expensesPerMonth}0')
                                  .toPersianDigit()
                                  .seRagham()
                              : state.expensesPerMonth
                                  .toPersianDigit()
                                  .seRagham()
                          : "0".toPersianDigit(),
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width / 22,
                      )),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      state.expensesPerMonth != ""
                          ? rialCurrencyType == true
                              ? ("${state.expensesPerMonth}0").seRagham()
                              : state.expensesPerMonth.seRagham()
                          : "0",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width / 22,
                      )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 50,
                  ),
                  Text(
                      state.expensesPerMonth != ""
                          ? rialCurrencyType == true
                              ? AppLocale.rial.getString(context)
                              : AppLocale.toman.getString(context)
                          : '',
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      )),
                ],
              ),
      ],
    );
  }

  Align shapeSlice(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        height: MediaQuery.of(context).size.height / 9,
        decoration: BoxDecoration(
            border: Border.all(
                color: AppColors.cashContainerShapeBorderColor, width: 2),
            borderRadius: BorderRadius.only(
              bottomLeft:
                  Radius.circular(MediaQuery.of(context).size.width / 10),
              topLeft: Radius.circular(MediaQuery.of(context).size.width / 10),
              topRight: Radius.circular(MediaQuery.of(context).size.width / 10),
            )),
      ),
    );
  }
}