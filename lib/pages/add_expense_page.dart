import 'package:flutter/material.dart';
import 'package:income_and_expenses/utils/app_colors.dart';
import 'package:income_and_expenses/utils/app_text_field.dart';
import 'package:income_and_expenses/utils/dimensions.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({Key? key}) : super(key: key);

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  @override
  Widget build(BuildContext context) {

    var emailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.appBarColor,
        title: Text("Add new",
        style: TextStyle(color: AppColors.appBarTitleColor),),
        leading: GestureDetector(
            child: Icon(Icons.arrow_back, color: AppColors.appBarTitleColor,),
        onTap: (){
            Navigator.of(context).pop();
        }),
      ),
      body: Container(
        margin: EdgeInsets.only(
          left: Dimensions.width30,
          right: Dimensions.width30
        ),
        child: Column(
          children: [
            SizedBox(height: Dimensions.width30,),
            AppTextField(
              labelText: "دسته بندی",
              error: "لطفا ایمیل را به درستی وارد کنید.",
              controller: emailController,
              clickable: true
            ),
            SizedBox(height: Dimensions.width30,),
            AppTextField(
              labelText: "هزینه",
              error: "لطفا ایمیل را به درستی وارد کنید.",
              controller: emailController,
              clickable: false
            ),
            SizedBox(height: Dimensions.width30,),
            AppTextField(
              labelText: "توضیحات",
              error: "لطفا ایمیل را به درستی وارد کنید.",
              controller: emailController,
              clickable: false
            ),
          ],
        ),
      ),
    );
  }
}
