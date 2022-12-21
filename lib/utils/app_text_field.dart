import 'package:flutter/material.dart';
import 'package:income_and_expenses/utils/app_colors.dart';
import 'package:income_and_expenses/utils/category_icon_list.dart';
import 'package:income_and_expenses/utils/widget.dart';

class AppTextField extends StatefulWidget {

  final String labelText;
  final String error;
  final bool clickable;
  final TextEditingController controller;

  const AppTextField({Key? key,
    required this.labelText,
    required this.error,
    required this.clickable,
    required this.controller}) : super(key: key);

  @override
  State<AppTextField> createState() =>
      _AppTextFieldState(labelText, error, clickable, controller);
}

class _AppTextFieldState extends State<AppTextField> {

  _AppTextFieldState(labelText, error, clickable, controller);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        readOnly: widget.clickable == true ? true : false,
        controller: widget.controller,
        maxLines: widget.labelText == "توضیحات" ? 6 : 1,
        decoration: textInputDecoration.copyWith(
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color: AppColors.labelColor
          )
        ),
        onChanged: (val) {
          setState(() {
            val = widget.controller.text;
          });
        },
        onTap: (){
          widget.clickable == true ? showModalBottomSheet(
              context: context,
              builder: (context) {
                return CategoryIconList();
              }):
              null;
        },
        validator: (val) {
          // if(widget.icon == Icons.email){
          //   return RegExp(
          //       r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          //       .hasMatch(val!)
          //       ? null
          //       : "لطفا فرم درست ایمیل خود را وارد تمایید.";
          // } if(widget.icon == Icons.person){
          //   if (val!.isNotEmpty) {
          //     return null;
          //   } else {
          //     return "لطفا قسمت نام و نام خانوادگی را تکمیل نمایید.";
          //   }
          // }else{
          //   if (val!.length < 6) {
          //     return "رمز عبور نباید کنتر از 6 کاراکتر باشد.";
          //   } else {
          //     return null;
          //   }
          // }
        },
      ),
    );
  }
}

