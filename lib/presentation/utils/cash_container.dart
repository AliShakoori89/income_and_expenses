import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/logic/bloc/change_currency_bloc/bloc.dart';
import 'package:income_and_expenses/logic/bloc/change_currency_bloc/event.dart';
import 'package:income_and_expenses/logic/bloc/change_currency_bloc/state.dart';
import 'package:income_and_expenses/logic/bloc/set_date_bloc/bloc.dart';
import 'package:income_and_expenses/logic/bloc/set_date_bloc/state.dart';
import 'package:income_and_expenses/logic/bloc/them_bloc/bloc.dart';
import 'package:income_and_expenses/logic/bloc/them_bloc/state.dart';
import 'package:income_and_expenses/presentation/const/app_colors.dart';
import 'package:income_and_expenses/presentation/pages/add_income_page.dart';
import 'package:income_and_expenses/presentation/pages/income_details_page.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../l10n/app_localizations.dart';


class CashContainer extends StatelessWidget {

  GlobalKey? keyBottomNavigation1;

  CashContainer({Key? key, this.keyBottomNavigation1}) : super(key: key);

  late AnimationController animationController;

  @override
  Widget build(BuildContext context) {

    BlocProvider.of<ChangeCurrencyBloc>(context).add(ReadCurrencyBooleanEvent());

    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {

      var height = MediaQuery.of(context).size.height;
      var width = MediaQuery.of(context).size.width;

      return Container(
        height: 220,
        margin: EdgeInsets.only(
          left: 30,
          right: 30,
        ),
        decoration: BoxDecoration(
            color: AppColors.mainColor,
            borderRadius:
                BorderRadius.circular(width / 10)),
        child: BlocBuilder<ChangeCurrencyBloc, ChangeCurrencyState>(
            builder: (context, state) {
              bool rialCurrencyType = state.rialCurrencyBoolean;

              return BlocBuilder<SetDateBloc, SetDateState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        leftSideCashContainer(context, state, rialCurrencyType, width, height),
                        rightSideCashContainer(context, state, rialCurrencyType, keyBottomNavigation1, width, height)
                      ],
                    );
                  });
            }),
      );
    });
  }

  Expanded rightSideCashContainer(BuildContext context, SetDateState state, bool rialCurrencyType, GlobalKey? keyBottomNavigation1, double width, double height) {
    return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                cashSlice(context, state, rialCurrencyType, width, height),
                incomeSlice(context, state, rialCurrencyType, keyBottomNavigation1, width, height),
              ],
            ),
          );
  }

  Align incomeSlice(BuildContext context, SetDateState state, bool rialCurrencyType, GlobalKey? keyBottomNavigation1,  double width, double height) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        margin: EdgeInsets.only(
            right: 5,
            top:5
        ),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(195, 169, 234, 1.0),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(width / 10),
            topLeft: Radius.circular(width / 10),
            topRight: Radius.circular(width / 10),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(184, 145, 236, 0.6),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Container(
            height: 90,
            width: 175,
          decoration: BoxDecoration(
              color: const Color.fromRGBO(184, 145, 236, 1.0),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(184, 145, 236, 2.0),
                  blurRadius: 0,
                  offset: Offset(1, 1), // Shadow position
                ),
              ],
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(
                  width / 10,
                ),
                bottomLeft: Radius.circular(
                  width / 10,
                ),
                topRight: Radius.circular(
                  width / 10,
                ),
              )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: width / 20,
                    right: width / 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(AppLocalizations.of(context)!.income,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: width / 22,
                          )),
                    ),
                    SizedBox(
                      width: width / 30,
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddIncomePage()),
                        );
                      },
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            width: 30,
                            height: 50,
                            child: Center(
                              child: Container(
                                margin: EdgeInsets.all(5),
                                child: Image.asset(
                                  "assets/main_page_first_container_logo/darkIncome.png",
                                  key: keyBottomNavigation1,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            )
                          ),
                          Positioned(
                            left: 15,
                            top: 5,
                            child: Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.green),
                                  shape: BoxShape.circle,
                                  color: Colors.green
                              ),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Icon(Icons.add, color: Colors.white,
                                    size: 10)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height / 200,
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IncomeDetailsPage(month: state.month)),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        state.incomePerMonth != ""
                            ? rialCurrencyType == true
                            ? AppLocalizations.of(context)!.language == "زبان"
                            ? ("${state.incomePerMonth}0").toPersianDigit().seRagham()
                            : ("${state.incomePerMonth}0").seRagham()
                            : AppLocalizations.of(context)!.language == "زبان"
                            ? state.incomePerMonth.toPersianDigit().seRagham()
                            : state.incomePerMonth.seRagham()
                            : AppLocalizations.of(context)!.language == "زبان"
                            ? "0".toPersianDigit()
                            : "0",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width / 25,
                        )),
                    SizedBox(
                      width: width / 50,
                    ),
                    Text(
                        state.incomePerMonth != ""
                            ? rialCurrencyType == true
                            ? AppLocalizations.of(context)!.rial
                            : AppLocalizations.of(context)!.toman
                            : '',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: width / 22)),
                  ],
                ),
              ),
            ],
          )
        ),
      ),
    );
  }

  Column cashSlice(BuildContext context, SetDateState state, bool rialCurrencyType, double width, double height) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context)!.cash,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: width / 22,
                  fontWeight: FontWeight.w800,
                )),
            SizedBox(
              width: width / 18,
            ),
            SizedBox(
              width: 20,
              height: 40,
              child: Image.asset("assets/main_page_first_container_logo/darkBalance.png",
                  fit: BoxFit.contain),
            ),
          ],
        ),
        SizedBox(
          height: height / 200,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                textDirection: AppLocalizations.of(context)!.language == "زبان"
                    ? TextDirection.ltr
                    : TextDirection.rtl,
                  state.calculateCash != ""
                      ? rialCurrencyType == true
                          ? AppLocalizations.of(context)!.language == "زبان"
                              ? ("${state.calculateCash}0")
                                  .toPersianDigit()
                                  .seRagham()
                              : ("${state.calculateCash}0").seRagham()
                          : AppLocalizations.of(context)!.language == "زبان"
                              ? state.calculateCash.toPersianDigit().seRagham()
                              : state.calculateCash.seRagham()
                      : AppLocalizations.of(context)!.language == "زبان"
                          ? "0".toPersianDigit()
                          : "0",
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: width / 25,
                  )),
            ),
            SizedBox(
              width: width / 50,
            ),
            Flexible(
              child: Text(
                  state.calculateCash != ""
                      ? rialCurrencyType == true
                          ? AppLocalizations.of(context)!.rial
                          : AppLocalizations.of(context)!.toman
                      : ''.toPersianDigit(),
                  style: TextStyle(color: Colors.white, fontSize: width / 22)),
            ),
          ],
        ),
      ],
    );
  }

  Expanded leftSideCashContainer(BuildContext context, SetDateState state, bool rialCurrencyType, double width, double height) {
    return Expanded(
      child: Column(
        children: [
          shapeSlice(context, width, height),
          Expanded(
            child: expensesSlice(
                context, state, rialCurrencyType, width, height),
          ),
        ],
      ),
    );
  }

  Column expensesSlice(BuildContext context, SetDateState state, bool rialCurrencyType, double width, double height) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context)!.expenses,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                )),
            SizedBox(
              width: width / 18,
            ),
            SizedBox(
              width: 20,
              height: 40,
              child: Image.asset("assets/main_page_first_container_logo/darkBalance.png",
                  fit: BoxFit.contain),
            ),
          ],
        ),
        SizedBox(
          height: height / 200,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                state.expensesPerMonth != ""
                    ? rialCurrencyType == true
                    ? AppLocalizations.of(context)!.language == "زبان"
                    ? ("${state.expensesPerMonth}0").toPersianDigit().seRagham()
                    : ("${state.expensesPerMonth}0").seRagham()
                    : AppLocalizations.of(context)!.language == "زبان"
                    ? state.expensesPerMonth.toPersianDigit().seRagham()
                    : state.expensesPerMonth.seRagham()
                    : AppLocalizations.of(context)!.language == "زبان"
                    ? "0".toPersianDigit()
                    : "0",
                style: TextStyle(
                  // fontWeight: FontWeight.w800,
                  color: Colors.white,
                  fontSize: width / 25,
                )),
            SizedBox(
              width: width / 50,),
            Text(
                state.expensesPerMonth != ""
                    ? rialCurrencyType == true
                    ? AppLocalizations.of(context)!.rial
                    : AppLocalizations.of(context)!.toman
                    : ''.toPersianDigit(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: width / 22)),
          ],
        ),
      ],
    );
  }

  Align shapeSlice(BuildContext context, double width, double height) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: EdgeInsets.only(
          left: 5,
          bottom:5
        ),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(195, 169, 234, 1.0),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(width / 10),
            topLeft: Radius.circular(width / 10),
            topRight: Radius.circular(width / 10),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(184, 145, 236, 0.6),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Container(
          height: 90,
          width: 175,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(184, 145, 236, 1.0),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(width / 10),
              topLeft: Radius.circular(width / 10),
              topRight: Radius.circular(width / 10),
            ),
          ),
        ),
      ),
    );
  }
}