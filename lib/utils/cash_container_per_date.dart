import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:income_and_expenses/bloc/add_expense_bloc/bloc.dart';
import 'package:income_and_expenses/const/app_colors.dart';
import 'package:income_and_expenses/const/dimensions.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../bloc/add_expense_bloc/event.dart';
import '../bloc/add_expense_bloc/state.dart';
import '../bloc/change_language_bloc/bloc.dart';
import '../bloc/change_language_bloc/event.dart';
import '../bloc/change_language_bloc/state.dart';
import '../bloc/them_bloc/bloc.dart';
import '../bloc/them_bloc/event.dart';
import '../bloc/them_bloc/state.dart';
import '../const/language.dart';

class CashContainerPerDate extends StatefulWidget {
  const CashContainerPerDate({Key? key}) : super(key: key);

  @override
  State<CashContainerPerDate> createState() => _CashContainerPerDateState();
}

class _CashContainerPerDateState extends State<CashContainerPerDate> {

  @override
  void initState() {
    final expensesBloc = BlocProvider.of<AddExpenseBloc>(context);
    expensesBloc.add(FetchExpensesEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    // BlocProvider.of<ChangeLanguageBloc>(context).add(ReadLanguageBooleanEvent());
    // BlocProvider.of<ThemeBloc>(context).add(ReadThemeBooleanEvent());

    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {

      var darkThemeBoolean = state.darkThemeBoolean;

      return Container(
          decoration: BoxDecoration(
              color: darkThemeBoolean == "false"
                  ? AppColors.backGroundColor
                  : AppColors.darkThemeColor,
              border: Border.all(
                  color: darkThemeBoolean == "false"
                      ? AppColors.mainPageCardBorderColor
                      : AppColors.darkThemeBorderColor),
              borderRadius: BorderRadius.circular(Dimensions.radius8)),
          child: BlocBuilder<ChangeLanguageBloc, ChangeLanguageState>(
              builder: (context, state) {
            bool persianLanguageBoolean = state.englishLanguageBoolean;

            return Container(
              margin: EdgeInsets.only(
                  top: Dimensions.height15,
                  bottom: Dimensions.height15,
                  right: Dimensions.width15,
                  left: Dimensions.width15),
              child: BlocBuilder<AddExpenseBloc, AddExpenseState>(
                  builder: (context, state) {
                int allTodayExpenses = 0;
                BlocProvider.of<AddExpenseBloc>(context)
                    .add(ReadTodayExpensesEvent());

                return state.status.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : state.status.isSuccess
                        ? state.expenses.isNotEmpty
                            ? Column(
                                children: [
                                  persianLanguageBoolean == true
                                      ? Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(state.todayExpenses.toPersianDigit().seRagham(),
                                              style: TextStyle(
                                                  color: darkThemeBoolean == "false"
                                                      ? AppColors.appBarTitleColor
                                                      : Colors.white,
                                                  fontSize: Dimensions.font16),
                                            ),
                                            Text(AppLocale.today.getString(context),
                                              style: TextStyle(
                                                  color: darkThemeBoolean == "false"
                                                      ? AppColors.appBarTitleColor
                                                      : Colors.white,
                                                  fontSize: Dimensions.font12),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(AppLocale.today.getString(context),
                                              style: TextStyle(
                                                  color: darkThemeBoolean == "false"
                                                      ? AppColors.appBarTitleColor
                                                      : Colors.white,
                                                  fontSize: Dimensions.font12),
                                            ),
                                            Text(
                                              state.todayExpenses.seRagham(),
                                              style: TextStyle(
                                                  color: darkThemeBoolean == "false"
                                                      ? AppColors.appBarTitleColor
                                                      : Colors.white,
                                                  fontSize: Dimensions.font14),
                                            ),
                                          ],
                                        ),
                                  SizedBox(
                                    height: Dimensions.height20,
                                  ),
                                  ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      allTodayExpenses +=
                                          state.expenses[index].tomanExpense!;
                                      BlocProvider.of<AddExpenseBloc>(context)
                                          .add(AddTodayExpensesEvent(
                                              todayExpenses: allTodayExpenses));

                                      return Padding(
                                        padding: EdgeInsets.only(
                                            bottom: Dimensions.height20),
                                        child: Column(
                                          children: [
                                            Divider(
                                              thickness: 0.5,
                                              color: darkThemeBoolean == "false"
                                                  ? AppColors.iconUnSelectedBackGroundMainColor
                                                  : Colors.white,
                                            ),
                                            persianLanguageBoolean == true
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                          "-${state.expenses[index].tomanExpense!.toString().toPersianDigit().seRagham()}",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  Dimensions.font17,
                                                              color: darkThemeBoolean ==
                                                                      "false"
                                                                  ? AppColors.expensesDigitColor
                                                                  : Colors.white)),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Text(
                                                                  state.expenses[index].expenseCategory!.getString(context),
                                                                  style: TextStyle(
                                                                      fontSize: Dimensions.font17,
                                                                      fontWeight: FontWeight.w400,
                                                                      color: darkThemeBoolean == "false"
                                                                          ? AppColors.mainPageFirstContainerFontColor
                                                                          : Colors.white)),
                                                              Text(
                                                                  state.expenses[index].description!,
                                                                  style: TextStyle(
                                                                      fontSize: Dimensions.font16,
                                                                      fontWeight: FontWeight.w400,
                                                                      color: darkThemeBoolean == "false"
                                                                          ? AppColors.appBarProfileName
                                                                          : Colors.white)),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width: Dimensions.width10,
                                                          ),
                                                          Container(
                                                            width: Dimensions.width45,
                                                            height: Dimensions.width45,
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape.circle,
                                                                color: AppColors.colorList[
                                                                    index]),
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .all(Dimensions.width10 /
                                                                      1.4),
                                                              child: SvgPicture
                                                                  .asset(state.expenses[index].iconType!),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                : Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          Container(
                                                            width: Dimensions.width45,
                                                            height: Dimensions.width45,
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape.circle,
                                                                color: AppColors.colorList[
                                                                    index]),
                                                            child: Container(
                                                              margin: EdgeInsets.all(Dimensions.width10 / 1.4),
                                                              child: SvgPicture.asset(state.expenses[index].iconType!),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: Dimensions.width10,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(state.expenses[index].expenseCategory!.getString(context),
                                                                  style: TextStyle(
                                                                      fontSize: Dimensions.font14,
                                                                      fontWeight: FontWeight.w700,
                                                                      color: darkThemeBoolean == "false"
                                                                          ? AppColors.mainPageFirstContainerFontColor
                                                                          : Colors.white)),
                                                              Text(
                                                                  state.expenses[index].description!,
                                                                  style: TextStyle(
                                                                      fontSize: Dimensions.font12,
                                                                      fontWeight: FontWeight.w400,
                                                                      color: darkThemeBoolean == "false"
                                                                          ? AppColors.appBarProfileName
                                                                          : Colors.white)),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                          "-${state.expenses[index].tomanExpense!.toString().seRagham()}",
                                                          style: TextStyle(
                                                              fontSize: Dimensions.font14,
                                                              color: AppColors.expensesDigitColor)),
                                                    ],
                                                  ),
                                          ],
                                        ),
                                      );
                                    },
                                    itemCount: state.expenses.length,
                                  ),
                                ],
                              )
                            : Center(
                                child: Text(
                                  AppLocale.notExpenses.getString(context),
                                  style: TextStyle(
                                    fontSize: Dimensions.font20,
                                    color: darkThemeBoolean == "false"
                                        ? AppColors.calenderBoxIconColor
                                        : Colors.white,
                                  ),
                                ),
                              )
                        : state.status.isError
                            ? Center(
                                child: Text(
                                    style: TextStyle(
                                      fontSize: Dimensions.font20,
                                      color: darkThemeBoolean == "false"
                                          ? AppColors.calenderBoxIconColor
                                          : Colors.white,
                                    ),
                                    AppLocale.notExpenses.getString(context)),
                              )
                            : Container();
              }),
            );
          }));
    });
  }
}
