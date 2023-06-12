import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/state.dart';
import 'package:income_and_expenses/const/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../bloc/change_currency_bloc/bloc.dart';
import '../bloc/change_currency_bloc/state.dart';
import '../bloc/change_language_bloc/bloc.dart';
import '../bloc/change_language_bloc/state.dart';
import '../bloc/set_date_bloc/event.dart';
import '../bloc/them_bloc/bloc.dart';
import '../bloc/them_bloc/state.dart';
import '../const/language.dart';
import '../pages/edit_expense_page.dart';
import 'no_data.dart';

class CashContainerPerDate extends StatefulWidget {

  const CashContainerPerDate({Key? key}) : super(key: key);

  @override
  State<CashContainerPerDate> createState() => _CashContainerPerDateState();
}

class _CashContainerPerDateState extends State<CashContainerPerDate> {

  @override
  void initState() {
    String selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.parse(Jalali.now().toJalaliDateTime()));
    BlocProvider.of<SetDateBloc>(context).add(
        FetchExpensesItemsEvent(date: selectedDate));
    BlocProvider.of<SetDateBloc>(context).add(SumExpensePerDateEvent(date: selectedDate));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {

      var darkThemeBoolean = state.darkThemeBoolean;

      return BlocBuilder<ChangeLanguageBloc, ChangeLanguageState>(
          builder: (context, state) {
        bool englishLanguageBoolean = state.englishLanguageBoolean;

        return BlocBuilder<ChangeCurrencyBloc, ChangeCurrencyState>(
            builder: (context, state) {

          bool rialCurrencyType = state.rialCurrencyBoolean;

          return Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 100,
                bottom: MediaQuery.of(context).size.height / 100,
                right: MediaQuery.of(context).size.width / 30,
                left: MediaQuery.of(context).size.width / 30,),
            child: BlocBuilder<SetDateBloc, SetDateState>(
                builder: (context, state) {
              int allTodayExpenses = 0;

              return state.status.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : state.status.isSuccess
                      ? state.expenseDetails.isNotEmpty
                          ? Column(
                              children: [
                                englishLanguageBoolean == false
                                    ? persianAllExpenses(rialCurrencyType, state, darkThemeBoolean, context)
                                    : englishAllExpenses(context, darkThemeBoolean, rialCurrencyType, state),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height / 60
                                ),
                                expensesList(context, allTodayExpenses, state, englishLanguageBoolean, rialCurrencyType, darkThemeBoolean),
                              ],
                            )
                          : const Center(
                              child: NoDataPage(),
                            )
                      : state.status.isError
                          ? Container()
                          : Container();
            }),
          );
        });
      });
    });
  }

  Container expensesList(BuildContext context, int allTodayExpenses, SetDateState state, bool englishLanguageBoolean, bool rialCurrencyType, String darkThemeBoolean) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.themContainer,
          borderRadius: BorderRadius.circular(15)),
      height: MediaQuery.of(context).size.height / 2.1,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height / 10,
            right: MediaQuery.of(context).size.width / 60,
            left: MediaQuery.of(context).size.width / 60),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          allTodayExpenses += state.expenseDetails[index].expense!;
          BlocProvider.of<SetDateBloc>(context).add(
              AddTodayExpensesEvent(todayExpensesDetails: allTodayExpenses));

          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height / 60),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 80,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditedExpensePage(
                                expenseModel: state.expenseDetails[index])));
                  },
                  child: englishLanguageBoolean == false
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                  rialCurrencyType == true
                                      ? "-${("${state.expenseDetails[index].expense!}0").toPersianDigit().seRagham()}"
                                      : "-${state.expenseDetails[index].expense!.toString().toPersianDigit().seRagham()}",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width / 22,
                                      color: darkThemeBoolean == "false"
                                          ? AppColors.expensesDigitColor
                                          : Colors.white)),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width / 2.3,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                              state.expenseDetails[index].expenseCategory!.getString(context),
                                              style: TextStyle(
                                                  fontSize: MediaQuery.of(context).size.width / 25,
                                                  fontWeight: FontWeight.w700,
                                                  color: darkThemeBoolean == "false"
                                                      ? AppColors.black
                                                      : Colors.white)),
                                          Text(
                                              state.expenseDetails[index]
                                                  .expensesDescription!,
                                              style: TextStyle(
                                                  fontSize: MediaQuery.of(context).size.width / 30,
                                                  fontWeight: FontWeight.w400,
                                                  color: darkThemeBoolean == "false"
                                                      ? AppColors.appBarProfileName
                                                      : Colors.white)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width / 25,
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.colorList[index]),
                                      child: Container(
                                        margin: EdgeInsets.all(
                                            MediaQuery.of(context).size.width / 50),
                                        child: SvgPicture.asset(
                                          height: MediaQuery.of(context).size.height / 30,
                                            width: MediaQuery.of(context).size.width / 30,
                                            state.expenseDetails[index].expensesIconType!),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.colorList[index]),
                            child: Container(
                              margin: EdgeInsets.all(
                                  MediaQuery.of(context).size.width / 50),
                              child: SvgPicture.asset(
                                  height: MediaQuery.of(context).size.height / 30,
                                  width: MediaQuery.of(context).size.width / 30,
                                  state.expenseDetails[index].expensesIconType!),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  state.expenseDetails[index].expenseCategory!.getString(context),
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width / 25,
                                      fontWeight: FontWeight.w700,
                                      color: darkThemeBoolean == "false"
                                          ? AppColors.black
                                          : Colors.white)),
                              Text(
                                  state.expenseDetails[index]
                                      .expensesDescription!,
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width / 30,
                                      fontWeight: FontWeight.w400,
                                      color: darkThemeBoolean == "false"
                                          ? AppColors.appBarProfileName
                                          : Colors.white)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width / 8),
                      Text(
                          rialCurrencyType == true
                              ? "-${("${state.expenseDetails[index].expense!}0").seRagham()}"
                              : "-${state.expenseDetails[index].expense!.toString().seRagham()}",
                          style: TextStyle(
                              fontSize:
                              MediaQuery.of(context).size.width / 26,
                              color: darkThemeBoolean == "false"
                                  ? AppColors.expensesDigitColor
                                  : Colors.white)),
                    ],
                  ),
                ),
                Divider(
                  thickness: 0.5,
                  color: darkThemeBoolean == "false"
                      ? AppColors.iconUnSelectedBackGroundMainColor
                      : Colors.white,
                ),
              ],
            ),
          );
        },
        itemCount: state.expenseDetails.length,
      ),
    );
  }

  Row englishAllExpenses(BuildContext context, String darkThemeBoolean, bool rialCurrencyType, SetDateState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppLocale.allExpenses.getString(context),
          style: TextStyle(
              color: darkThemeBoolean == "false"
                  ? AppColors.appBarTitleColor
                  : Colors.white,
              fontSize: MediaQuery.of(context).size.width / 25),
        ),
        Text(
          rialCurrencyType == true
              ? ("${state.expensesPerDate}0").seRagham()
              : state.expensesPerDate.seRagham(),
          style: TextStyle(
              fontWeight: FontWeight.w700,
              color: darkThemeBoolean == "false"
                  ? AppColors.appBarTitleColor
                  : Colors.white,
              fontSize: MediaQuery.of(context).size.width / 30),
        ),
      ],
    );
  }

  Row persianAllExpenses(bool rialCurrencyType, SetDateState state, String darkThemeBoolean, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          rialCurrencyType == true
              ? ("${state.expensesPerDate}0").toPersianDigit().seRagham()
              : state.expensesPerDate.toPersianDigit().seRagham(),
          style: TextStyle(
            color: darkThemeBoolean == "false"
                ? AppColors.appBarTitleColor
                : Colors.white,
            fontSize: MediaQuery.of(context).size.width / 20,
          ),
        ),
        Text(
          AppLocale.allExpenses.getString(context),
          style: TextStyle(
              fontWeight: FontWeight.w700,
              color: darkThemeBoolean == "false"
                  ? AppColors.appBarTitleColor
                  : Colors.white,
              fontSize: MediaQuery.of(context).size.width / 25),
        ),
      ],
    );
  }
}
