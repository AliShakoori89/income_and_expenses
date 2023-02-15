import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:income_and_expenses/data_base/data_base.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../const/app_colors.dart';
import '../model/expense_model.dart';

class SetDateRepository {

  late final DatabaseHelper helper;

  SetDateRepository() {
    helper = DatabaseHelper();
  }

  initialDate() async{
    final prefs = await SharedPreferences.getInstance();
    String dateMonthString = '${Jalali.now().year}-${Jalali.now().month}';
    String dateString = '${Jalali.now().year}-${Jalali.now().month}-${Jalali.now().day}';
      await prefs.setString('dateMonth', dateMonthString);
      await prefs.setString('date', dateString);
  }


  writeDate(String date , [String? dateMonth]) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('dateMonth', "${DateTime.parse(date).year}-${DateTime.parse(date).month}");
    await prefs.setString('date', "${DateTime.parse(date).year}-${DateTime.parse(date).month}-${DateTime.parse(date).day}");
  }

  Future<String> readDateMonth() async{
    final prefs = await SharedPreferences.getInstance();
    final String? date = prefs.getString('dateMonth');
    if(date == null){
      String dateMonthString = '${Jalali.now().year}-${Jalali.now().month}';
      return dateMonthString;
    }else{
      return date;
    }
  }

  Future<String> readDate() async{
    final prefs = await SharedPreferences.getInstance();
    final String? date = prefs.getString('date');
    if(date == ""){
      String dateString = '${Jalali.now().year}-${Jalali.now().month}-${Jalali.now().day}';
      return dateString;
    }else{
      return date!;
    }
  }

  addToDate(String date) async{
    final prefs = await SharedPreferences.getInstance();
    if(DateTime.parse(date).month <= 6){
      if(DateTime.parse(date).day == 31){
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
        String newDate = "${DateTime.parse(date).year}-${DateTime.parse(date).month}-${DateTime.parse(date).day+1}";
        await prefs.setString('date', newDate);
        return newDate;
      }
    }else{
      if(DateTime.parse(date).day == 30){
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
        String newDate = "${DateTime.parse(date).year}-${DateTime.parse(date).month}-${DateTime.parse(date).day+1}";
        await prefs.setString('date', newDate);
        return newDate;
      }
    }
  }

  Future<String> reduceDate(String date) async{
    final prefs = await SharedPreferences.getInstance();
    if(DateTime.parse(date).day == 1){
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
    String newDate = "${DateTime.parse(date).year}-${DateTime.parse(date).month}-${DateTime.parse(date).day-1}";
    await prefs.setString('date', newDate);
    return newDate;
  }

  Future<List<ExpenseModel>> getAllExpensesRepo(String date) async {
    return await helper.getAllExpenses(date);
  }

  Future<bool> addExpenseRepo(ExpenseModel expenseModel) async {
    return await helper.saveExpense(expenseModel);
  }

  addTodayExpensesRepo(int todayExpenses) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('todayExpenses', todayExpenses.toString());
  }

  Future<String?> readTodayExpensesRepo() async {
    final prefs = await SharedPreferences.getInstance();
    final String? todayExpenses = prefs.getString('todayExpenses');
    return todayExpenses;
  }
}