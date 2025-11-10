import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

import '../../l10n/app_localizations.dart';

class CashContainerPerDate extends StatelessWidget {

  const CashContainerPerDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.parse(Jalali.now().toJalaliDateTime()));
    BlocProvider.of<SetDateBloc>(context).add(
        FetchExpensesItemsEvent(date: selectedDate));
    BlocProvider.of<SetDateBloc>(context).add(SumExpensePerDateEvent(date: selectedDate));

    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {

      var darkThemeBoolean = state.darkThemeBoolean;

      return BlocBuilder<ChangeCurrencyBloc, ChangeCurrencyState>(
          builder: (context, state) {
        bool rialCurrencyType = state.rialCurrencyBoolean;
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;

        return Container(
          margin: EdgeInsets.only(
            top: 10,
            bottom: 10,
            right: 10,
            left: 10,
          ),
          child: BlocBuilder<SetDateBloc, SetDateState>(builder: (context, state) {
            int allTodayExpenses = 0;

            return state.status.isLoading
                ? const Center(child: CircularProgressIndicator())
                : state.status.isSuccess
                    ? state.expenseDetails.isNotEmpty
                        ? Column(
                            children: [
                              persianAllExpenses(rialCurrencyType, state,
                                  darkThemeBoolean, context, width, height),
                              SizedBox(height: 10),
                              expensesList(
                                  context,
                                  allTodayExpenses,
                                  state,
                                  rialCurrencyType,
                                  darkThemeBoolean,
                                  width,
                                  height),
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

  Container expensesList(BuildContext context, int allTodayExpenses, SetDateState state, bool rialCurrencyType, String darkThemeBoolean,
      double width, double height) {

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            stops: [
              0.9,
              0.999
            ],
              colors: [
                AppColors.themContainer,
                Colors.white,
          ]),
          borderRadius: BorderRadius.circular(15)),
      height: 400,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(right: width / 60, left: width / 60, bottom: 30, top: 15),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          allTodayExpenses += state.expenseDetails[index].expense!;
          // print(state.expenseDetails[index].expenseCategory);
          BlocProvider.of<SetDateBloc>(context).add(
              AddTodayExpensesEvent(todayExpensesDetails: allTodayExpenses));

          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditedExpensePage(
                          expenseModel: state.expenseDetails[index])));
            },
            child: Container(
              height: 80,
                margin: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 10,
                ),
                decoration: BoxDecoration(
                  color: darkThemeBoolean == "false"
                      ? Colors.white
                      : AppColors.darkThemeColor,
                  borderRadius: BorderRadius.circular(25),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey.withOpacity(0.5),
                  //     spreadRadius: 5,
                  //     blurRadius: 7,
                  //     offset: const Offset(0, 3), // changes position of shadow
                  //   ),
                  // ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 4,
                              child: categoryIcon(height, width, index, state)),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              flex: 10,
                              child: expensesDetails(context, state, index, width, darkThemeBoolean, height))
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: expensesPrice(context, width, rialCurrencyType, state, index, darkThemeBoolean))
                  ],
                )),
          );
        },
        itemCount: state.expenseDetails.length,
      ),
    );
  }

  Widget expensesPrice(
      BuildContext context,
      double width,
      bool rialCurrencyType,
      SetDateState state,
      int index,
      String darkThemeBoolean,
      ) {
    return Align(
      alignment: AppLocalizations.of(context)!.language == "زبان"
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(left: width / 30, right: width / 30),
        child: Text(
          rialCurrencyType == true
              ? AppLocalizations.of(context)!.language == "زبان"
              ? "${("${state.expenseDetails[index].expense!}0").toPersianDigit().seRagham()} -"
              : "- ${state.expenseDetails[index].expense!.toString().seRagham()}"
              : AppLocalizations.of(context)!.language == "زبان"
              ? "${("${state.expenseDetails[index].expense!}").toPersianDigit().seRagham()} -"
              : "- ${("${state.expenseDetails[index].expense!}").seRagham()}",
          style: TextStyle(
            fontSize: 16,
            color: darkThemeBoolean == "false"
                ? AppColors.expensesDigitColor
                : Colors.white,
          ),
        ),
      ),
    );
  }

  Column expensesDetails(BuildContext context, SetDateState state, int index, double width, String darkThemeBoolean, double height) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppLocalizations.of(context)!.language == "زبان"
            ? Padding(
          padding: EdgeInsets.only(top: 20),
          child: Text(
              textAlign: TextAlign.end,
              state.expenseDetails[index].expenseCategory ?? '',
              overflow: TextOverflow.fade,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: darkThemeBoolean == "false"
                      ? AppColors.black
                      : Colors.white)),
        )
            : Padding(
          padding: EdgeInsets.only(top: 20),
          child: Text(
              textAlign: TextAlign.end,
              ifLanguageIsEnglish(
                  state.expenseDetails[index].expenseCategory!),
              overflow: TextOverflow.fade,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: darkThemeBoolean == "false"
                      ? AppColors.black
                      : Colors.white)),
        ),
        Container(
          margin: EdgeInsets.only(
            bottom: 10,
            top: 10,
          ),
          child: Text(
              textAlign: TextAlign.justify,
              overflow: TextOverflow.clip,
              state.expenseDetails[index].expensesDescription ?? '',
              maxLines: 1,
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: darkThemeBoolean == "false"
                      ? AppColors.appBarProfileName
                      : Colors.white)),
        )
      ],
    );
  }

  Container categoryIcon(double height, double width, int index, SetDateState state) {
    final iconPath = state.expenseDetails[index].expensesIconType;

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.colorList[index % AppColors.colorList.length],
      ),
      child: Container(
        margin: EdgeInsets.all(10),
        child: iconPath != null && iconPath.isNotEmpty
            ? SvgPicture.asset(
          iconPath,
          height: height / 30,
          width: width / 30,
        )
            : Icon(
          Icons.category,
          size: height / 30,
          color: Colors.white,
        ),
      ),
    );
  }

  Container persianAllExpenses(bool rialCurrencyType, SetDateState state, String darkThemeBoolean, BuildContext context,
      double width, double height) {
    return Container(
      margin: EdgeInsets.only(
        left: 20,
        right: 20
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context)!.allExpenses,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: darkThemeBoolean == "false"
                    ? AppColors.appBarTitleColor
                    : Colors.white,
                fontSize: width / 25),
          ),
          Text(
            rialCurrencyType == true
                ? AppLocalizations.of(context)!.language == "زبان"
                ? ("${state.expensesPerDate}0").toPersianDigit().seRagham()
                : ("${state.expensesPerDate}0").seRagham()
                : AppLocalizations.of(context)!.language == "زبان"
                ? state.expensesPerDate.toPersianDigit().seRagham()
                : state.expensesPerDate.seRagham(),
            style: TextStyle(
              color: darkThemeBoolean == "false"
                  ? AppColors.appBarTitleColor
                  : Colors.white,
              fontSize: width / 25,
                fontWeight: FontWeight.w700
            ),
          ),
        ],
      ),
    );
  }

  String ifLanguageIsEnglish(String expensesTypeName){
    if(expensesTypeName == "حمل و نقل"){
      return "Transportation";
    }else if(expensesTypeName == "خوراکی"){
      return "Comestible";
    }else if(expensesTypeName == "خرید اقلام"){
      return "BuyItems";
    }else if(expensesTypeName == "اقساط و بدهی"){
      return "InstallmentsAndDebt";
    }else if(expensesTypeName == "درمانی"){
      return "Treatment";
    }else if(expensesTypeName == "هدایا"){
      return "Gifts";
    }else if(expensesTypeName == "تعمیرات"){
      return "Renovation";
    }else if(expensesTypeName == "تفریح"){
      return "Pastime";
    }else{
      return "Other";
    }
  }
}


