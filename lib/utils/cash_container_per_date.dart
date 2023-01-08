import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:income_and_expenses/bloc/add_expense_bloc/bloc.dart';
import 'package:income_and_expenses/utils/app_colors.dart';
import 'package:income_and_expenses/utils/dimensions.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../bloc/add_expense_bloc/event.dart';
import '../bloc/add_expense_bloc/state.dart';

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
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
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
            BlocBuilder<AddExpenseBloc, AddExpenseState>(builder: (context, state) {
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
                            "-${state.expenses[index].expense!.toString().toPersianDigit()}",
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
                child: Text("! اطلاعاتی برای نمایش وجود ندارد"),
              )
                  : Container();
            }),
          ],
        ),
      ),
    );
  }
}
