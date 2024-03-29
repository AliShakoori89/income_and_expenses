import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:income_and_expenses/data/model/expense_model.dart';
import 'package:income_and_expenses/logic/bloc/set_date_bloc/bloc.dart';
import 'package:income_and_expenses/logic/bloc/set_date_bloc/event.dart';
import 'package:income_and_expenses/logic/bloc/set_date_bloc/state.dart';
import 'package:income_and_expenses/logic/bloc/them_bloc/bloc.dart';
import 'package:income_and_expenses/logic/bloc/them_bloc/state.dart';
import 'package:income_and_expenses/presentation/const/app_colors.dart';
import 'package:income_and_expenses/presentation/utils/app_text_field.dart';
import 'package:income_and_expenses/presentation/utils/arrow_back_icon.dart';
import 'package:income_and_expenses/presentation/utils/date_picker_calendar.dart';

class AddExpensePage extends StatefulWidget {

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  late TextEditingController categoryController;

  late TextEditingController expensesController;

  late TextEditingController descriptionController;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    categoryController = TextEditingController();
    expensesController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    categoryController.dispose();
    expensesController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    BlocProvider.of<SetDateBloc>(context).add(InitialDateEvent());

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {

      var darkThemeBoolean = state.darkThemeBoolean;

      return
        Scaffold(
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
              fontSize: width / 25,
              fontWeight: FontWeight.w400),
          title: Align(
              alignment: Alignment.center,
              child: Text(AppLocalizations.of(context)!.newExpense)),
          leading: AppLocalizations.of(context)!.language == "زبان"
              ? Container()
              : ArrowBackIcon(themeBoolean: darkThemeBoolean),
          actions: [
            AppLocalizations.of(context)!.language == "زبان"
                ? RotatedBox(
                quarterTurns: 90,
                child: ArrowBackIcon(themeBoolean: darkThemeBoolean))
                : Container()
          ],
        ),
        backgroundColor: darkThemeBoolean == "false"
            ? Colors.white
            : AppColors.darkThemeColor,
        resizeToAvoidBottomInset: true,
        bottomSheet: appButton(darkThemeBoolean, width, height),
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
              color: AppColors.themContainer,
            borderRadius: BorderRadius.circular(25)
          ),
          margin: EdgeInsets.only(
            left: width / 30,
            right: width / 30,
            bottom: height / 9,
            top: height / 40),
          child: Container(
            margin: EdgeInsets.only(
              left: width / 20,
              right: width / 20),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SizedBox(
                      height: width / 20,
                    ),
                    DatePickerCalendar(),
                    SizedBox(
                      height: width / 20,
                    ),
                    SizedBox(
                      height: height / 30,
                    ),
                    AppTextField(
                      labelText: AppLocalizations.of(context)!.grouping,
                      controller: categoryController,
                      clickable: true,
                      themeBoolean: darkThemeBoolean,
                      addExpenses: true,
                    ),
                    SizedBox(
                      height: height / 30,
                    ),
                    AppTextField(
                      labelText: AppLocalizations.of(context)!.expense,
                      controller: expensesController,
                      clickable: false,
                      themeBoolean: darkThemeBoolean,
                      addExpenses: true,
                    ),
                    SizedBox(
                      height: width / 10,
                    ),
                    AppTextField(
                      labelText: AppLocalizations.of(context)!.description,
                      controller: descriptionController,
                      clickable: false,
                      themeBoolean: darkThemeBoolean,
                      addExpenses: true,
                    ),
                  ],
                ),
              )
            ),
          ),
        ),
      );
    });
  }

  BlocBuilder<SetDateBloc, SetDateState> appButton(String themeBoolean, double width, double height) {
    return BlocBuilder<SetDateBloc, SetDateState>(builder: (context, state) {
      var date = state.date;

      return Container(
        color: themeBoolean == "false"
            ? Colors.white
            : AppColors.darkThemeColor,
        child: GestureDetector(
          onTap: () {
            if (formKey.currentState!.validate()) {
              late ExpenseModel expense = ExpenseModel();
              final setDateBloc = BlocProvider.of<SetDateBloc>(context);

              expense.expenseDate = date;
              expense.expenseMonth = DateTime.parse(date).month.toString().length != 1
                  ? "${DateTime.parse(date).year}-${DateTime.parse(date).month}"
                  : "${DateTime.parse(date).year}-0${DateTime.parse(date).month}";



              expense.expense =
                  int.parse(expensesController.text.replaceAll(RegExp(','), ''));

              expense.expensesDescription = descriptionController.text;

              if (categoryController.text == "خرید اقلام") {
                expense.expensesIconType = "assets/icons/expense_category_icons/card_pos.svg";
                expense.expenseCategory = "خرید اقلام";
              } else if (categoryController.text == "خوراکی") {
                expense.expensesIconType = "assets/icons/expense_category_icons/burger_and_cola.svg";
                expense.expenseCategory = "خوراکی";
              } else if (categoryController.text == "حمل و نقل") {
                expense.expensesIconType = "assets/icons/expense_category_icons/driving.svg";
                expense.expenseCategory = "حمل و نقل";
              } else if (categoryController.text == "هدیه") {
                expense.expensesIconType = "assets/icons/expense_category_icons/gift.svg";
                expense.expenseCategory = "هدیه";
              } else if (categoryController.text == "درمانی") {
                expense.expensesIconType = "assets/icons/expense_category_icons/health.svg";
                expense.expenseCategory = "درمانی";
              } else if (categoryController.text == "اقساط و بدهی") {
                expense.expensesIconType = "assets/icons/expense_category_icons/receipt_item.svg";
                expense.expenseCategory = "اقساط و بدهی";
              } else if (categoryController.text == "تعمیرات") {
                expense.expensesIconType = "assets/icons/expense_category_icons/repairs.svg";
                expense.expenseCategory = "تعمیرات";
              } else if (categoryController.text == "pastime") {
                expense.expensesIconType = "assets/icons/expense_category_icons/games_and_multimedia.svg";
                expense.expenseCategory = "تفریح";
              } else if (categoryController.text == "other") {
                expense.expensesIconType = "assets/icons/expense_category_icons/other.svg";
                expense.expenseCategory = "سایر";
              }

              setDateBloc.add(
                  AddOneByOneExpenseEvent(expenseModel: expense, date: date, month: expense.expenseMonth!));

              Navigator.pop(context);
            }
          },
          child: Padding(
            padding:  EdgeInsets.only(
                bottom: width / 30),
            child: Container(
              margin: EdgeInsets.only(
                left: width / 10,
                right: width / 10,),
              height: height / 20,
              width: width,
              decoration: BoxDecoration(
                color: AppColors.buttonColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(AppLocalizations.of(context)!.addExpense,
                    style: TextStyle(color: AppColors.backGroundColor,
                        fontSize: width / 30)),
              ),
            ),
          ),
        ),
      );
    });
  }
}
