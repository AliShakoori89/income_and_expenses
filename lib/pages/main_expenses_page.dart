import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:income_and_expenses/bloc/expense_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/expense_bloc/event.dart';
import 'package:income_and_expenses/bloc/expense_bloc/state.dart';
import 'package:income_and_expenses/utils/app_colors.dart';
import 'package:income_and_expenses/utils/cashContainer.dart';
import 'package:income_and_expenses/utils/date_picker_calendar.dart';
import 'package:income_and_expenses/utils/dimensions.dart';
import 'package:income_and_expenses/utils/main_expenses_page_header.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class MainExpensesPage extends StatefulWidget {
  const MainExpensesPage({Key? key}) : super(key: key);

  @override
  State<MainExpensesPage> createState() => _MainExpensesPageState();
}

class _MainExpensesPageState extends State<MainExpensesPage> {

  @override
  void initState() {

    final expensesBloc = BlocProvider.of<ExpenseBloc>(context);
    expensesBloc.add(FetchExpensesEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(
            left: Dimensions.width25,
            right: Dimensions.width25,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: Dimensions.height10,
                ),
                const MainExpensesPageHeader(),
                SizedBox(
                  height: Dimensions.height20,
                ),
                DatePickerCalendar(),
                SizedBox(
                  height: Dimensions.height20,
                ),
                Column(
                  children: [
                    CashContainer(),
                    SizedBox(
                      height: Dimensions.width20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.backGroundColor,
                          border: Border.all(
                              color: AppColors.mainPageCardBorderColor),
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius8)),
                      child: Container(
                        margin: EdgeInsets.only(
                            top: Dimensions.height15,
                            bottom: Dimensions.height15,
                            right: Dimensions.width15,
                            left: Dimensions.width15),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "-1125".toPersianDigit(),
                                  style: TextStyle(
                                      color: AppColors.appBarTitleColor,
                                      fontSize: Dimensions.font12),
                                ),
                                Text(
                                  "امروز",
                                  style: TextStyle(
                                      color: AppColors.appBarTitleColor,
                                      fontSize: Dimensions.font12),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Dimensions.height20,
                            ),
                            BlocBuilder<ExpenseBloc, ExpenseState>(builder: (context, state) {
                            return state.status.isLoading
                                  ? const Center(child: CircularProgressIndicator())
                                  : state.status.isSuccess
                                      ? state.expenses.isNotEmpty
                                          ? ListView.builder(
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                    bottom: Dimensions.height20
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          "-${state.expenses[index].expense!.toPersianDigit()}",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  Dimensions.font17,
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
                                                              Text(
                                                                  state
                                                                      .expenses[
                                                                          index]
                                                                      .expenseCategory!,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          Dimensions
                                                                              .font17,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: AppColors
                                                                          .mainPageFirstContainerFontColor))
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width:
                                                                Dimensions.width10,
                                                          ),
                                                          Container(
                                                            width:
                                                                Dimensions.width45,
                                                            height:
                                                                Dimensions.width45,
                                                            decoration: BoxDecoration(
                                                                shape:
                                                                    BoxShape.circle,
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
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                              itemCount: state.expenses.length,
                                            )
                                          : Center(
                                              child: Text(
                                                "! اطلاعاتی برای نمایش وجود ندارد",
                                                style: TextStyle(
                                                  fontSize: Dimensions.font20,
                                                  color: Color.fromRGBO(
                                                      117, 117, 117, 1.00),
                                                ),
                                              ),
                                            )
                                      : state.status.isError
                                          ? const Center(
                                              child: Text('Error'),
                                            )
                                          : Container();
                            }),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
