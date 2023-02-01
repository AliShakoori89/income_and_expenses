import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_datetimepickers/persian_datetimepickers.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../const/app_colors.dart';

class SetDateRepository {

  writeDate(DateTime date) async{
    print(date.year);
    final prefs = await SharedPreferences.getInstance();
    if(date.year > 1900){
      Gregorian g = Gregorian(date.year, date.month, date.day);
      Jalali g2j1 = g.toJalali();
      String dateString = "${g2j1.formatter.y}-${g2j1.formatter.m}-${g2j1.formatter.d}";
      print("repositoryyyyyyyyyyyy   "+g2j1.formatter.y);
      String dateMonthString = "${g2j1.formatter.y}-${g2j1.formatter.m}";
      await prefs.setString('dateMonth', dateMonthString);
      await prefs.setString('date', dateString);
    }else{
    await prefs.setString('dateMonth', "${date.year}-${date.month}-${date.day}");
    await prefs.setString('date', "${date.year}-${date.month}-${date.day}");}
  }

  Future<String> readDateMonth() async{
    final prefs = await SharedPreferences.getInstance();
    DateTime now = DateTime.now();
    final String? date = prefs.getString('dateMonth');
    if(date == null){
      Gregorian g = Gregorian(now.year, now.month, now.day);
      Jalali g2j1 = g.toJalali();
      String dateMonthString = "${g2j1.formatter.y}-${g2j1.formatter.m}";
      return dateMonthString;
    }else{
      return date;
    }
  }

  Future<String> readDate() async{
    final prefs = await SharedPreferences.getInstance();
    DateTime now = DateTime.now();
    final String? date = prefs.getString('date');
    if(date == null){
      Gregorian g = Gregorian(now.year, now.month, now.day);
      Jalali g2j1 = g.toJalali();
      String dateString = "${g2j1.formatter.y}-${g2j1.formatter.m}-${g2j1.formatter.d}";
      return dateString;
    }else{
      return date;
    }
  }

  addToDate(DateTime date) async{
    final prefs = await SharedPreferences.getInstance();
    if(date.month <= 6){
      if(date.day == 31){
        Get.rawSnackbar(
            boxShadows: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(0, 1),
                blurRadius: 5,
                spreadRadius: 0,
              )
            ],
            snackPosition: SnackPosition.TOP,
            backgroundColor: AppColors.snackBarColor,
            messageText: const Text('برای تغییر ماه از طریق ضربه زدن بر روی تقویم اقدام نمایید.',
                textDirection: TextDirection.rtl),
            titleText: const Text('توجه',
                style: TextStyle(
                    fontWeight: FontWeight.w700
                ),
                textDirection: TextDirection.rtl));
      }else{
        Gregorian g = Gregorian(date.year, date.month, date.day+1);
        String datePlus = "${g.formatter.y}-${g.formatter.m}-${g.formatter.d}";
        await prefs.setString('date', datePlus);
        return datePlus;
      }
    }else{
      if(date.day == 30){
        Get.rawSnackbar(
            boxShadows: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(0, 1),
                blurRadius: 5,
                spreadRadius: 0,
              )
            ],
            snackPosition: SnackPosition.TOP,
            backgroundColor: AppColors.snackBarColor,
            messageText: const Text('برای تغییر ماه از طریق ضربه زدن بر روی تقویم اقدام نمایید.',
                textDirection: TextDirection.rtl),
            titleText: const Text('توجه',
                style: TextStyle(
                    fontWeight: FontWeight.w700
                ),
                textDirection: TextDirection.rtl));
      }else{
        Gregorian g = Gregorian(date.year, date.month, date.day+1);
        String datePlus = "${g.formatter.y}-${g.formatter.m}-${g.formatter.d}";
        await prefs.setString('date', datePlus);
        return datePlus;
      }
    }
  }

  Future<String> reduceDate(DateTime date) async{
    final prefs = await SharedPreferences.getInstance();
    if(date.day == 1){
      Get.rawSnackbar(
          backgroundColor: AppColors.appBarColor,
          snackPosition: SnackPosition.TOP,
          titleText: const Text('توجه',
              style: TextStyle(
                  fontWeight: FontWeight.w700
              ),
              textDirection: TextDirection.rtl),
          messageText: const Text('برای تغییر ماه از طریق ضربه زدن بر روی تقویم اقدام نمایید.',
              textDirection: TextDirection.rtl));
    }
    Gregorian g = Gregorian(date.year, date.month, date.day-1);
    String datePlus = "${g.formatter.y}-${g.formatter.m}-${g.formatter.d}";
    await prefs.setString('date', datePlus);
    return datePlus;
  }

  selectDate(BuildContext context) async{
    final prefs = await SharedPreferences.getInstance();
    final DateTime? date = await showPersianDatePicker(
      context: context,
    );
    print("selectDate selectDate selectDate             "+date.toString());
    Gregorian g = Gregorian(date!.year, date!.month, date!.day);
    Jalali g2j1 = g.toJalali();
    String selectedDate = "${g2j1.formatter.y}-${g2j1.formatter.m}-${g2j1.formatter.d}";
    print("selectDate selectDate selectDate             "+selectedDate);
    await prefs.setString('date', selectedDate);
  }
}