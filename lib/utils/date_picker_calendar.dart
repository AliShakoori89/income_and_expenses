import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_linear_datepicker/flutter_datepicker.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:income_and_expenses/bloc/add_expense_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/add_expense_bloc/event.dart';
import 'package:income_and_expenses/bloc/income_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/income_bloc/event.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/event.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/state.dart';
import 'package:income_and_expenses/const/app_colors.dart';
import 'package:income_and_expenses/const/dimensions.dart';
import 'package:intl/intl.dart';
import 'package:persian_datetimepickers/persian_datetimepickers.dart';
import '../bloc/calculate_expense_bloc/bloc.dart';
import '../bloc/calculate_expense_bloc/event.dart';
import '../bloc/them_bloc/bloc.dart';
import '../bloc/them_bloc/state.dart';
import '../routes/route_helper.dart';


class DatePickerCalendar extends StatefulWidget {
  const DatePickerCalendar({Key? key}) : super(key: key);

  @override
  State<DatePickerCalendar> createState() => DatePickerCalendarState();
}

class DatePickerCalendarState extends State<DatePickerCalendar> {

  final DateTime _pickedDate = DateTime.now();

  // @override
  // void initState() {
  //
  //   BlocProvider.of<SetDateBloc>(context).add(ReadDateEvent());
  //
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {

      var themeBoolean = state.darkThemeBoolean;

      return BlocBuilder<SetDateBloc, SetDateState>(builder: (context, state) {
        return Container(
          width: double.infinity,
          height: Dimensions.height30*1.5,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: themeBoolean == "true"
                  ? AppColors.mainPageCardBorderColor
                  : AppColors.darkThemeBorderColor),
              borderRadius: BorderRadius.circular(Dimensions.radius8)
          ),
          margin: EdgeInsets.only(
              left: Dimensions.width32 - Dimensions.width30,
              right: Dimensions.width32 - Dimensions.width30
          ),
          child: Container(
            margin: EdgeInsets.only(
                left: Dimensions.width10,
                right: Dimensions.width10
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    // if(_pickedDate != null){
                      String dateWithT = state.date;
                      DateTime start = DateFormat("yyyy-MM-dd").parse(dateWithT);
                      BlocProvider.of<SetDateBloc>(context)
                          .add(ReduceDateEvent(date: start.toString()));
                      BlocProvider.of<SetDateBloc>(context)
                          .add(ReadDateEvent());
                      final expensesBloc = BlocProvider.of<AddExpenseBloc>(context);
                      expensesBloc.add(FetchExpensesEvent(date: state.date));
                    // }else{
                    //   String dateWithT = state.date;
                    //   DateTime start = DateFormat("yyyy-MM-dd").parse(dateWithT);
                    //   BlocProvider.of<SetDateBloc>(context)
                    //       .add(ReduceDateEvent(date: start));
                    //   BlocProvider.of<SetDateBloc>(context)
                    //       .add(ReadDateEvent());
                    //   final expensesBloc = BlocProvider.of<AddExpenseBloc>(context);
                    //   expensesBloc.add(FetchExpensesEvent());
                    // }
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.arrowIconColor,
                  ),
                ),
                GestureDetector(
                  onTap:(){
                    // _pickedDate = DateTime.parse(state.date);
                    BlocProvider.of<SetDateBloc>(context)
                        .add(SelectDateEvent(context: context, selectDate: _pickedDate.toString()));

                    BlocProvider.of<SetDateBloc>(context)
                        .add(InitialDateEvent());

                    // _selectDate(context, date);
                    BlocProvider.of<SetDateBloc>(context)
                        .add(ReadDateEvent());
                    //
                    // BlocProvider.of<SetDateBloc>(context)
                    //     .add(WriteDateEvent(date: DateTime.parse(state.date)));
                    print("1111111     ${state.date}");
                    print("2222222     ${state.dateMonth}");
                    print("3333333     ${state.selectDate}");
                    print("4444444     ${_pickedDate}");

                    BlocProvider.of<CalculateExpenseBloc>(context)
                        .add(SumExpensePerMonthEvent(dateMonth : state.dateMonth));
                    BlocProvider.of<CalculateExpenseBloc>(context)
                        .add(CalculateCashPerMonthEvent(dateMonth : state.dateMonth.toString()));
                    BlocProvider.of<AddExpenseBloc>(context)
                        .add(FetchExpensesEvent(date : state.date));
                    // BlocProvider.of<IncomeBloc>(context)
                    //     .add(FetchIncomeEvent(month: state.dateMonth.toString()));
                    // BlocProvider.of<SetDateBloc>(context)
                    //     .add(ReadDateEvent());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.calenderBoxColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                        padding: EdgeInsets.only(
                            top: Dimensions.height10,
                            bottom: Dimensions.height10,
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: Dimensions.iconSize16,
                              color: AppColors.calenderBoxIconColor,
                            ),
                            SizedBox(
                              width: Dimensions.height10,
                            ),
                            Text(state.date,
                                style: const TextStyle(
                                    color: AppColors.appBarTitleColor)),
                          ],
                        )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // if(_pickedDate != null){
                      String dateWithT = state.date;
                      DateTime start = DateFormat("yyyy-MM-dd").parse(dateWithT);
                      BlocProvider.of<SetDateBloc>(context)
                          .add(AddToDateEvent(date: start.toString()));
                      BlocProvider.of<SetDateBloc>(context)
                          .add(ReadDateEvent());
                      BlocProvider.of<AddExpenseBloc>(context)
                          .add(FetchExpensesEvent(date: state.date));
                    // }else{
                    //   String dateWithT = state.date;
                    //   DateTime start = DateFormat("yyyy-MM-dd").parse(dateWithT);
                    //   BlocProvider.of<SetDateBloc>(context)
                    //       .add(AddToDateEvent(date: start));
                    //   BlocProvider.of<SetDateBloc>(context)
                    //       .add(ReadDateEvent());
                    //   BlocProvider.of<AddExpenseBloc>(context)
                    //   .add(FetchExpensesEvent());
                    // }
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.arrowIconColor,
                  ),
                ),
              ],
            ),
          ),
        );});});
  }
}
