import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:income_and_expenses/bloc/add_expense_bloc/bloc.dart';
import 'package:income_and_expenses/utils/app_colors.dart';
import 'package:income_and_expenses/utils/dimensions.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../bloc/add_expense_bloc/event.dart';
import '../bloc/add_expense_bloc/state.dart';
import '../bloc/change_language_bloc/bloc.dart';
import '../bloc/change_language_bloc/event.dart';
import '../bloc/change_language_bloc/state.dart';
import 'language.dart';

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

    BlocProvider.of<ChangeLanguageBloc>(context).add(ReadLanguageBooleanEvent());

    return Container(
        decoration: BoxDecoration(
            color: AppColors.backGroundColor,
            border: Border.all(color: AppColors.mainPageCardBorderColor),
            borderRadius: BorderRadius.circular(Dimensions.radius8)),
        child: BlocBuilder<ChangeLanguageBloc, ChangeLanguageState>(
            builder: (context, state) {
          bool lBool = state.readLanguageBoolean;

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
                                lBool == false
                                    ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(state.todayExpenses.toPersianDigit().seRagham(),
                                      style: TextStyle(
                                          color: AppColors.appBarTitleColor,
                                          fontSize: Dimensions.font16),
                                    ),
                                    Text(
                                      AppLocale.today.getString(context),
                                      style: TextStyle(
                                          color: AppColors.appBarTitleColor,
                                          fontSize: Dimensions.font12),
                                    ),
                                  ],
                                )
                                    : Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocale.today.getString(context),
                                      style: TextStyle(
                                          color: AppColors.appBarTitleColor,
                                          fontSize: Dimensions.font12),
                                    ),
                                    Text(state.todayExpenses.seRagham(),
                                      style: TextStyle(
                                          color: AppColors.appBarTitleColor,
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
                                        state.expenses[index].expense!;
                                    BlocProvider.of<AddExpenseBloc>(context)
                                        .add(AddTodayExpensesEvent(
                                            todayExpenses: allTodayExpenses));

                                    return Padding(
                                      padding: EdgeInsets.only(
                                          bottom: Dimensions.height20),
                                      child: Column(
                                        children: [
                                          const Divider(
                                            thickness: 0.5,
                                            color: AppColors
                                                .iconUnSelectedBackGroundMainColor,
                                          ),
                                          lBool == false
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                        "-${state.expenses[index].expense!.toString().toPersianDigit().seRagham()}",
                                                        style: TextStyle(
                                                            fontSize: Dimensions
                                                                .font17,
                                                            color: AppColors
                                                                .expensesDigitColor)),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                                state
                                                                    .expenses[
                                                                        index]
                                                                    .expenseCategory!
                                                                    .getString(
                                                                        context),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        Dimensions
                                                                            .font17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: AppColors
                                                                        .mainPageFirstContainerFontColor)),
                                                            Text(
                                                                state
                                                                    .expenses[
                                                                index]
                                                                    .description!,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                    Dimensions
                                                                        .font16,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                    color: AppColors
                                                                        .appBarProfileName)),
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
                                                              color: AppColors.colorList[index]),
                                                          child: Container(
                                                            margin: EdgeInsets.all(Dimensions.width10 / 1.4),
                                                            child: SvgPicture.asset(state.expenses[index].iconType!),
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
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                      children: [
                                                        Container(
                                                          width: Dimensions
                                                              .width45,
                                                          height: Dimensions
                                                              .width45,
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: AppColors
                                                                  .colorList[
                                                              index]),
                                                          child: Container(
                                                            margin: EdgeInsets
                                                                .all(Dimensions
                                                                .width10 /
                                                                1.4),
                                                            child: SvgPicture
                                                                .asset(state
                                                                .expenses[
                                                            index]
                                                                .iconType!),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: Dimensions.width10,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                                state.expenses[index].expenseCategory!.getString(context),
                                                                style: TextStyle(
                                                                    fontSize: Dimensions.font14,
                                                                    fontWeight: FontWeight.w700,
                                                                    color: AppColors.mainPageFirstContainerFontColor)),
                                                            Text(
                                                                state.expenses[index].description!,
                                                                style: TextStyle(
                                                                    fontSize: Dimensions.font12,
                                                                    fontWeight: FontWeight.w400,
                                                                    color: AppColors.appBarProfileName)),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                        "-${state.expenses[index].expense!.toString().seRagham()}",
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
                                  color: AppColors.calenderBoxIconColor,
                                ),
                              ),
                            )
                      : state.status.isError
                          ? Center(
                              child: Text(
                                  AppLocale.notExpenses.getString(context)),
                            )
                          : Container();
            }),
          );
        }));
  }
}
