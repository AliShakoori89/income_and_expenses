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

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {

      var darkThemeBoolean = state.darkThemeBoolean;

      return Container(
        height: Dimensions.height45*4.5,
        margin: EdgeInsets.only(
          left: Dimensions.width20,
          right: Dimensions.width20,
        ),
        decoration: BoxDecoration(
          color: AppColors.cashContainerColor,
            borderRadius: BorderRadius.circular(Dimensions.radius20*2)),
        child: Container(
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
                                  Column(
                                    children: [
                                      Container(
                                        height: Dimensions.height45*2,
                                        width: Dimensions.width45*3.5,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Color.fromRGBO(236, 236, 236, 0.61)),
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(Dimensions.radius20*2),
                                              topLeft: Radius.circular(Dimensions.radius20*2),
                                              topRight: Radius.circular(Dimensions.radius20*2),
                                            )
                                        ),
                                      ),
                                      SizedBox(
                                        height: Dimensions.height20,
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(AppLocale.expenses.getString(context),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: Dimensions.font16,
                                                      fontWeight: FontWeight.w400)),
                                              SizedBox(width: Dimensions.width10,),
                                              Image.asset(
                                                  "assets/main_page_first_container_logo/darkExpenses.png"),
                                            ],
                                          ),
                                          SizedBox(
                                            height: Dimensions.height10/2,
                                          ),
                                          englishLanguageBoolean == false
                                              ? Row(
                                            children: [
                                              Text(
                                                  (state.expenses != "" && state.expenses != 0.toString())
                                                      ? rialCurrencyType == true
                                                      ? AppLocale.rial.getString(context)
                                                      : AppLocale.toman.getString(context)
                                                      : ''.toPersianDigit(),
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              SizedBox(width: Dimensions.width10 / 3),
                                              Text(
                                                  state.expenses != ""
                                                      ? rialCurrencyType == true
                                                      ? ('${state.expenses}0').toPersianDigit().seRagham()
                                                      : state.expenses.toPersianDigit().seRagham()
                                                      : "0".toPersianDigit(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: Dimensions.font16)),
                                            ],
                                          )
                                              : Row(
                                            children: [
                                              Text(
                                                  state.expenses != ""
                                                      ? rialCurrencyType == true
                                                      ? ("${state.expenses}0").seRagham()
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
                                                      ? AppLocale.rial.getString(context)
                                                      : AppLocale.toman.getString(context)
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
                                                          ? rialCurrencyType == true
                                                          ? AppLocale.rial.getString(context)
                                                          : AppLocale.toman.getString(context)
                                                          : '',
                                                      style: TextStyle(
                                                          color: darkThemeBoolean == "false"
                                                              ? Colors.black
                                                              : Colors.white)),
                                                  SizedBox(
                                                      width: Dimensions.width10 / 3),
                                                  Text(
                                                      state.calculateCash != ""
                                                          ? rialCurrencyType == true
                                                          ? ('${state.calculateCash}0').toPersianDigit().seRagham()
                                                          : state.calculateCash.toString().toPersianDigit().seRagham()
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
                                                          ? rialCurrencyType == true
                                                          ? ("${state.calculateCash}0").seRagham()
                                                          : state.calculateCash.toString().seRagham()
                                                          : "0",
                                                      style: TextStyle(
                                                          color: darkThemeBoolean == "false"
                                                              ? Colors.black
                                                              : Colors.white,
                                                          fontSize:
                                                          Dimensions.font14)),
                                                  SizedBox(
                                                      width:
                                                      Dimensions.width10 / 3),
                                                  Text(
                                                      state.calculateCash != ""
                                                          ? rialCurrencyType == true
                                                          ? AppLocale.rial.getString(context)
                                                          : AppLocale.toman.getString(context)
                                                          : '',
                                                      style: TextStyle(
                                                        color: darkThemeBoolean == "false"
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
                                                          ? AppColors.mainPageFirstContainerFontColor
                                                          : Colors.white,
                                                      fontSize: Dimensions.font16,
                                                      fontWeight: FontWeight.w400)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: Dimensions.height20,
                                          ),
                                          Row(
                                            children: [
                                              Text(AppLocale.cash.getString(context),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: Dimensions.font16,
                                                      fontWeight: FontWeight.w400)),
                                              SizedBox(
                                                  width: Dimensions.width10),
                                              Image.asset(
                                                  "assets/main_page_first_container_logo/darkBalance.png"),
                                            ],
                                          ),
                                          englishLanguageBoolean == false
                                              ? Row(
                                            children: [
                                              Text(
                                                  state.calculateCash != ""
                                                      ? rialCurrencyType == true
                                                      ? AppLocale.rial.getString(context)
                                                      : AppLocale.toman.getString(context)
                                                      : ''.toPersianDigit(),
                                                  style: const TextStyle(
                                                      color: Colors.white)),
                                              SizedBox(width: Dimensions.width10 / 3),
                                              Text(
                                                  state.calculateCash != ""
                                                      ? rialCurrencyType == true
                                                      ? ('${state.calculateCash}0').toPersianDigit().seRagham()
                                                      : state.calculateCash.toPersianDigit().seRagham()
                                                      : "0".toPersianDigit(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: Dimensions.font16)),
                                            ],
                                          )
                                              : Row(
                                            children: [
                                              Text(
                                                  state.expenses != ""
                                                      ? rialCurrencyType == true
                                                      ? ("${state.expenses}0").seRagham()
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
                                                      ? AppLocale.rial.getString(context)
                                                      : AppLocale.toman.getString(context)
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
                                                          ? rialCurrencyType == true
                                                          ? AppLocale.rial.getString(context)
                                                          : AppLocale.toman.getString(context)
                                                          : '',
                                                      style: TextStyle(
                                                          color:
                                                          darkThemeBoolean == "false"
                                                              ? Colors.black
                                                              : Colors.white)),
                                                  SizedBox(
                                                      width: Dimensions.width10 / 3),
                                                  Text(
                                                      state.calculateCash != ""
                                                          ? rialCurrencyType == true
                                                          ? ('${state.calculateCash}0').toPersianDigit().seRagham()
                                                          : state.calculateCash.toString().toPersianDigit().seRagham()
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
                                                      state.calculateCash != ""
                                                          ? rialCurrencyType == true
                                                          ? ("${state.calculateCash}0").seRagham()
                                                          : state.calculateCash.toString().seRagham()
                                                          : "0",
                                                      style: TextStyle(
                                                          color: darkThemeBoolean == "false"
                                                              ? Colors.black
                                                              : Colors.white,
                                                          fontSize:
                                                          Dimensions.font14)),
                                                  SizedBox(
                                                      width:
                                                      Dimensions.width10 / 3),
                                                  Text(
                                                      state.calculateCash != ""
                                                          ? rialCurrencyType == true
                                                          ? AppLocale.rial.getString(context)
                                                          : AppLocale.toman.getString(context)
                                                          : '',
                                                      style: TextStyle(
                                                        color: darkThemeBoolean ==
                                                            "false"
                                                            ? Colors.black
                                                            : Colors.white,
                                                      )),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: Dimensions.height45*2,
                                        width: Dimensions.width45*3.5,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Color.fromRGBO(236, 236, 236, 0.61)),
                                            borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(Dimensions.radius20*2),
                                              bottomLeft: Radius.circular(Dimensions.radius20*2),
                                              topRight: Radius.circular(Dimensions.radius20*2),
                                            )
                                        ),
                                        child: GestureDetector(
                                            onTap: () {
                                              TextEditingController cashController = TextEditingController();
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
                                                        BlocProvider.of<SetDateBloc>(context).add(AddIncomeEvent(
                                                            cash: cashController.text,
                                                            month: dateMonth
                                                        ));
                                                        BlocProvider.of<SetDateBloc>(context)
                                                            .add(FetchIncomeEvent(month: dateMonth)
                                                        );
                                                        BlocProvider.of<SetDateBloc>(context)
                                                            .add(CalculateCashPerMonthEvent(
                                                            dateMonth: dateMonth
                                                        ));
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
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(AppLocale.income.getString(context),
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: Dimensions.font16,
                                                            fontWeight: FontWeight.w400)),
                                                    SizedBox(
                                                      width: Dimensions.width10,
                                                    ),
                                                    Image.asset(
                                                        "assets/main_page_first_container_logo/darkIncome.png"),
                                                  ],
                                                ),


                                                englishLanguageBoolean == false
                                                    ? Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                        state.income != ""
                                                            ? rialCurrencyType == true
                                                            ? AppLocale.rial
                                                            .getString(context)
                                                            : AppLocale.toman
                                                            .getString(context)
                                                            : '',
                                                        style: const TextStyle(
                                                            color: Colors.white)),
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
                                                            color: Colors.white,
                                                            fontSize: Dimensions.font16)),
                                                  ],
                                                )
                                                    : Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                        state.income != ""
                                                            ? rialCurrencyType == true
                                                            ? ("${state.income}0")
                                                            .seRagham()
                                                            : state.income.seRagham()
                                                            : "",
                                                        style: TextStyle(
                                                            color: Colors.white,
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
                                                          color: Colors.white,
                                                        )),
                                                  ],
                                                ),
                                              ],
                                            )),
                                      ),
                                    ],
                                  )
                                ],
                              );
                            });});
                })
        ),
      );});
  }
}