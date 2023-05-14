import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/state.dart';
import 'package:income_and_expenses/model/expense_model.dart';
import 'package:income_and_expenses/const/app_colors.dart';
import 'package:income_and_expenses/pages/home_page.dart';
import 'package:income_and_expenses/pages/main_expenses_page.dart';
import 'package:income_and_expenses/utils/app_text_field.dart';
import 'package:income_and_expenses/utils/arrow_back_icon.dart';
import 'package:income_and_expenses/utils/date_picker_calendar.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../bloc/change_language_bloc/bloc.dart';
import '../bloc/change_language_bloc/state.dart';
import '../bloc/set_date_bloc/event.dart';
import '../bloc/them_bloc/bloc.dart';
import '../bloc/them_bloc/state.dart';
import '../const/language.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});



  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {

  late TextEditingController categoryController = TextEditingController();
  late TextEditingController expensesController = TextEditingController();
  late TextEditingController descriptionController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    BlocProvider.of<SetDateBloc>(context).add(InitialDateEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {

      var darkThemeBoolean = state.darkThemeBoolean;

      return Scaffold(
        appBar: AppBar(
          backgroundColor: darkThemeBoolean == "false"
              ? Colors.white
              : AppColors.darkThemeColor,
          shadowColor: Colors.white,
          elevation: 1,
          titleTextStyle: TextStyle(
              color: darkThemeBoolean == "false"
                  ? AppColors.appBarTitleColor
                  : Colors.white,
              fontSize: MediaQuery.of(context).size.width / 25,
              fontWeight: FontWeight.w400),
          title: Align(
              alignment: Alignment.centerRight,
              child: Text(AppLocale.newExpense.getString(context))),
          leading: ArrowBackIcon(themeBoolean: darkThemeBoolean),
        ),
        backgroundColor: darkThemeBoolean == "false"
            ? Colors.white
            : AppColors.darkThemeColor,
        resizeToAvoidBottomInset: false,
        bottomSheet: appButton(darkThemeBoolean),
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
              color: AppColors.themContainer,
            borderRadius: BorderRadius.circular(25)
          ),
          margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 30,
              right: MediaQuery.of(context).size.width / 30,
          top: MediaQuery.of(context).size.height / 40),
          child: Container(
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 20,
                right: MediaQuery.of(context).size.width / 20),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 20,
                  ),
                  const DatePickerCalendar(),
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 20,
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 30,
                        ),
                        AppTextField(
                          labelText: AppLocale.grouping.getString(context),
                          controller: categoryController,
                          clickable: true,
                          themeBoolean: darkThemeBoolean,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 30,
                        ),
                        AppTextField(
                          labelText: AppLocale.expense.getString(context),
                          controller: expensesController,
                          clickable: false,
                          themeBoolean: darkThemeBoolean,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width / 10,
                        ),
                        AppTextField(
                          labelText: AppLocale.description.getString(context),
                          controller: descriptionController,
                          clickable: false,
                          themeBoolean: darkThemeBoolean,
                        ),
                      ],
                    ),
                  )
                ],
              )
            ),
          ),
        ),
      );});
  }

  BlocBuilder<SetDateBloc, SetDateState> appButton(String themeBoolean) {
    return BlocBuilder<SetDateBloc, SetDateState>(builder: (context, state) {
      var date = state.date;

      return BlocBuilder<ChangeLanguageBloc, ChangeLanguageState>(
          builder: (context, state) {
            var englishLanguageBoolean = state.englishLanguageBoolean;

            return Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 30
              ),
              child: Container(
                width: double.infinity,
                color: themeBoolean == "false"
                    ? Colors.white
                    : AppColors.darkThemeColor,
                child: GestureDetector(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      late ExpenseModel expense = ExpenseModel();
                      final setDateBloc = BlocProvider.of<SetDateBloc>(context);

                      expense.expenseDate = date;
                      expense.expenseDateMonth = DateTime.parse(date).month.toString().length != 1
                          ? "${DateTime.parse(date).year}-${DateTime.parse(date).month}"
                          : "${DateTime.parse(date).year}-0${DateTime.parse(date).month}";

                      expense.expenseCategory = categoryController.text;

                      expense.expense =
                          int.parse(expensesController.text.toEnglishDigit());
                      expense.description = descriptionController.text;
                      if (englishLanguageBoolean == true) {
                        if (categoryController.text == "buy items") {
                          expense.iconType = "assets/logos/card_pos.svg";
                        } else if (categoryController.text == "comestible") {
                          expense.iconType = "assets/logos/burger_and_cola.svg";
                        } else if (categoryController.text == "transportation") {
                          expense.iconType = "assets/logos/driving.svg";
                        } else if (categoryController.text == "gifts") {
                          expense.iconType = "assets/logos/gift.svg";
                        } else if (categoryController.text == "treatment") {
                          expense.iconType = "assets/logos/health.svg";
                        } else if (categoryController.text ==
                            "installments and debt") {
                          expense.iconType = "assets/logos/receipt_item.svg";
                        } else if (categoryController.text == "renovation") {
                          expense.iconType = "assets/logos/repairs.svg";
                        } else if (categoryController.text == "pastime") {
                          expense.iconType =
                          "assets/logos/games_and_multimedia.svg";
                        } else if (categoryController.text == "etcetera") {
                          expense.iconType = "assets/logos/group_30.svg";
                        }
                      } else {
                        if (categoryController.text == "خرید اقلام") {
                          expense.iconType = "assets/logos/card_pos.svg";
                        } else if (categoryController.text == "خوراکی") {
                          expense.iconType = "assets/logos/burger_and_cola.svg";
                        } else if (categoryController.text == "حمل و نقل") {
                          expense.iconType = "assets/logos/driving.svg";
                        } else if (categoryController.text == "هدایا") {
                          expense.iconType = "assets/logos/gift.svg";
                        } else if (categoryController.text == "درمانی") {
                          expense.iconType = "assets/logos/health.svg";
                        } else if (categoryController.text == "اقساط و بدهی") {
                          expense.iconType = "assets/logos/receipt_item.svg";
                        } else if (categoryController.text == "تعمیرات") {
                          expense.iconType = "assets/logos/repairs.svg";
                        } else if (categoryController.text == "تفریح") {
                          expense.iconType =
                          "assets/logos/games_and_multimedia.svg";
                        } else if (categoryController.text == "سایر") {
                          expense.iconType = "assets/logos/group_30.svg";
                        }
                      }

                      setDateBloc.add(
                          AddOneByOneExpenseEvent(expenseModel: expense, date: date));

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MyHomePage()),
                      );
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    child: Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 10,
                          right: MediaQuery.of(context).size.width / 10,),
                      height: MediaQuery.of(context).size.height / 15,
                      decoration: BoxDecoration(
                        color: AppColors.buttonColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(AppLocale.addExpense.getString(context),
                            style: const TextStyle(color: AppColors
                                .backGroundColor)),
                      ),
                    ),
                  ),
                ),
              ),
            );
          });
    });
  }
}
