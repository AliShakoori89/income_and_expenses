import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/money_input_enums.dart';
import 'package:income_and_expenses/utils/expenses_category_icon_list.dart';
import 'package:income_and_expenses/utils/widget.dart';
import '../bloc/change_language_bloc/bloc.dart';
import '../bloc/change_language_bloc/state.dart';
import 'income_category_icon_list.dart';

class AppTextField extends StatefulWidget {

  final String labelText;
  final bool clickable;
  final TextEditingController controller;
  final String themeBoolean;
  final bool addExpenses;

  const
  AppTextField({Key? key,
    required this.labelText,
    required this.clickable,
    required this.controller,
    required this.themeBoolean,
    required this.addExpenses}) : super(key: key);

  @override
  State<AppTextField> createState() =>
      _AppTextFieldState(labelText, clickable, controller, themeBoolean, addExpenses);
}

class _AppTextFieldState extends State<AppTextField> {

  _AppTextFieldState(labelText, clickable, controller, themeBoolean, addExpenses);

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
          keyboardType: widget.labelText == "هزینه" || widget.labelText == "expense" || widget.labelText == "مبلغ ورودی" || widget.labelText == "income"
              ? TextInputType.number : null,
          maxLines: widget.labelText == "توضیحات" ? 6 : null,
          decoration: textInputDecoration.copyWith(
              filled: true, //<-- SEE HERE
              fillColor: Colors.white, //<-- SEE HERE
              suffixText: widget.labelText == "هزینه" || widget.labelText == "expense" || widget.labelText == "مبلغ ورودی" || widget.labelText == "income"
                  ? englishLanguageBoolean == false ? "تومان" : "T"
                  : "",
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
          inputFormatters: widget.labelText == "هزینه" || widget.labelText == "expense" || widget.labelText == "مبلغ ورودی" || widget.labelText == "income"  ? [
            CurrencyInputFormatter(
              useSymbolPadding: true,
              thousandSeparator: ThousandSeparator.Comma,
              mantissaLength: 0, // the length of the fractional side
            )
          ] : null,
          onChanged: (val) {
            setState(() {
              val = widget.controller.text;
            });
          },
          onTap: (){
            widget.clickable == true ?
            widget.addExpenses == true
                ? showModalBottomSheet(
                context: context,
                builder: (context) {
                  return ExpensesCategoryIconList(controller: widget.controller);
                })
                : showModalBottomSheet(
                context: context,
                builder: (context) {
                  return IncomeCategoryIconList(controller: widget.controller);
                }): null;
          },
          validator: (val) {
            if(widget.labelText == "دسته بندی"){
              if (val!.isNotEmpty){
                return null;
              }else {
                return "لطفا دسته بندی مورد نظر را انتخاب نمایید.";
              }
            } if(widget.labelText == "هزینه" || widget.labelText == "expense" || widget.labelText == "مبلغ ورودی" || widget.labelText == "income"){
              if (val!.isNotEmpty) {
                return null;
              } else {
                return "لطفا هزینه مربوطه را وارد نمایید.";
              }
            }
 return null;
          },
        ),
      );});

  }
}

