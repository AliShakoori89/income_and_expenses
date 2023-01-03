import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/bloc/expense_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/expense_bloc/event.dart';
import 'package:income_and_expenses/bloc/expense_bloc/state.dart';
import 'package:income_and_expenses/utils/app_colors.dart';
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

    final medicineBloc = BlocProvider.of<ExpenseBloc>(context);
    medicineBloc.add(FetchExpensesEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(
            left: Dimensions.width25,
            right: Dimensions.width25,
          ),
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
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColors.mainPageCardBorderColor),
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius8)),
                    child: Container(
                      margin: EdgeInsets.only(
                          left: Dimensions.width30, right: Dimensions.width30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                  "assets/main_page_first_container_logo/expenses.png"),
                              Text("-12،000".toPersianDigit(),
                                  style: TextStyle(
                                      color: AppColors.expensesDigitColor,
                                      fontSize: Dimensions.font18)),
                              Text("هزینه شده",
                                  style: TextStyle(
                                      color: AppColors
                                          .mainPageFirstContainerFontColor,
                                      fontSize: Dimensions.font16,
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                  "assets/main_page_first_container_logo/balance.png"),
                              Text("48,000".toPersianDigit(),
                                  style: TextStyle(
                                      color: AppColors.balanceDigitColor,
                                      fontSize: Dimensions.font18)),
                              Text("موجودی",
                                  style: TextStyle(
                                      color: AppColors
                                          .mainPageFirstContainerFontColor,
                                      fontSize: Dimensions.font16,
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                  "assets/main_page_first_container_logo/income.png"),
                              Text("70,000".toPersianDigit(),
                                  style: TextStyle(
                                      color: AppColors.appBarProfileName,
                                      fontSize: Dimensions.font18)),
                              Text("ورودی",
                                  style: TextStyle(
                                      color: AppColors
                                          .mainPageFirstContainerFontColor,
                                      fontSize: Dimensions.font16,
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
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
                            ? Center(child: CircularProgressIndicator())
                              : state.status.isSuccess
                              ? state.expenses.isNotEmpty
                              ? ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Text(state.expenses[index].description.toString(),
                                  style: TextStyle(color: Colors.black),)

                                ],
                              );
                            },
                            itemCount: state.expenses.length,)
                              : Center(
                            child: Text("! اطلاعاتی برای نمایش وجود ندارد",
                              style: TextStyle(
                                fontSize: Dimensions.font20,
                                color: Color.fromRGBO(117, 117, 117, 1.00),),),
                          )
                              : state.status.isError
                              ? const Center(
                            child: Text('Error'),)
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
    );
  }
}
