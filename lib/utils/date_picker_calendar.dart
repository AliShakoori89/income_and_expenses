import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/bloc/set_date/bloc.dart';
import 'package:income_and_expenses/bloc/set_date/event.dart';
import 'package:income_and_expenses/bloc/set_date/state.dart';
import 'package:income_and_expenses/utils/dimensions.dart';
import 'package:persian_datetimepickers/persian_datetimepickers.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  Widget build(BuildContext context) {


    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: (){
            convertDateTimeWithPlus(now);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Color.fromRGBO(0, 0, 0, 0.54),
          ),
        ),
        GestureDetector(
          onTap: () async {
            final DateTime? date = await showPersianDatePicker(
              context: context,
            );
            setState(() {
              _pickedDate = date;
            });
          },
          child: Container(
            decoration: BoxDecoration(
                color: Color.fromRGBO(245, 245, 245, 1.00),
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
                    color: Color.fromRGBO(117, 117, 117, 1.00),
                  ),
                  SizedBox(
                    width: Dimensions.height10,
                  ),
                  Text(_pickedDate != null
                      ? convertDateTime(_pickedDate!)
                      : convertDateTime(now),
                      style:
                      TextStyle(color: Color.fromRGBO(66, 66, 66, 1.00))),
                ],
              ),
            ),
          ),
        ),
        Icon(
          Icons.arrow_forward_ios,
          color: Color.fromRGBO(0, 0, 0, 0.54),
        ),
      ],
    );
  }


  String convertDateTime(DateTime dateTime){
  Gregorian g = Gregorian(dateTime.year, dateTime.month, dateTime.day);
    Jalali g2j1 = g.toJalali();
    print(g2j1.formatter.y + "/"+ g2j1.formatter.m+ "/"+g2j1.formatter.d);
    String date = g2j1.formatter.y + "/"+ g2j1.formatter.m+ "/"+g2j1.formatter.d;
  final Datedate = BlocProvider.of<SetDateBloc>(context);
    Datedate.add(WriteDateEvent(
      date: date
      ));
    Datedate.add(ReadDateEvent());
    return date;
  }

  String convertDateTimeWithPlus(DateTime now){

    Gregorian g = Gregorian(now.year, now.month-counter++, now.day);
    Jalali g2j1 = g.toJalali();
    print(g2j1.formatter.y + "/"+ g2j1.formatter.m+ "/"+g2j1.formatter.d);
    String date = g2j1.formatter.y + "/"+ g2j1.formatter.m+ "/"+g2j1.formatter.d;
    return date;
  }
}
