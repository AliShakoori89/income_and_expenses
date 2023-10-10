import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/bloc/change_currency_bloc/event.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/state.dart';
import 'package:income_and_expenses/const/app_colors.dart';
import 'package:income_and_expenses/pages/income_details_page.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
        height: MediaQuery.of(context).size.height / 3.8,
        margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width / 15,
          right: MediaQuery.of(context).size.width / 15,
        ),
        decoration: BoxDecoration(
            color: AppColors.mainColor,
            borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.width / 10)),
        child: BlocBuilder<ChangeCurrencyBloc, ChangeCurrencyState>(
            builder: (context, state) {
              bool rialCurrencyType = state.rialCurrencyBoolean;

              return BlocBuilder<SetDateBloc, SetDateState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        leftSideCashContainer(context, state, rialCurrencyType),
                        rightSideCashContainer(context, state, rialCurrencyType, keyBottomNavigation1)
                      ],
                    );
                  });
            }),
      );
    });
  }

  Expanded rightSideCashContainer(BuildContext context, SetDateState state, bool rialCurrencyType, GlobalKey? keyBottomNavigation1) {
    return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      cashSlice(context, state, rialCurrencyType),
                      incomeSlice(context, state, rialCurrencyType, keyBottomNavigation1),
                    ],
                  ),
                );
  }

  Align incomeSlice(BuildContext context, SetDateState state, bool rialCurrencyType, GlobalKey? keyBottomNavigation1) {

    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        height: MediaQuery.of(context).size.height / 8.5,
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(184, 145, 236, 1.0),
                blurRadius: 9,
                offset: Offset(0, 0), // Shadow position
              ),
            ],
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
                    child: Text(AppLocalizations.of(context)!.income,
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
                          height: MediaQuery.of(context).size.height / 30,
                          child: Image.asset(
                            "assets/main_page_first_container_logo/darkIncome.png",
                            key: keyBottomNavigation1,
                            fit: BoxFit.contain,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      state.incomePerMonth != ""
                          ? rialCurrencyType == true
                          ? AppLocalizations.of(context)!.rial
                          : AppLocalizations.of(context)!.toman
                          : '',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width / 22)),
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
                        fontSize: MediaQuery.of(context).size.width / 20,
                      )),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }

  Column cashSlice(BuildContext context, SetDateState state, bool rialCurrencyType) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context)!.cash,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width / 22,
                  fontWeight: FontWeight.w800,
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width / 18,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 10,
              height: MediaQuery.of(context).size.height / 30,
              child: Image.asset("assets/main_page_first_container_logo/darkBalance.png",
                  fit: BoxFit.contain),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 200,
        ),
        Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      state.calculateCash != ""
                          ? rialCurrencyType == true
                              ? AppLocalizations.of(context)!.rial
                              : AppLocalizations.of(context)!.toman
                          : ''.toPersianDigit(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width / 22)),
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
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width / 22,
                      )),
                ],
              ),
      ],
    );
  }

  Expanded leftSideCashContainer(BuildContext context, SetDateState state, bool rialCurrencyType) {
    return Expanded(
      child: Column(
        children: [
          shapeSlice(context),
          Expanded(
            child: expensesSlice(
                context, state, rialCurrencyType),
          ),
        ],
      ),
    );
  }

  Column expensesSlice(BuildContext context, SetDateState state, bool rialCurrencyType) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context)!.expenses,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width / 22,
                  fontWeight: FontWeight.w800,
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width / 18,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 10,
              height: MediaQuery.of(context).size.height / 30,
              child: Image.asset("assets/main_page_first_container_logo/darkBalance.png",
                  fit: BoxFit.contain),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 200,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                state.expensesPerMonth != ""
                    ? rialCurrencyType == true
                    ? AppLocalizations.of(context)!.rial
                    : AppLocalizations.of(context)!.toman
                    : ''.toPersianDigit(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width / 22)),
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
                  // fontWeight: FontWeight.w800,
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width / 22,
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
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(184, 145, 236, 1.0),
              blurRadius: 9,
              offset: Offset(0, 0), // Shadow position
            ),
          ],
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