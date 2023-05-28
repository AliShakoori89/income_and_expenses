import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:income_and_expenses/pages/home_page.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import '../bloc/change_language_bloc/bloc.dart';
import '../bloc/change_language_bloc/state.dart';
import '../bloc/set_date_bloc/bloc.dart';
import '../bloc/set_date_bloc/event.dart';
import '../bloc/set_date_bloc/state.dart';
import '../bloc/them_bloc/bloc.dart';
import '../bloc/them_bloc/state.dart';
import '../const/app_colors.dart';
import '../const/language.dart';
import '../model/expense_model.dart';
import '../utils/app_text_field.dart';
import '../utils/arrow_back_icon.dart';
import '../utils/widget.dart';

class EditedPage extends StatefulWidget {
  final ExpenseModel expenseModel;
  const EditedPage({Key? key, required this.expenseModel}) : super(key: key);

  @override
  _EditedPageState createState() => _EditedPageState();
}

class _EditedPageState extends State<EditedPage> {
  final _expensesController = TextEditingController();
  final _descriptionController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  late ExpenseModel _editedExpenses;

  @override
  void initState() {
    super.initState();

    _editedExpenses = ExpenseModel.fromJson(widget.expenseModel.toJson());

    _expensesController.text = _editedExpenses.expense.toString();
    _descriptionController.text = _editedExpenses.expensesDescription!;
  }

  @override
  Widget build(BuildContext context) {

    BlocProvider.of<SetDateBloc>(context).add(InitialDateEvent());

    return BlocBuilder<ChangeLanguageBloc, ChangeLanguageState>(
        builder: (context, state) {
          bool englishLanguageBoolean = state.englishLanguageBoolean;

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
            fontSize: MediaQuery.of(context).size.width / 20,
            fontWeight: FontWeight.w400),
        title: Align(
            alignment: Alignment.center,
            child: Text(AppLocale.editExpense.getString(context))),
        leading: ArrowBackIcon(themeBoolean: darkThemeBoolean),
        actions: [
          GestureDetector(
            onTap: (){
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  title: Text(
                    AppLocale.delete.getString(context),
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width / 20,
                    fontWeight: FontWeight.w700),
                  ),
                  content: Text(
                      AppLocale.doYouWantTheDesiredItemToBeDeleted.getString(context),
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontSize: MediaQuery.of(context).size.width / 25,)),
                  actions: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height / 25,
                              width: MediaQuery.of(context).size.width / 6,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(15)
                              ),
                              child: Center(
                                child: Text(AppLocale.no.getString(context),
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width / 25,
                                  color: Colors.white
                                ),),
                              ),
                            )),
                        TextButton(
                            onPressed: (){
                              final medicineBloc = BlocProvider.of<SetDateBloc>(context);
                              medicineBloc.add(DeleteItemEvent(widget.expenseModel.id! , widget.expenseModel.expenseDate!));
                              Navigator.pushNamed(
                                context,
                                '/home',
                              );
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height / 25,
                              width: MediaQuery.of(context).size.width / 6,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Center(
                                child: Text(AppLocale.yes.getString(context),
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width / 25,
                                      color: Colors.white
                                  ),),
                              ),
                            ))
                      ],
                    ),
                  ],
                ),
              );
            },
            child: const Icon(Icons.delete,
            color: AppColors.appBarProfileName,),
          ),
          SizedBox(width: MediaQuery.of(context).size.width / 20,),
        ],
      ),
      backgroundColor: darkThemeBoolean == "false"
          ? Colors.white
          : AppColors.darkThemeColor,
      resizeToAvoidBottomInset: true,
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
            bottom: MediaQuery.of(context).size.height / 9,
            top: MediaQuery.of(context).size.height / 40),
        child: Container(
          margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 15,
              right: MediaQuery.of(context).size.width / 15),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 20,
                  ),
                  Text(
                      englishLanguageBoolean == false
                          ? "${DateTime.parse(_editedExpenses.expenseDate.toString()).year.toString().toPersianDigit()}"
                          "-${DateTime.parse(_editedExpenses.expenseDate.toString()).month.toString().toPersianDigit()}"
                          "-${DateTime.parse(_editedExpenses.expenseDate.toString()).day.toString().toPersianDigit()}"
                          : _editedExpenses.expenseDate.toString(),
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 15,
                          color: AppColors.appBarTitleColor)),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 30,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 50,
                      ),
                      Directionality(
                        textDirection: englishLanguageBoolean == false ? TextDirection.rtl : TextDirection.ltr,
                        child: TextFormField(
                            enabled: false,
                            controller: TextEditingController(text: _editedExpenses.expenseCategory),
                          style: TextStyle(
                              color: darkThemeBoolean == "false"
                                  ? Colors.black
                                  : Colors.white70,
                            fontWeight: FontWeight.w700
                          ),
                          readOnly: true,
                          decoration: textInputDecoration.copyWith(
                            labelText: AppLocale.grouping.getString(context),
                          )
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 30,
                      ),
                      AppTextField(
                        labelText: AppLocale.expense.getString(context),
                        controller: _expensesController,
                        clickable: false,
                        themeBoolean: darkThemeBoolean,
                        addExpenses: false,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 10,
                      ),
                      AppTextField(
                        labelText: AppLocale.description.getString(context),
                        controller: _descriptionController,
                        clickable: false,
                        themeBoolean: darkThemeBoolean,
                        addExpenses: false,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );});});
  }

  BlocBuilder<SetDateBloc, SetDateState> appButton(String themeBoolean) {
    return BlocBuilder<SetDateBloc, SetDateState>(builder: (context, state) {

      return BlocBuilder<ChangeLanguageBloc, ChangeLanguageState>(
          builder: (context, state) {

            return Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 30
              ),
              width: double.infinity,
              color: themeBoolean == "false"
                  ? Colors.white
                  : AppColors.darkThemeColor,
              child: GestureDetector(
                onTap: () {
                  if (formKey.currentState!.validate()) {

                    _editedExpenses.expenseCategory = _editedExpenses.expenseCategory;
                    _editedExpenses.expense = int.parse(_expensesController.text);
                    _editedExpenses.expensesDescription = _descriptionController.text;

                    final setDateBloc = BlocProvider.of<SetDateBloc>(context);

                    setDateBloc.add(EditItemEvent(_editedExpenses));

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyHomePage()),
                    );
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 10,
                      right: MediaQuery.of(context).size.width / 10,
                      bottom: MediaQuery.of(context).size.width / 10),
                  height: MediaQuery.of(context).size.height / 15,
                  decoration: BoxDecoration(
                    color: AppColors.buttonColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(AppLocale.applyChange.getString(context),
                        style: const TextStyle(color: AppColors
                            .backGroundColor)),
                  ),
                ),
              ),
            );
          });
    });
  }
}

