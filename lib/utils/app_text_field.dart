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
        keyboardType: widget.labelText == "هزینه" ? TextInputType.number : null,
        maxLines: widget.labelText == "توضیحات" ? 6 : null,
        decoration: textInputDecoration.copyWith(
          suffixText: widget.labelText == "هزینه" ? "تومان" : "",
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
                return CategoryIconList(controller: widget.controller);
              }):
              null;
        },
        validator: (val) {
          if(widget.labelText == "دسته بندی"){
            if (val!.isNotEmpty){
              return null;
            }else {
              return "لطفا دسته بندی مورد نظر را انتخاب نمایید.";
            }
          } if(widget.labelText == "هزینه"){
            if (val!.isNotEmpty) {
              return null;
            } else {
              return "لطفا هزینه مربوطه را وارد نمایید.";
            }
          }
        },
      ),
    );
  }
}

