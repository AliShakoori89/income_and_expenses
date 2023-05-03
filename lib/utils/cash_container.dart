import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:income_and_expenses/bloc/change_currency_bloc/event.dart';
import 'package:income_and_expenses/bloc/change_language_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/change_language_bloc/state.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/state.dart';
import 'package:income_and_expenses/const/app_colors.dart';
import 'package:income_and_expenses/const/dimensions.dart';
import 'package:income_and_expenses/const/language.dart';
import 'package:income_and_expenses/utils/widget.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../bloc/change_currency_bloc/bloc.dart';
import '../bloc/change_currency_bloc/state.dart';
import '../bloc/change_language_bloc/event.dart';
import '../bloc/set_date_bloc/bloc.dart';
import '../bloc/set_date_bloc/event.dart';
import '../bloc/them_bloc/bloc.dart';
import '../bloc/them_bloc/state.dart';
import '../const/income_animation.dart';

class CashContainer extends StatefulWidget {

  GlobalKey keyButton;

  CashContainer({Key? key, required this.keyButton}) : super(key: key);

  @override
  State<CashContainer> createState() => _CashContainerState(keyButton);
}

class _CashContainerState extends State<CashContainer> with TickerProviderStateMixin  {

  GlobalKey keyButton;
  late AnimationController animationController;

  _CashContainerState(this.keyButton);

  @override
  void initState() {
    BlocProvider.of<ChangeCurrencyBloc>(context).add(ReadCurrencyBooleanEvent());
    animationController = AnimationController(
      vsync: this,
      lowerBound: 0.8,
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
        height: Dimensions.height45*5,
        margin: EdgeInsets.only(
          left: Dimensions.width30,
          right: Dimensions.width30,
        ),
        decoration: BoxDecoration(
          color: AppColors.cashContainerColor,
            borderRadius: BorderRadius.circular(Dimensions.radius20*2)),

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
                              Expanded(
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        height: Dimensions.height45*2.2,
                                        width: Dimensions.width45*4,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: AppColors.cashContainerShapeBorderColor,
                                                width: 2),
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(Dimensions.radius20*2),
                                              topLeft: Radius.circular(Dimensions.radius20*2),
                                              topRight: Radius.circular(Dimensions.radius20*2),
                                            )
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimensions.height25,
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(AppLocale.expenses.getString(context),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: Dimensions.font20,
                                                  fontWeight: FontWeight.w800,)),
                                            SizedBox(width: Dimensions.width10,),
                                            // const AnimatedModalBarrierApp(),
                                            Image.asset(
                                                "assets/main_page_first_container_logo/darkExpenses.png",
                                            scale: Dimensions.width10/8),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Dimensions.height10,
                                        ),
                                        englishLanguageBoolean == false
                                            ? Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                                (state.expensesPerMonth != "" && state.expensesPerMonth != 0.toString())
                                                    ? rialCurrencyType == true
                                                    ? AppLocale.rial.getString(context)
                                                    : AppLocale.toman.getString(context)
                                                    : ''.toPersianDigit(),
                                                style: const TextStyle(
                                                    color: Colors.white)),
                                            SizedBox(width: Dimensions.width10 / 3),
                                            Text(
                                                state.expensesPerMonth != ""
                                                    ? rialCurrencyType == true
                                                    ? ('${state.expensesPerMonth}0').toPersianDigit().seRagham()
                                                    : state.expensesPerMonth.toPersianDigit().seRagham()
                                                    : "0".toPersianDigit(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w800,
                                                    color: Colors.white,
                                                    fontSize: Dimensions.font26)),
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
                                                    fontSize: Dimensions.font26)),
                                            SizedBox(width: Dimensions.width10 / 3),
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
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: Dimensions.height20,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(AppLocale.cash.getString(context),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: Dimensions.font20,
                                                  fontWeight: FontWeight.w800,)),
                                            SizedBox(
                                                width: Dimensions.width10),
                                            Image.asset(
                                                "assets/main_page_first_container_logo/darkBalance.png",
                                                scale: Dimensions.width10/8),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Dimensions.height10,
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
                                                    fontWeight: FontWeight.w800,
                                                    color: Colors.white)),
                                            SizedBox(width: Dimensions.width10 / 3),
                                            Text(
                                                state.calculateCash != ""
                                                    ? rialCurrencyType == true
                                                    ? ('${state.calculateCash}0').toPersianDigit().seRagham()
                                                    : state.calculateCash.toPersianDigit().seRagham()
                                                    : "0".toPersianDigit(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w800,
                                                    color: Colors.white,
                                                    fontSize: Dimensions.font26)),
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
                                                    fontSize: Dimensions.font26)),
                                            SizedBox(width: Dimensions.width10 / 3),
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
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        height: Dimensions.height45*2.2,
                                        width: Dimensions.width45*4,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.cashContainerShapeBorderColor,
                                            width: 2),
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
                                                    TextStyle(
                                                        fontSize: Dimensions.font20,
                                                      fontWeight: FontWeight.w800,),
                                                  ),
                                                  content: Text(
                                                      AppLocale.pleaseEnterYourBalanceAmount
                                                          .getString(context),
                                                      textDirection: TextDirection.rtl,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.w800,
                                                          fontSize: Dimensions.font20)),
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
                                                          fontWeight: FontWeight.w800,
                                                          fontSize: Dimensions.font20,
                                                        )),
                                                    SizedBox(
                                                        width: Dimensions.width10),
                                                    AnimatedBuilder(
                                                      animation: animationController,
                                                      builder: (context, child) {
                                                        return SizedBox(
                                                          width: Dimensions.width30* animationController.value,
                                                          height: Dimensions.height30* animationController.value,
                                                          child: Image.asset(
                                                              key: keyButton,
                                                              "assets/main_page_first_container_logo/darkIncome.png",
                                                              color: Colors.green,
                                                            scale: Dimensions.width10/8,
                                                              ),
                                                        );
                                                      }
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: Dimensions.height10,
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
                                                            fontWeight: FontWeight.w800,
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
                                                            fontWeight: FontWeight.w800,
                                                            fontSize: Dimensions.font26)),
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
                                                            fontWeight: FontWeight.w800,
                                                            fontSize: Dimensions.font26)),
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
                                                          fontWeight: FontWeight.w800,
                                                          color: Colors.white,
                                                          fontSize: Dimensions.font20
                                                        )),
                                                  ],
                                                ),
                                              ],
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          );
                        });});
            }),
      );});
  }
}