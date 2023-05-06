import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/state.dart';
import 'package:income_and_expenses/const/app_colors.dart';
import 'package:income_and_expenses/const/dimensions.dart';
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
import '../pages/edit_page.dart';
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
                top: Dimensions.height15,
                bottom: Dimensions.height15,
                right: Dimensions.width15,
                left: Dimensions.width15),
            child: BlocBuilder<SetDateBloc, SetDateState>(
                builder: (context, state) {
              int allTodayExpenses = 0;

              return state.status.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : state.status.isSuccess
                      ? state.expensesDetails.isNotEmpty
                          ? Column(
                              children: [
                                englishLanguageBoolean == false
                                    ? Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(rialCurrencyType == true
                                              ? ("${state.expensesPerDate}0").toPersianDigit().seRagham()
                                              : state.expensesPerDate.toPersianDigit().seRagham(),
                                            style: TextStyle(
                                                color: darkThemeBoolean == "false"
                                                    ? AppColors.appBarTitleColor
                                                    : Colors.white,
                                                fontSize: Dimensions.font20),
                                          ),
                                          Text(
                                            AppLocale.allExpenses.getString(context),
                                            style: TextStyle(
                                                color: darkThemeBoolean == "false"
                                                    ? AppColors.appBarTitleColor
                                                    : Colors.white,
                                                fontSize: Dimensions.font16),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppLocale.allExpenses.getString(context),
                                            style: TextStyle(
                                                color: darkThemeBoolean == "false"
                                                    ? AppColors.appBarTitleColor
                                                    : Colors.white,
                                                fontSize: Dimensions.font16),
                                          ),
                                          Text(rialCurrencyType == true
                                              ? ("${state.expensesPerDate}0").seRagham()
                                              : state.expensesPerDate.seRagham(),
                                            style: TextStyle(
                                                color: darkThemeBoolean == "false"
                                                    ? AppColors.appBarTitleColor
                                                    : Colors.white,
                                                fontSize:
                                                    Dimensions.font20),
                                          ),
                                        ],
                                      ),
                                SizedBox(
                                  height: Dimensions.height20,
                                ),
                                SizedBox(
                                  height: Dimensions.height45*9,
                                  child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    padding: EdgeInsets.only(
                                      bottom: Dimensions.height30*3
                                    ),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      allTodayExpenses +=
                                          state.expensesDetails[index].expense!;
                                      BlocProvider.of<SetDateBloc>(context)
                                          .add(AddTodayExpensesEvent(
                                              todayExpensesDetails:
                                                  allTodayExpenses));

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
                                            GestureDetector(
                                              onTap: (){
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => EditedPage(expenseModel: state.expensesDetails[index])));
                                              },
                                              child: englishLanguageBoolean == false
                                                  ? Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text( rialCurrencyType == true
                                                            ? "-${("${state.expensesDetails[index].expense!}0").toPersianDigit().seRagham()}"
                                                            : "-${state.expensesDetails[index].expense!.toString().toPersianDigit().seRagham()}",
                                                            style: TextStyle(
                                                                fontSize: Dimensions.font26,
                                                                color: darkThemeBoolean == "false"
                                                                    ? AppColors.expensesDigitColor
                                                                    : Colors.white)),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment.end,
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment.end,
                                                              children: [
                                                                Text(state.expensesDetails[index].expenseCategory!.getString(context),
                                                                    style: TextStyle(
                                                                        fontSize: Dimensions.font20,
                                                                        fontWeight: FontWeight.w700,
                                                                        color: darkThemeBoolean == "false"
                                                                            ? AppColors.black
                                                                            : Colors.white)),
                                                                Text(state.expensesDetails[index].description!,
                                                                    style: TextStyle(
                                                                        fontSize: Dimensions.font20,
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
                                                              width: Dimensions.width30*2,
                                                              height: Dimensions.width30*2,
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape.circle,
                                                                  color: AppColors.colorList[index]),
                                                              child: Container(
                                                                margin: EdgeInsets.all(Dimensions.width10 / 1.4),
                                                                child: SvgPicture
                                                                    .asset(state.expensesDetails[index].iconType!),
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
                                                        Row(mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            Container(
                                                              width: Dimensions.width45,
                                                              height: Dimensions.width45,
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape.circle,
                                                                  color: AppColors.colorList[index]),
                                                              child: Container(
                                                                margin: EdgeInsets.all(Dimensions.width10 / 1.4),
                                                                child: SvgPicture.asset(state.expensesDetails[index].iconType!),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: Dimensions.width10,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment.start,
                                                              children: [
                                                                Text((state.expensesDetails[index].expenseCategory!).getString(context),
                                                                    style: TextStyle(
                                                                        fontSize: Dimensions.font20,
                                                                        fontWeight: FontWeight.w700,
                                                                        color: darkThemeBoolean == "false"
                                                                            ? AppColors.mainPageFirstContainerFontColor
                                                                            : Colors.white)),
                                                                Text(
                                                                    state.expensesDetails[index].description!,
                                                                    style: TextStyle(
                                                                        fontSize: Dimensions.font20,
                                                                        fontWeight: FontWeight.w400,
                                                                        color: darkThemeBoolean ==
                                                                                "false"
                                                                            ? AppColors.appBarProfileName
                                                                            : Colors.white)),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        Text(rialCurrencyType == true
                                                            ? "-${("${state.expensesDetails[index].expense!}0").seRagham()}"
                                                            : "-${state.expensesDetails[index].expense!.toString().seRagham()}",
                                                            style: TextStyle(
                                                                fontSize: Dimensions.font26,
                                                                color: AppColors.expensesDigitColor)),
                                                      ],
                                                    ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    itemCount: state.expensesDetails.length,
                                  ),
                                ),
                              ],
                            )
                          : const Center(
                              child: NoDataPage(),
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
        });
      });
    });
  }
}
