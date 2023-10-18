import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:income_and_expenses/logic/bloc/change_currency_bloc/bloc.dart';
import 'package:income_and_expenses/logic/bloc/change_currency_bloc/state.dart';
import 'package:income_and_expenses/logic/bloc/set_date_bloc/bloc.dart';
import 'package:income_and_expenses/logic/bloc/set_date_bloc/event.dart';
import 'package:income_and_expenses/logic/bloc/set_date_bloc/state.dart';
import 'package:income_and_expenses/logic/bloc/them_bloc/bloc.dart';
import 'package:income_and_expenses/logic/bloc/them_bloc/state.dart';
import 'package:income_and_expenses/presentation/const/app_colors.dart';
import 'package:income_and_expenses/presentation/pages/edit_expense_page.dart';
import 'package:income_and_expenses/presentation/utils/no_data.dart';
import 'package:intl/intl.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

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
                              persianAllExpenses(rialCurrencyType, state,
                                  darkThemeBoolean, context),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height / 60),
                              expensesList(context, allTodayExpenses, state,
                                  rialCurrencyType, darkThemeBoolean),
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
  }

  Container expensesList(BuildContext context, int allTodayExpenses, SetDateState state, bool rialCurrencyType, String darkThemeBoolean) {

    return Container(
      decoration: BoxDecoration(
          color: AppColors.themContainer,
          borderRadius: BorderRadius.circular(15)),
      height: MediaQuery.of(context).size.height / 2.1,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(
            right: MediaQuery.of(context).size.width / 60,
            left: MediaQuery.of(context).size.width / 60),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          allTodayExpenses += state.expenseDetails[index].expense!;
          BlocProvider.of<SetDateBloc>(context).add(
              AddTodayExpensesEvent(todayExpensesDetails: allTodayExpenses));

          return GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditedExpensePage(
                          expenseModel: state.expenseDetails[index])));
            },
            child: Container(
              margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 60,
                right: MediaQuery.of(context).size.width / 60,
                top: MediaQuery.of(context).size.height / 60,
              ),
              decoration: BoxDecoration(
                color: darkThemeBoolean == "false" ? Colors.white : AppColors.darkThemeColor,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width / 20,
                              right: MediaQuery.of(context).size.width / 50,
                              bottom: MediaQuery.of(context).size.width / 20
                          ),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.colorList[index]),
                          child: Container(
                            margin: EdgeInsets.all(
                                MediaQuery.of(context).size.width / 50),
                            child: SvgPicture.asset(
                                height: MediaQuery.of(context).size.height / 30,
                                width: MediaQuery.of(context).size.width / 30,
                                state.expenseDetails[index].expensesIconType!
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 50,
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                  textAlign: TextAlign.end,
                                  state.expenseDetails[index].expenseCategory!,
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width / 25,
                                      fontWeight: FontWeight.w700,
                                      color: darkThemeBoolean == "false"
                                          ? AppColors.black
                                          : Colors.white)),
                              Container(
                                margin: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.height /50,
                                    top: MediaQuery.of(context).size.height /50,
                                  left: MediaQuery.of(context).size.width /50,
                                ),
                                child: Text(
                                    textAlign: TextAlign.justify,
                                    overflow: TextOverflow.clip,
                                    state.expenseDetails[index]
                                        .expensesDescription!,
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: MediaQuery.of(context).size.width / 30,
                                        fontWeight: FontWeight.w400,
                                        color: darkThemeBoolean == "false"
                                            ? AppColors.appBarProfileName
                                            : Colors.white)),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 30,
                      right: MediaQuery.of(context).size.width / 30 ),
                      child: Text(
                          rialCurrencyType == true
                              ? "${("${state.expenseDetails[index].expense!}0").toPersianDigit().seRagham()}-"
                              : "${state.expenseDetails[index].expense!.toString().toPersianDigit().seRagham()}-",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context)
                                  .size
                                  .width /
                                  22,
                              color: darkThemeBoolean == "false"
                                  ? AppColors.expensesDigitColor
                                  : Colors.white)),
                    ),
                  )
                ],
              )
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
          AppLocalizations.of(context)!.allExpenses,
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
          AppLocalizations.of(context)!.allExpenses,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              color: darkThemeBoolean == "false"
                  ? AppColors.appBarTitleColor
                  : Colors.white,
              fontSize: MediaQuery.of(context).size.width / 25),
        ),
        Text(
          rialCurrencyType == true
              ? AppLocalizations.of(context)!.language == "زبان"
              ? ("${state.expensesPerDate}0").toPersianDigit().seRagham()
              : ("${state.expensesPerDate}0").seRagham()
              : state.expensesPerDate.seRagham(),
          style: TextStyle(
            color: darkThemeBoolean == "false"
                ? AppColors.appBarTitleColor
                : Colors.white,
            fontSize: MediaQuery.of(context).size.width / 20,
          ),
        ),
      ],
    );
  }
}
