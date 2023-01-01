import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/app_colors.dart';

class SetDateRepository {

  writeDate(DateTime date) async{
    final prefs = await SharedPreferences.getInstance();
    Gregorian g = Gregorian(date.year, date.month, date.day);
    Jalali g2j1 = g.toJalali();
    String dateString = "${g2j1.formatter.y}/${g2j1.formatter.m}/${g2j1.formatter.d}";
    await prefs.setString('date', dateString);
  }

  Future<String> readDate() async{
    final prefs = await SharedPreferences.getInstance();
    DateTime now = DateTime.now();
    final String? date = prefs.getString('date');
    if(date == null){
      Gregorian g = Gregorian(now.year, now.month, now.day);
      Jalali g2j1 = g.toJalali();
      String dateString = "${g2j1.formatter.y}/${g2j1.formatter.m}/${g2j1.formatter.d}";
      return dateString;
    }else{
      return date;
    }

  }

  Future<String> addToDate(DateTime date) async{
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
    String datePlus = "${g.formatter.y}/${g.formatter.m}/${g.formatter.d}";
    await prefs.setString('date', datePlus);
    return datePlus;
  }
}