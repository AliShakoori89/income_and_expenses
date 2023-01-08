import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/bloc/add_expense_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/add_expense_bloc/event.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/event.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/state.dart';
import 'package:income_and_expenses/utils/app_colors.dart';
import 'package:income_and_expenses/utils/dimensions.dart';
import 'package:intl/intl.dart';
import 'package:persian_datetimepickers/persian_datetimepickers.dart';


class DatePickerCalendar extends StatefulWidget {
  DatePickerCalendar({Key? key}) : super(key: key);

  @override
  State<DatePickerCalendar> createState() => DatePickerCalendarState();
}

class DatePickerCalendarState extends State<DatePickerCalendar> {

  DateTime? _pickedDate;
  var counter = 1 ;
  DateTime now = DateTime.now();

  @override
  void initState() {

    BlocProvider.of<SetDateBloc>(context)
        .add(ReadDateEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<SetDateBloc, SetDateState>(builder: (context, state) {
      return Container(
        margin: EdgeInsets.only(
          left: Dimensions.width32 - Dimensions.width25,
          right: Dimensions.width32 - Dimensions.width25
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                if(_pickedDate != null){
                  BlocProvider.of<SetDateBloc>(context)
                      .add(ReduceDate(date: _pickedDate!));
                }else{
                  String dateWithT = state.date;
                  DateTime start = DateFormat("yyyy-MM-dd").parse(dateWithT);
                  BlocProvider.of<SetDateBloc>(context)
                      .add(ReduceDate(date: start));
                  BlocProvider.of<SetDateBloc>(context)
                      .add(ReadDateEvent());
                  final expensesBloc = BlocProvider.of<AddExpenseBloc>(context);
                  expensesBloc.add(FetchExpensesEvent());
                }
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.arrowIconColor,
              ),
            ),
            GestureDetector(
              onTap: () async {
                final DateTime? date = await showPersianDatePicker(
                  context: context,
                );
                setState(() {
                  _pickedDate = date;
                  BlocProvider.of<SetDateBloc>(context)
                      .add(WriteDateEvent(date: _pickedDate!));
                  BlocProvider.of<SetDateBloc>(context)
                      .add(ReadDateEvent());
                  final expensesBloc = BlocProvider.of<AddExpenseBloc>(context);
                  expensesBloc.add(FetchExpensesEvent());
                });
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
                if(_pickedDate != null){
                  BlocProvider.of<SetDateBloc>(context)
                      .add(AddToDate(date: _pickedDate!));
                }else{
                  String dateWithT = state.date;
                  DateTime start = DateFormat("yyyy-MM-dd").parse(dateWithT);
                  BlocProvider.of<SetDateBloc>(context)
                      .add(AddToDate(date: start));
                  BlocProvider.of<SetDateBloc>(context)
                      .add(ReadDateEvent());
                  final expensesBloc = BlocProvider.of<AddExpenseBloc>(context);
                  expensesBloc.add(FetchExpensesEvent());
                }
              },
              child: const Icon(
                Icons.arrow_forward_ios,
                color: AppColors.arrowIconColor,
              ),
            ),
          ],
        ),
      );

    });
  }
}
