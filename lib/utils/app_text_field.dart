import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/utils/category_icon_list.dart';
import 'package:income_and_expenses/utils/widget.dart';
import '../bloc/change_language_bloc/bloc.dart';
import '../bloc/change_language_bloc/state.dart';

class AppTextField extends StatefulWidget {

  final String labelText;
  final bool clickable;
  final TextEditingController controller;
  final String themeBoolean;

  const
  AppTextField({Key? key,
    required this.labelText,
    required this.clickable,
    required this.controller,
    required this.themeBoolean}) : super(key: key);

  @override
  State<AppTextField> createState() =>
      _AppTextFieldState(labelText, clickable, controller, themeBoolean);
}

class _AppTextFieldState extends State<AppTextField> {

  _AppTextFieldState(labelText, clickable, controller, themeBoolean);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ChangeLanguageBloc, ChangeLanguageState>(
        builder: (context, state) {
      bool englishLanguageBoolean = state.englishLanguageBoolean;

      return Directionality(
        textDirection: englishLanguageBoolean == false ? TextDirection.rtl : TextDirection.ltr,
        child: TextFormField(
          style: TextStyle(
              color: widget.themeBoolean == "false"
                  ? Colors.black
                  : Colors.white70
          ),
          readOnly: widget.clickable == true ? true : false,
          controller: widget.controller,
          keyboardType: widget.labelText == "هزینه" || widget.labelText == "expense" ? TextInputType.number : null,
          // inputFormatters: [
          //   ThousandsFormatter()
          // ],
          maxLines: widget.labelText == "توضیحات" ? 6 : null,
          decoration: textInputDecoration.copyWith(
              suffixText: widget.labelText == "هزینه" || widget.labelText == "expense" ? "تومان" : "",
              suffixStyle: TextStyle(
                  color: widget.themeBoolean == "false"
                      ? Colors.black
                      : Colors.white70
              ),
              labelText: widget.labelText,
              labelStyle: TextStyle(
                  color: widget.themeBoolean == "false"
                      ? Colors.black
                      : Colors.white70
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
      );});

  }
}

