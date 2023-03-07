import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/event.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/state.dart';
import 'package:income_and_expenses/const/app_colors.dart';
import 'package:income_and_expenses/const/dimensions.dart';
import 'package:intl/intl.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../bloc/them_bloc/bloc.dart';
import '../bloc/them_bloc/state.dart';



class DatePickerCalendar extends StatefulWidget {
  const DatePickerCalendar({Key? key}) : super(key: key);

  @override
  State<DatePickerCalendar> createState() => DatePickerCalendarState();
}

class DatePickerCalendarState extends State<DatePickerCalendar> {

  String label = '';
  Jalali picked = Jalali.now() ;
  String selectedDate = "";

  String month = "${Jalali.now().year}-${Jalali.now().month}";
  String date = Jalali.now().day < 10
      ? "${Jalali.now().year}-${Jalali.now().month}-0${Jalali.now().day}"
      : "${Jalali.now().year}-${Jalali.now().month}-${Jalali.now().day}";

  @override
  void initState() {

    selectedDate = DateFormat('yyyy-MM').format(DateTime.parse(Jalali.now().toJalaliDateTime()));

    BlocProvider.of<SetDateBloc>(context).add(FetchIncomeEvent(month: selectedDate));

    BlocProvider.of<SetDateBloc>(context).add(SumExpensePerMonthEvent(dateMonth: selectedDate));

    BlocProvider.of<SetDateBloc>(context).add(CalculateCashPerMonthEvent(dateMonth: selectedDate));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<SetDateBloc, SetDateState>(builder: (context, state) {

      return Container(
        margin: EdgeInsets.only(
            left: Dimensions.width10,
            right: Dimensions.width10
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                date = "${DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.parse(date)))
                    .add(const Duration(days: -1))}";
                BlocProvider.of<SetDateBloc>(context)
                    .add(ReduceDateEvent(date: DateFormat('yyyy-MM-dd')
                    .format(DateTime.parse(date)).toString()));
                BlocProvider.of<SetDateBloc>(context)
                    .add(ReadDateEvent());
                BlocProvider.of<SetDateBloc>(context)
                    .add(ReadDateMonthEvent());
                BlocProvider.of<SetDateBloc>(context)
                    .add(FetchIncomeEvent(month : DateFormat('yyyy-MM')
                    .format(DateTime.parse(date)).toString()));
                BlocProvider.of<SetDateBloc>(context)
                    .add(SumExpensePerMonthEvent(dateMonth : DateFormat('yyyy-MM')
                    .format(DateTime.parse(date)).toString()));
                BlocProvider.of<SetDateBloc>(context)
                    .add(CalculateCashPerMonthEvent(dateMonth : DateFormat('yyyy-MM')
                    .format(DateTime.parse(date)).toString()));
                BlocProvider.of<SetDateBloc>(context)
                    .add(FetchExpensesEvent(date: DateFormat('yyyy-MM-dd')
                    .format(DateTime.parse(date)).toString()));

              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.arrowIconColor,
              ),
            ),
            GestureDetector(

              onTap:() async{
                picked = (await showPersianDatePicker(
                  context: context,
                  initialDate: Jalali.now(),
                  firstDate: Jalali(1385, 8),
                  lastDate: Jalali(1450, 9),

                ))!;
                if (picked != null && picked != selectedDate) {
                  setState(() {
                    label = picked.toJalaliDateTime();
                  });
                }

                if (!mounted) return;

                // setState(() {
                //   month = "${picked.year}-${picked.month}";
                //   date = picked.day.toString().length != 1
                //       ? "${picked.year}-${picked.month}-${picked.day}"
                //       : "${picked.year}-${picked.month}-0${picked.day}"
                //   ;
                // });

                if(picked.month.toString().length != 1){
                  if(picked.day.toString().length != 1){
                    month = "${picked.year}-${picked.month}";
                    date = "${picked.year}-${picked.month}-${picked.day}";
                  }else{
                    month = "${picked.year}-${picked.month}";
                    date = "${picked.year}-${picked.month}-0${picked.day}";
                  }
                }else{
                  if(picked.day.toString().length != 1){
                    month = "${picked.year}-0${picked.month}";
                    date = "${picked.year}-0${picked.month}-${picked.day}";
                  }else{
                    month = "${picked.year}-0${picked.month}";
                    date = "${picked.year}-0${picked.month}-0${picked.day}";
                  }
                }

                print("date                  "+date);
                print("month                  "+month);

                BlocProvider.of<SetDateBloc>(context)
                    .add(WriteDateEvent(date: date, dateMonth: month));
                BlocProvider.of<SetDateBloc>(context)
                    .add(ReadDateEvent());
                BlocProvider.of<SetDateBloc>(context)
                    .add(ReadDateMonthEvent());
                BlocProvider.of<SetDateBloc>(context)
                    .add(FetchIncomeEvent(month : month));
                BlocProvider.of<SetDateBloc>(context)
                    .add(SumExpensePerMonthEvent(dateMonth : month));
                BlocProvider.of<SetDateBloc>(context)
                    .add(CalculateCashPerMonthEvent(dateMonth : month));
                BlocProvider.of<SetDateBloc>(context)
                    .add(FetchExpensesEvent(date : date));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.calenderBoxColor,
                    borderRadius: BorderRadius.circular(Dimensions.radius20)),
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
                        Text(DateFormat('yyyy-MM-dd').format(DateTime.parse(date)),
                            style: const TextStyle(
                                color: AppColors.appBarTitleColor)),
                      ],
                    )),
              ),
            ),
            GestureDetector(
              onTap: () {
                date = "${DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.parse(date))).add(const Duration(days: 1))}";
                BlocProvider.of<SetDateBloc>(context)
                    .add(AddToDateEvent(date: DateFormat('yyyy-MM-dd').format(DateTime.parse(date)).toString()));
                BlocProvider.of<SetDateBloc>(context)
                    .add(ReadDateEvent());
                BlocProvider.of<SetDateBloc>(context)
                    .add(ReadDateMonthEvent());
                BlocProvider.of<SetDateBloc>(context)
                    .add(FetchIncomeEvent(month : DateFormat('yyyy-MM').format(DateTime.parse(date)).toString()));
                BlocProvider.of<SetDateBloc>(context)
                    .add(SumExpensePerMonthEvent(dateMonth : DateFormat('yyyy-MM').format(DateTime.parse(date)).toString()));
                BlocProvider.of<SetDateBloc>(context)
                    .add(CalculateCashPerMonthEvent(dateMonth : DateFormat('yyyy-MM').format(DateTime.parse(date)).toString()));
                BlocProvider.of<SetDateBloc>(context)
                    .add(FetchExpensesEvent(date: DateFormat('yyyy-MM-dd').format(DateTime.parse(date)).toString()));
              },
              child: const Icon(
                Icons.arrow_forward_ios,
                color: AppColors.arrowIconColor,
              ),
            ),
          ],
        ),
      );});
  }
}