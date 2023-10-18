import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/logic/bloc/set_date_bloc/bloc.dart';
import 'package:income_and_expenses/logic/bloc/set_date_bloc/event.dart';
import 'package:income_and_expenses/logic/bloc/set_date_bloc/state.dart';
import 'package:income_and_expenses/presentation/const/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class DatePickerCalendar extends StatefulWidget {

  GlobalKey? keyBottomNavigation2;
  GlobalKey? keyBottomNavigation3;
  GlobalKey? keyBottomNavigation4;

  DatePickerCalendar({super.key, this.keyBottomNavigation2,
    this.keyBottomNavigation3, this.keyBottomNavigation4});

  @override
  State<DatePickerCalendar> createState() => DatePickerCalendarState(
    keyBottomNavigation2, keyBottomNavigation3, keyBottomNavigation4
  );
}

class DatePickerCalendarState extends State<DatePickerCalendar> {

  GlobalKey? keyBottomNavigation2;
  GlobalKey? keyBottomNavigation3;
  GlobalKey? keyBottomNavigation4;

  DatePickerCalendarState(this.keyBottomNavigation2, this.keyBottomNavigation3, this.keyBottomNavigation4);

  String label = '';
  Jalali picked = Jalali.now() ;
  String selectedDate = "";

  String month = "${Jalali.now().year}-${Jalali.now().month}";
  String date = Jalali.now().day < 10 && Jalali.now().month < 10
      ? "${Jalali.now().year}-0${Jalali.now().month}-0${Jalali.now().day}"
      : Jalali.now().month < 10
      ? "${Jalali.now().year}-0${Jalali.now().month}-${Jalali.now().day}"
      : "${Jalali.now().year}-${Jalali.now().month}-0${Jalali.now().day}";

  @override
  void initState() {

    selectedDate = DateFormat('yyyy-MM').format(DateTime.parse(Jalali.now().toJalaliDateTime()));

    BlocProvider.of<SetDateBloc>(context).add(FetchIncomeEvent(month: selectedDate));

    BlocProvider.of<SetDateBloc>(context).add(SumExpensePerMonthEvent(month: selectedDate));

    BlocProvider.of<SetDateBloc>(context).add(CalculateCashPerMonthEvent(month: selectedDate));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<SetDateBloc, SetDateState>(builder: (context, state) {

      return AppLocalizations.of(context)!.language == "زبان"
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      date =
                      "${DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.parse(date))).add(const Duration(days: 1))}";

                      BlocProvider.of<SetDateBloc>(context)
                          .add(WriteDateEvent(date: date, month: month));
                      BlocProvider.of<SetDateBloc>(context).add(AddToDateEvent(
                          date: DateFormat('yyyy-MM-dd')
                              .format(DateTime.parse(date))
                              .toString(),
                          month: DateFormat('yyyy-MM')
                              .format(DateTime.parse(date))
                              .toString()));
                      BlocProvider.of<SetDateBloc>(context)
                          .add(ReadDateEvent());
                      BlocProvider.of<SetDateBloc>(context)
                          .add(ReadMonthEvent());
                      BlocProvider.of<SetDateBloc>(context).add(
                          SumExpensePerMonthEvent(
                              month: DateFormat('yyyy-MM')
                                  .format(DateTime.parse(date))
                                  .toString()));
                      BlocProvider.of<SetDateBloc>(context).add(
                          CalculateCashPerMonthEvent(
                              month: DateFormat('yyyy-MM')
                                  .format(DateTime.parse(date))
                                  .toString()));
                      BlocProvider.of<SetDateBloc>(context).add(
                          FetchExpensesItemsEvent(
                              date: DateFormat('yyyy-MM-dd')
                                  .format(DateTime.parse(date))
                                  .toString()));
                      BlocProvider.of<SetDateBloc>(context).add(
                          FetchIncomeEvent(
                              month: DateFormat('yyyy-MM')
                                  .format(DateTime.parse(date))
                                  .toString()));
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 20,
                      height: MediaQuery.of(context).size.width / 20,
                      child: Image.asset(
                        key: keyBottomNavigation4,
                        "assets/main_page_first_container_logo/right_arrow.png",
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: GestureDetector(
                    onTap: () async {
                      picked = (await showPersianDatePicker(
                        context: context,
                        initialDate: Jalali.now(),
                        firstDate: Jalali(1385, 8),
                        lastDate: Jalali(1450, 9),
                        builder: (context, child) {
                          return child!;
                        },
                      ))!;
                      if (picked != selectedDate) {
                        setState(() {
                          label = picked.toJalaliDateTime();
                        });
                      }

                      if (!mounted) return;

                      if (picked.month.toString().length != 1) {
                        if (picked.day.toString().length != 1) {
                          month = "${picked.year}-${picked.month}";
                          date = "${picked.year}-${picked.month}-${picked.day}";
                        } else {
                          month = "${picked.year}-${picked.month}";
                          date =
                              "${picked.year}-${picked.month}-0${picked.day}";
                        }
                      } else {
                        if (picked.day.toString().length != 1) {
                          month = "${picked.year}-0${picked.month}";
                          date =
                              "${picked.year}-0${picked.month}-${picked.day}";
                        } else {
                          month = "${picked.year}-0${picked.month}";
                          date =
                              "${picked.year}-0${picked.month}-0${picked.day}";
                        }
                      }

                      BlocProvider.of<SetDateBloc>(context)
                          .add(WriteDateEvent(date: date, month: month));
                      BlocProvider.of<SetDateBloc>(context)
                          .add(ReadDateEvent());
                      BlocProvider.of<SetDateBloc>(context)
                          .add(ReadMonthEvent());
                      BlocProvider.of<SetDateBloc>(context)
                          .add(SumExpensePerMonthEvent(month: month));
                      BlocProvider.of<SetDateBloc>(context)
                          .add(CalculateCashPerMonthEvent(month: month));
                      BlocProvider.of<SetDateBloc>(context)
                          .add(FetchExpensesItemsEvent(date: date));
                      BlocProvider.of<SetDateBloc>(context)
                          .add(FetchIncomeEvent(month: month));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.width / 10,
                      margin: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width / 10,
                        left: MediaQuery.of(context).size.width / 10,
                      ),
                      // key: keyButton2,
                      decoration: BoxDecoration(
                          color: AppColors.calenderBoxColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: MediaQuery.of(context).size.width / 20,
                            color: AppColors.calenderBoxIconColor,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 20,
                          ),
                          Text(
                              key: keyBottomNavigation3,
                              DateFormat('yyyy-MM-dd')
                                  .format(DateTime.parse(date))
                                  .toPersianDigit(),
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width / 20,
                                  color: AppColors.appBarTitleColor)),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      date =
                      "${DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.parse(date))).add(const Duration(days: -1))}";

                      BlocProvider.of<SetDateBloc>(context)
                          .add(WriteDateEvent(date: date, month: month));
                      BlocProvider.of<SetDateBloc>(context).add(AddToDateEvent(
                          date: DateFormat('yyyy-MM-dd')
                              .format(DateTime.parse(date))
                              .toString(),
                          month: DateFormat('yyyy-MM')
                              .format(DateTime.parse(date))
                              .toString()));
                      BlocProvider.of<SetDateBloc>(context)
                          .add(ReadDateEvent());
                      BlocProvider.of<SetDateBloc>(context)
                          .add(ReadMonthEvent());
                      BlocProvider.of<SetDateBloc>(context).add(
                          SumExpensePerMonthEvent(
                              month: DateFormat('yyyy-MM')
                                  .format(DateTime.parse(date))
                                  .toString()));
                      BlocProvider.of<SetDateBloc>(context).add(
                          CalculateCashPerMonthEvent(
                              month: DateFormat('yyyy-MM')
                                  .format(DateTime.parse(date))
                                  .toString()));
                      BlocProvider.of<SetDateBloc>(context).add(
                          FetchExpensesItemsEvent(
                              date: DateFormat('yyyy-MM-dd')
                                  .format(DateTime.parse(date))
                                  .toString()));
                      BlocProvider.of<SetDateBloc>(context).add(
                          FetchIncomeEvent(
                              month: DateFormat('yyyy-MM')
                                  .format(DateTime.parse(date))
                                  .toString()));
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 20,
                      height: MediaQuery.of(context).size.width / 20,
                      child: Image.asset(
                          key: keyBottomNavigation2,
                          // key: keyButton1,
                          "assets/main_page_first_container_logo/left_arrow.png"),
                    ),
                  ),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      date =
                      "${DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.parse(date))).add(const Duration(days: -1))}";

                      BlocProvider.of<SetDateBloc>(context)
                          .add(WriteDateEvent(date: date, month: month));
                      BlocProvider.of<SetDateBloc>(context).add(AddToDateEvent(
                          date: DateFormat('yyyy-MM-dd')
                              .format(DateTime.parse(date))
                              .toString(),
                          month: DateFormat('yyyy-MM')
                              .format(DateTime.parse(date))
                              .toString()));
                      BlocProvider.of<SetDateBloc>(context)
                          .add(ReadDateEvent());
                      BlocProvider.of<SetDateBloc>(context)
                          .add(ReadMonthEvent());
                      BlocProvider.of<SetDateBloc>(context).add(
                          SumExpensePerMonthEvent(
                              month: DateFormat('yyyy-MM')
                                  .format(DateTime.parse(date))
                                  .toString()));
                      BlocProvider.of<SetDateBloc>(context).add(
                          CalculateCashPerMonthEvent(
                              month: DateFormat('yyyy-MM')
                                  .format(DateTime.parse(date))
                                  .toString()));
                      BlocProvider.of<SetDateBloc>(context).add(
                          FetchExpensesItemsEvent(
                              date: DateFormat('yyyy-MM-dd')
                                  .format(DateTime.parse(date))
                                  .toString()));
                      BlocProvider.of<SetDateBloc>(context).add(
                          FetchIncomeEvent(
                              month: DateFormat('yyyy-MM')
                                  .format(DateTime.parse(date))
                                  .toString()));
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 20,
                      height: MediaQuery.of(context).size.width / 20,
                      child: Image.asset(
                          key: keyBottomNavigation2,
                          // key: keyButton1,
                          "assets/main_page_first_container_logo/left_arrow.png"),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: GestureDetector(
                    onTap: () async {
                      picked = (await showPersianDatePicker(
                        context: context,
                        initialDate: Jalali.now(),
                        firstDate: Jalali(1385, 8),
                        lastDate: Jalali(1450, 9),
                        builder: (context, child) {
                          return child!;
                        },
                      ))!;
                      if (picked != selectedDate) {
                        setState(() {
                          label = picked.toJalaliDateTime();
                        });
                      }

                      if (!mounted) return;

                      if (picked.month.toString().length != 1) {
                        if (picked.day.toString().length != 1) {
                          month = "${picked.year}-${picked.month}";
                          date = "${picked.year}-${picked.month}-${picked.day}";
                        } else {
                          month = "${picked.year}-${picked.month}";
                          date =
                              "${picked.year}-${picked.month}-0${picked.day}";
                        }
                      } else {
                        if (picked.day.toString().length != 1) {
                          month = "${picked.year}-0${picked.month}";
                          date =
                              "${picked.year}-0${picked.month}-${picked.day}";
                        } else {
                          month = "${picked.year}-0${picked.month}";
                          date =
                              "${picked.year}-0${picked.month}-0${picked.day}";
                        }
                      }

                      BlocProvider.of<SetDateBloc>(context)
                          .add(WriteDateEvent(date: date, month: month));
                      BlocProvider.of<SetDateBloc>(context)
                          .add(ReadDateEvent());
                      BlocProvider.of<SetDateBloc>(context)
                          .add(ReadMonthEvent());
                      BlocProvider.of<SetDateBloc>(context)
                          .add(SumExpensePerMonthEvent(month: month));
                      BlocProvider.of<SetDateBloc>(context)
                          .add(CalculateCashPerMonthEvent(month: month));
                      BlocProvider.of<SetDateBloc>(context)
                          .add(FetchExpensesItemsEvent(date: date));
                      BlocProvider.of<SetDateBloc>(context)
                          .add(FetchIncomeEvent(month: month));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.width / 10,
                      margin: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width / 10,
                        left: MediaQuery.of(context).size.width / 10,
                      ),
                      // key: keyButton2,
                      decoration: BoxDecoration(
                          color: AppColors.calenderBoxColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: MediaQuery.of(context).size.width / 20,
                            color: AppColors.calenderBoxIconColor,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 20,
                          ),
                          Text(
                              key: keyBottomNavigation3,
                              DateFormat('yyyy-MM-dd')
                                  .format(DateTime.parse(date))
                                  .toPersianDigit(),
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width / 20,
                                  color: AppColors.appBarTitleColor)),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      date =
                      "${DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.parse(date))).add(const Duration(days: 1))}";

                      BlocProvider.of<SetDateBloc>(context)
                          .add(WriteDateEvent(date: date, month: month));
                      BlocProvider.of<SetDateBloc>(context).add(AddToDateEvent(
                          date: DateFormat('yyyy-MM-dd')
                              .format(DateTime.parse(date))
                              .toString(),
                          month: DateFormat('yyyy-MM')
                              .format(DateTime.parse(date))
                              .toString()));
                      BlocProvider.of<SetDateBloc>(context)
                          .add(ReadDateEvent());
                      BlocProvider.of<SetDateBloc>(context)
                          .add(ReadMonthEvent());
                      BlocProvider.of<SetDateBloc>(context).add(
                          SumExpensePerMonthEvent(
                              month: DateFormat('yyyy-MM')
                                  .format(DateTime.parse(date))
                                  .toString()));
                      BlocProvider.of<SetDateBloc>(context).add(
                          CalculateCashPerMonthEvent(
                              month: DateFormat('yyyy-MM')
                                  .format(DateTime.parse(date))
                                  .toString()));
                      BlocProvider.of<SetDateBloc>(context).add(
                          FetchExpensesItemsEvent(
                              date: DateFormat('yyyy-MM-dd')
                                  .format(DateTime.parse(date))
                                  .toString()));
                      BlocProvider.of<SetDateBloc>(context).add(
                          FetchIncomeEvent(
                              month: DateFormat('yyyy-MM')
                                  .format(DateTime.parse(date))
                                  .toString()));
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 20,
                      height: MediaQuery.of(context).size.width / 20,
                      child: Image.asset(
                        key: keyBottomNavigation4,
                        "assets/main_page_first_container_logo/right_arrow.png",
                      ),
                    ),
                  ),
                ),
              ],
            );
    });
  }
}