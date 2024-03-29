import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/currency_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/money_input_enums.dart';
import 'package:income_and_expenses/logic/bloc/them_bloc/bloc.dart';
import 'package:income_and_expenses/logic/bloc/them_bloc/state.dart';
import 'package:income_and_expenses/presentation/utils/expenses_category_icon_list.dart';
import 'package:income_and_expenses/presentation/utils/widget.dart';
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

    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {

      var darkThemeBoolean = state.darkThemeBoolean;
      var width = MediaQuery.of(context).size.width;

      return Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          style: TextStyle(
              color: Colors.black,
              fontSize: width / 25
          ),
          readOnly: widget.clickable == true ? true : false,
          controller: widget.controller,
          keyboardType: widget.labelText == "هزینه" || widget.labelText == "expense" ||
              widget.labelText == "مبلغ ورودی" || widget.labelText == "income"
              ? TextInputType.number : null,
          maxLines: widget.labelText == "توضیحات" ? 6 : null,
          decoration: textInputDecoration.copyWith(
              errorStyle: TextStyle(color: darkThemeBoolean == "false"
                  ? Colors.red
                  : Colors.white,
                  fontSize: width / 25),
              filled: true, //<-- SEE HERE
              fillColor: Colors.white, //<-- SEE HERE
              suffixText: widget.labelText == "هزینه" || widget.labelText == "expense" ||
                  widget.labelText == "مبلغ ورودی" || widget.labelText == "income"
                  ? "تومان" : widget.labelText == "دسته بندی" || widget.labelText == "توضیحات" ? "" : "T",
              suffixStyle: TextStyle(
                  color: Colors.black,
                  fontSize: width / 25
              ),
              helperText: darkThemeBoolean == "true" ? widget.labelText : "",
              helperStyle: TextStyle(
                  color: Colors.white,
                  fontSize: width / 25
              ),
              labelText: darkThemeBoolean == "false" ? widget.labelText : "",
              labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: width / 25
              )
          ),
          inputFormatters: widget.labelText == "هزینه" || widget.labelText == "expense" ||
              widget.labelText == "مبلغ ورودی" || widget.labelText == "income"  ? [
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
      );
    });
  }
}

