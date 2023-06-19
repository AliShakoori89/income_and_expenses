import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:income_and_expenses/bloc/change_currency_bloc/event.dart';
import 'package:income_and_expenses/bloc/change_language_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/change_language_bloc/state.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/state.dart';
import 'package:income_and_expenses/const/app_colors.dart';
import 'package:income_and_expenses/const/language.dart';
import 'package:income_and_expenses/pages/income_details_page.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../bloc/change_currency_bloc/bloc.dart';
import '../bloc/change_currency_bloc/state.dart';
import '../bloc/set_date_bloc/bloc.dart';
import '../bloc/them_bloc/bloc.dart';
import '../bloc/them_bloc/state.dart';
import '../pages/add_income_page.dart';

class CashContainer extends StatefulWidget {

  GlobalKey? keyBottomNavigation1;

  CashContainer({Key? key, this.keyBottomNavigation1}) : super(key: key);

  @override
  State<CashContainer> createState() => _CashContainerState(keyBottomNavigation1);
}

class _CashContainerState extends State<CashContainer> with TickerProviderStateMixin  {

  late AnimationController animationController;
  GlobalKey? keyBottomNavigation1;

  _CashContainerState(this.keyBottomNavigation1);

  @override
  void initState() {
    BlocProvider.of<ChangeCurrencyBloc>(context).add(ReadCurrencyBooleanEvent());
    super.initState();
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
              String dateMonth = state.date;

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  leftSideCashContainer(context, englishLanguageBoolean, state, rialCurrencyType),
                  rightSideCashContainer(context, englishLanguageBoolean, state, rialCurrencyType, keyBottomNavigation1)
                ],
              );
            });
          });
        }),
      );
    });
  }

  Expanded rightSideCashContainer(BuildContext context, bool englishLanguageBoolean, SetDateState state, bool rialCurrencyType, GlobalKey? keyBottomNavigation1) {
    return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      cashSlice(context, englishLanguageBoolean, state, rialCurrencyType),
                      incomeSlice(context, englishLanguageBoolean, state, rialCurrencyType, keyBottomNavigation1),
                    ],
                  ),
                );
  }

  Align incomeSlice(BuildContext context, bool englishLanguageBoolean, SetDateState state, bool rialCurrencyType, GlobalKey? keyBottomNavigation1) {

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 20,
                  right: MediaQuery.of(context).size.width / 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(AppLocale.income.getString(context),
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: MediaQuery.of(context).size.width / 22,
                        )),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 30,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AddIncomePage()),
                      );
                    },
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 10,
                          height: MediaQuery.of(context).size.height / 20,
                          child: Image.asset(
                            "assets/main_page_first_container_logo/darkIncome.png",
                            key: keyBottomNavigation1,
                            scale: MediaQuery.of(context).size.width / 500,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 25,
                          height: MediaQuery.of(context).size.height / 35,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.green),
                              shape: BoxShape.circle,
                              color: Colors.green
                          ),
                          child: Align(
                              alignment: Alignment.center,
                              child: Icon(Icons.add, color: Colors.white,
                                size: MediaQuery.of(context).size.width / 30,)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 200,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => IncomeDetailsPage(month: state.month)),
                );
              },
              child: englishLanguageBoolean == false
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      state.incomePerMonth != ""
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
                      state.incomePerMonth != ""
                          ? rialCurrencyType == true
                          ? ('${state.incomePerMonth}0')
                          .toPersianDigit()
                          .seRagham()
                          : state.incomePerMonth.toPersianDigit().seRagham()
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
                      state.incomePerMonth != ""
                          ? rialCurrencyType == true
                          ? ("${state.incomePerMonth}0").seRagham()
                          : state.incomePerMonth.seRagham()
                          : "0",
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
                      state.incomePerMonth != ""
                          ? rialCurrencyType == true
                          ? AppLocale.rial.getString(context)
                          : AppLocale.toman.getString(context)
                          : "",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        fontSize:
                        MediaQuery.of(context).size.width / 30,
                      )),
                ],
              ),
            ),
          ],
        )
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
          Expanded(
            child: expensesSlice(
                context, englishLanguageBoolean, state, rialCurrencyType),
          ),
        ],
      ),
    );
  }

  Column expensesSlice(BuildContext context, bool englishLanguageBoolean, SetDateState state, bool rialCurrencyType) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 30,
        ),
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
                state.expensesPerMonth != ""
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
                state.expensesPerMonth != ""
                    ? rialCurrencyType == true
                    ? ('${state.expensesPerMonth}0')
                    .toPersianDigit()
                    .seRagham()
                    : state.expensesPerMonth.toPersianDigit().seRagham()
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