import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/event.dart';
import 'package:income_and_expenses/bloc/them_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/them_bloc/state.dart';
import 'package:income_and_expenses/const/app_colors.dart';
import 'package:income_and_expenses/utils/cash_container.dart';
import 'package:income_and_expenses/utils/date_picker_calendar.dart';
import 'package:income_and_expenses/const/dimensions.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../bloc/change_currency_bloc/bloc.dart';
import '../bloc/change_currency_bloc/state.dart';
import '../bloc/change_language_bloc/bloc.dart';
import '../bloc/change_language_bloc/event.dart';
import '../bloc/change_language_bloc/state.dart';
import '../bloc/set_date_bloc/state.dart';
import '../const/language.dart';
import '../utils/cash_container_per_date.dart';

class MainExpensesPage extends StatefulWidget {

  GlobalKey keyButton;
  GlobalKey keyButton1;
  GlobalKey keyButton2;
  GlobalKey keyButton3;

  MainExpensesPage({Key? key, required this.keyButton, required this.keyButton1,
  required this.keyButton2, required this.keyButton3}) : super(key: key);

  @override
  State<MainExpensesPage> createState() => _MainExpensesPageState(keyButton, keyButton1, keyButton2, keyButton3);
}

class _MainExpensesPageState extends State<MainExpensesPage> {

  String date = "";
  GlobalKey keyButton;
  GlobalKey keyButton1;
  GlobalKey keyButton2;
  GlobalKey keyButton3;

  _MainExpensesPageState(this.keyButton, this.keyButton1, this.keyButton2, this.keyButton3);

  @override
  void initState() {

    BlocProvider.of<SetDateBloc>(context)
        .add(InitialDateEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {

          var darkThemeBoolean = state.darkThemeBoolean;

    return BlocBuilder<ChangeLanguageBloc, ChangeLanguageState>(
        builder: (context, state) {

          bool englishLanguageBoolean = state.englishLanguageBoolean;

        return BlocBuilder<ChangeCurrencyBloc, ChangeCurrencyState>(
          builder: (context, state) {

            bool rialCurrencyType = state.rialCurrencyBoolean;

            return BlocBuilder<SetDateBloc, SetDateState>(
                builder: (context, state) {
                  BlocProvider.of<SetDateBloc>(context).add(ReadTodayExpensesEvent());
                  BlocProvider.of<SetDateBloc>(context).add(FetchExpensesEvent(date: state.date));
                  return Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: darkThemeBoolean == "false"
                  ? Colors.white
                  : AppColors.darkThemeColor,
              body: Stack(
                children: [
                  Container(
                    height: Dimensions.height45 * 5,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment(0.8, 1),
                        colors: <Color>[
                          Color.fromRGBO(248, 187, 208, 1),
                          Color.fromRGBO(212, 200, 235, 1),
                          Color.fromRGBO(179, 229, 252, 1),
                        ],
                        // Gradient from https://learnui.design/tools/gradient-generator.html
                        tileMode: TileMode.mirror,
                      ),
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.elliptical(
                              MediaQuery.of(context).size.width,
                              Dimensions.height45 * 9)),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: Dimensions.height45,
                      ),
                      Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: Dimensions.height10,
                                  ),
                                  child: SizedBox(
                                    key: keyButton1,
                                    height: Dimensions.height10,
                                    width: Dimensions.width10,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 130,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: Dimensions.height10,
                                  ),
                                  child: SizedBox(
                                    key: keyButton2,
                                    height: Dimensions.height10 * 2,
                                    width: Dimensions.width10 * 2,
                                  ),
                                ),
                              ),
                              SizedBox(width: 130),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: Dimensions.height10,
                                  ),
                                  child: SizedBox(
                                    key: keyButton3,
                                    height: Dimensions.height10,
                                    width: Dimensions.width10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          DatePickerCalendar(),
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.height30,
                      ),
                      CashContainer(keyButton: keyButton),
                      SizedBox(
                        height: Dimensions.height30,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            right: Dimensions.width15,
                            left: Dimensions.width15),
                        child: englishLanguageBoolean == false
                            ? state.todayExpenses != ''
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    rialCurrencyType == true
                                        ? ("${state.todayExpenses}0")
                                            .toPersianDigit()
                                            .seRagham()
                                        : state.todayExpenses
                                            .toPersianDigit()
                                            .seRagham(),
                                    style: TextStyle(
                                        color: darkThemeBoolean == "false"
                                            ? AppColors.appBarTitleColor
                                            : Colors.white,
                                        fontSize: Dimensions.font16),
                                  ),
                                  Text(
                                    AppLocale.allExpenses.getString(context),
                                    style: TextStyle(
                                        color: darkThemeBoolean == "false"
                                            ? AppColors.appBarTitleColor
                                            : Colors.white,
                                        fontSize: Dimensions.font12),
                                  ),
                                ],
                              )
                            : Container()
                            : state.todayExpenses != ''
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocale.allExpenses.getString(context),
                                    style: TextStyle(
                                        color: darkThemeBoolean == "false"
                                            ? AppColors.appBarTitleColor
                                            : Colors.white,
                                        fontSize: Dimensions.font12),
                                  ),
                                  Text(
                                    rialCurrencyType == true
                                        ? ("${state.todayExpenses}0").seRagham()
                                        : state.todayExpenses.seRagham(),
                                    style: TextStyle(
                                        color: darkThemeBoolean == "false"
                                            ? AppColors.appBarTitleColor
                                            : Colors.white,
                                        fontSize: Dimensions.font14),
                                  ),
                                ],
                              )
                            : Container(),
                      ),
                      CashContainerPerDate(
                        darkThemeBoolean: darkThemeBoolean,
                        englishLanguageBoolean: englishLanguageBoolean,
                        rialCurrencyType: rialCurrencyType,
                      ),
                    ],
                  )
                ],
              ),
            );
          });});});});
  }
}
