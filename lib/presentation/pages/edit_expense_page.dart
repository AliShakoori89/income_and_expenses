import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/data/model/expense_model.dart';
import 'package:income_and_expenses/logic/bloc/set_date_bloc/bloc.dart';
import 'package:income_and_expenses/logic/bloc/set_date_bloc/event.dart';
import 'package:income_and_expenses/logic/bloc/set_date_bloc/state.dart';
import 'package:income_and_expenses/logic/bloc/them_bloc/bloc.dart';
import 'package:income_and_expenses/logic/bloc/them_bloc/state.dart';
import 'package:income_and_expenses/presentation/pages/home_page.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../const/app_colors.dart';
import '../utils/app_text_field.dart';
import '../utils/arrow_back_icon.dart';
import '../utils/widget.dart';

class EditedExpensePage extends StatelessWidget {
  final ExpenseModel expenseModel;
  EditedExpensePage({Key? key, required this.expenseModel}) : super(key: key);

  final _expensesController = TextEditingController();
  final _expenseDescriptionController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  late ExpenseModel _editedExpensesModel;

  @override
  Widget build(BuildContext context) {

    _editedExpensesModel = ExpenseModel.fromJson(expenseModel.toJson());

    _expensesController.text = _editedExpensesModel.expense.toString();
    _expenseDescriptionController.text = _editedExpensesModel.expensesDescription!;

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    BlocProvider.of<SetDateBloc>(context).add(InitialDateEvent());

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
              fontSize: width / 20,
              fontWeight: FontWeight.w400),
          title: Align(
              alignment: Alignment.center,
              child: Text(AppLocalizations.of(context)!.editExpense)),
          leading: AppLocalizations.of(context)!.language == "زبان"
              ? GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(20.0))),
                  title: Text(
                    AppLocalizations.of(context)!.delete,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontSize: width / 20,
                        fontWeight: FontWeight.w700),
                  ),
                  content: Text(
                      AppLocalizations.of(context)!.doYouWantTheDesiredItemToBeDeleted,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontSize: width / 25,
                      )),
                  actions: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: height / 25,
                              width: width / 6,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)!.no,
                                  style: TextStyle(
                                      fontSize: width / 25,
                                      color: Colors.white),
                                ),
                              ),
                            )),
                        TextButton(
                            onPressed: () {
                              final expensesBloc =
                              BlocProvider.of<SetDateBloc>(context);
                              expensesBloc.add(DeleteExpenseEvent(
                                  expenseModel.id!,
                                  expenseModel.expenseDate!,
                                  expenseModel.expenseMonth!));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>
                                  const MyHomePage()));
                            },
                            child: Container(
                              height: height / 25,
                              width: width / 6,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)!.yes,
                                  style: TextStyle(
                                      fontSize: width / 25,
                                      color: Colors.white),
                                ),
                              ),
                            )
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
            child: Icon(
              Icons.delete,
              size: width / 25,
              color: darkThemeBoolean == "false"
                  ? AppColors.appBarTitleColor
                  : Colors.white,
            ),
          )
              : ArrowBackIcon(themeBoolean: darkThemeBoolean),
          actions: [
            AppLocalizations.of(context)!.language == "زبان"
                ? RotatedBox(
                quarterTurns: 90,
                child: ArrowBackIcon(themeBoolean: darkThemeBoolean))
                : GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(20.0))),
                    title: Text(
                      AppLocalizations.of(context)!.delete,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          fontSize: width / 20,
                          fontWeight: FontWeight.w700),
                    ),
                    content: Text(
                        AppLocalizations.of(context)!.doYouWantTheDesiredItemToBeDeleted,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: width / 25,
                        )),
                    actions: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: height / 25,
                                width: width / 6,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)!.no,
                                    style: TextStyle(
                                        fontSize: width / 25,
                                        color: Colors.white),
                                  ),
                                ),
                              )),
                          TextButton(
                              onPressed: () {
                                final expensesBloc =
                                BlocProvider.of<SetDateBloc>(context);
                                expensesBloc.add(DeleteExpenseEvent(
                                    expenseModel.id!,
                                    expenseModel.expenseDate!,
                                    expenseModel.expenseMonth!));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>
                                    const MyHomePage()));
                              },
                              child: Container(
                                height: height / 25,
                                width: width / 6,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)!.yes,
                                    style: TextStyle(
                                        fontSize: width / 25,
                                        color: Colors.white),
                                  ),
                                ),
                              )
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
              child: Icon(
                Icons.delete,
                size: width / 25,
                color: darkThemeBoolean == "false"
                    ? AppColors.appBarTitleColor
                    : Colors.white,
              ),
            ),
            SizedBox(
              width: width / 20,
            ),
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
              borderRadius: BorderRadius.circular(25)),
          margin: EdgeInsets.only(
              left: width / 30,
              right: width / 30,
              bottom: height / 9,
              top: height / 40),
          child: Container(
            margin: EdgeInsets.only(
                left: width / 15,
                right: width / 15),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 20,
                    ),
                    Text(
                        "${DateTime.parse(_editedExpensesModel.expenseDate.toString()).year.toString().toPersianDigit()}"
                        "-${DateTime.parse(_editedExpensesModel.expenseDate.toString()).month.toString().toPersianDigit()}"
                        "-${DateTime.parse(_editedExpensesModel.expenseDate.toString()).day.toString().toPersianDigit()}",
                        style: TextStyle(
                            fontSize: width / 15,
                            color: darkThemeBoolean == "false"
                                ? AppColors.appBarTitleColor
                                : Colors.white)),
                    SizedBox(
                      height: height / 30,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: height / 50,
                        ),
                        Directionality(
                          textDirection: AppLocalizations.of(context)!.language == "زبان"
                              ? TextDirection.rtl
                              : TextDirection.ltr,
                          child: TextFormField(
                              enabled: false,
                              controller: TextEditingController(
                                  text: _editedExpensesModel.expenseCategory ==
                                      "سایر"
                                      ? AppLocalizations.of(context)!.other
                                      : _editedExpensesModel.expenseCategory ==
                                      "حمل و نقل"
                                      ? AppLocalizations.of(context)!.transportation
                                      : _editedExpensesModel.expenseCategory ==
                                      "خوراکی"
                                      ? AppLocalizations.of(context)!.comestible
                                      : _editedExpensesModel
                                      .expenseCategory ==
                                      "خرید اقلام"
                                      ? AppLocalizations.of(context)!.buyItems
                                      : _editedExpensesModel
                                      .expenseCategory ==
                                      "اقساط و بدهی"
                                      ? AppLocalizations.of(context)!
                                      .installmentsAndDebt
                                      : _editedExpensesModel
                                      .expenseCategory ==
                                      "درمانی"
                                      ? AppLocalizations.of(context)!.treatment
                                      : _editedExpensesModel.expenseCategory ==
                                      "هدایا"
                                      ? AppLocalizations.of(context)!.gifts
                                      : _editedExpensesModel.expenseCategory == "تفریح"
                                      ? AppLocalizations.of(context)!.pastime
                                      : AppLocalizations.of(context)!.renovation),
                              style: TextStyle(color: darkThemeBoolean == "false" ? Colors.black : Colors.white70, fontWeight: FontWeight.w500),
                              readOnly: true,
                              decoration: textInputDecoration.copyWith(
                                  labelText:
                                  AppLocalizations.of(context)!.grouping,
                                  labelStyle: TextStyle(
                                      fontSize: width / 20,
                                      color: darkThemeBoolean == "false" ? Colors.black : Colors.white70, fontWeight: FontWeight.w900
                                  )
                              )),
                        ),
                        SizedBox(
                          height: height / 30,
                        ),
                        AppTextField(
                          labelText: AppLocalizations.of(context)!.expense,
                          controller: _expensesController,
                          clickable: false,
                          themeBoolean: darkThemeBoolean,
                          addExpenses: false,
                        ),
                        SizedBox(
                          height: width / 10,
                        ),
                        AppTextField(
                          labelText: AppLocalizations.of(context)!.description,
                          controller: _expenseDescriptionController,
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
      );
    });
  }

  BlocBuilder<SetDateBloc, SetDateState> appButton(String themeBoolean, double width, double height) {
    return BlocBuilder<SetDateBloc, SetDateState>(builder: (context, state) {

      return Container(
        color: themeBoolean == "false"
            ? Colors.white
            : AppColors.darkThemeColor,
        child: GestureDetector(
          onTap: () {
            if (formKey.currentState!.validate()) {

              _editedExpensesModel.expenseCategory = _editedExpensesModel.expenseCategory;
              _editedExpensesModel.expense = int.parse(_expensesController.text.replaceAll(RegExp(','), ''));
              _editedExpensesModel.expensesDescription = _expenseDescriptionController.text;

              final setDateBloc = BlocProvider.of<SetDateBloc>(context);

              setDateBloc.add(EditExpenseItemsEvent(_editedExpensesModel, _editedExpensesModel.expenseDate!, _editedExpensesModel.expenseMonth!));

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
                child: Text(AppLocalizations.of(context)!.applyChange,
                    style: TextStyle(color: AppColors
                        .backGroundColor,
                        fontSize: width / 30)),
              ),
            ),
          ),
        ),
      );
    });
  }
}

