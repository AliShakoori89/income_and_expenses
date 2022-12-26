import 'package:flutter/material.dart';
import 'package:income_and_expenses/utils/app_button.dart';
import 'package:income_and_expenses/utils/app_colors.dart';
import 'package:income_and_expenses/utils/app_text_field.dart';
import 'package:income_and_expenses/utils/arrow_back_icon.dart';
import 'package:income_and_expenses/utils/date_picker_calendar.dart';
import 'package:income_and_expenses/utils/dimensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({Key? key}) : super(key: key);

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {

  // late String? date;
  //
  // @override
  // void initState() async{
  //   // TODO: implement initState
  //   super.initState();
  //   final prefs = await SharedPreferences.getInstance();
  //   date = prefs.getString('date');
  // }

  @override
  Widget build(BuildContext context) {

    late TextEditingController categoryController = TextEditingController();
    late TextEditingController expensesController = TextEditingController();
    late TextEditingController descriptionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.appBarColor,
        title: Text("Add new",
        style: TextStyle(color: AppColors.appBarTitleColor),),
        leading: ArrowBackIcon(),
      ),
      bottomSheet: AppButton(
        // date: DatePickerCalendarState().convertDateTime(now),
        category: categoryController.text,
        expense: expensesController.text,
        description: descriptionController.text,
      ),
      body: Container(
        margin: EdgeInsets.only(
          left: Dimensions.width30,
          right: Dimensions.width30
        ),
        child: Column(
          children: [
            SizedBox(height: Dimensions.height20,),
            DatePickerCalendar(),
            SizedBox(height: Dimensions.height20,),
            AppTextField(
              labelText: "دسته بندی",
              error: "لطفا ایمیل را به درستی وارد کنید.",
              controller: categoryController,
              clickable: true
            ),
            SizedBox(height: Dimensions.height30,),
            AppTextField(
              labelText: "هزینه",
              error: "لطفا ایمیل را به درستی وارد کنید.",
              controller: expensesController,
              clickable: false
            ),
            SizedBox(height: Dimensions.height30,),
            AppTextField(
              labelText: "توضیحات",
              error: "لطفا ایمیل را به درستی وارد کنید.",
              controller: descriptionController,
              clickable: false
            ),
          ],
        ),
      ),
    );
  }

  readDate() async{
    final prefs = await SharedPreferences.getInstance();
    final String? date = prefs.getString('date');
    return date;
  }
}
