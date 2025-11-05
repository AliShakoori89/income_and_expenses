import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/data/model/income_model.dart';
import 'package:income_and_expenses/logic/bloc/set_date_bloc/bloc.dart';
import 'package:income_and_expenses/logic/bloc/set_date_bloc/event.dart';
import 'package:income_and_expenses/logic/bloc/set_date_bloc/state.dart';
import 'package:income_and_expenses/logic/bloc/them_bloc/bloc.dart';
import 'package:income_and_expenses/logic/bloc/them_bloc/state.dart';
import 'package:income_and_expenses/presentation/utils/date_picker_calendar.dart';
import '../../l10n/app_localizations.dart';
import '../const/app_colors.dart';
import '../utils/app_text_field.dart';
import '../utils/arrow_back_icon.dart';

class AddIncomePage extends StatefulWidget {

  AddIncomePage({Key? key}) : super(key: key);

  @override
  State<AddIncomePage> createState() => _AddIncomePageState();
}

class _AddIncomePageState extends State<AddIncomePage> {

  late TextEditingController incomeCategoryController;
  late TextEditingController incomeController;
  late TextEditingController incomeDescriptionCategoryController;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
     incomeCategoryController = TextEditingController();
     incomeController = TextEditingController();
     incomeDescriptionCategoryController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    incomeCategoryController.dispose();
    incomeController.dispose();
    incomeDescriptionCategoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    BlocProvider.of<SetDateBloc>(context).add(InitialDateEvent());

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
      var darkThemeBoolean = state.darkThemeBoolean;

      return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: darkThemeBoolean == "false"
            ? Colors.white
            : AppColors.darkThemeColor,
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
              alignment: Alignment.centerRight,
              child: Text(AppLocalizations.of(context)!.addIncome)),
          leading: ArrowBackIcon(themeBoolean: darkThemeBoolean),
        ),
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
                child: Column(
                  children: [
                    SizedBox(height: height / 15,),
                    DatePickerCalendar(),
                    SizedBox(height: height / 15,),
                    AppTextField(
                      labelText: AppLocalizations.of(context)!.grouping,
                      controller: incomeCategoryController,
                      clickable: true,
                      themeBoolean: darkThemeBoolean,
                      addExpenses: false,
                    ),
                    SizedBox(
                      height: height / 30,
                    ),
                    AppTextField(
                      labelText: AppLocalizations.of(context)!.income,
                      controller: incomeController,
                      clickable: false,
                      themeBoolean: darkThemeBoolean,
                      addExpenses: false,
                    ),
                    SizedBox(height: height / 30,),
                    AppTextField(
                      labelText: AppLocalizations.of(context)!.description,
                      controller: incomeDescriptionCategoryController,
                      clickable: false,
                      themeBoolean: darkThemeBoolean,
                      addExpenses: false,
                    ),
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
      var date = state.date;

      return Container(
        color: themeBoolean == "false"
            ? Colors.white
            : AppColors.darkThemeColor,
        child: GestureDetector(
          onTap: () {
            if (formKey.currentState!.validate()) {

              late IncomeModel incomeModel = IncomeModel();
              final setDateBloc = BlocProvider.of<SetDateBloc>(context);

              incomeModel.incomeDate = date;
              incomeModel.incomeMonth = DateTime.parse(date).month.toString().length != 1
                  ? "${DateTime.parse(date).year}-${DateTime.parse(date).month}"
                  : "${DateTime.parse(date).year}-0${DateTime.parse(date).month}";

              incomeModel.incomeCategory = incomeCategoryController.text;

              incomeModel.income =
                  int.parse(incomeController.text.replaceAll(RegExp(','), ''));

              incomeModel.incomeDescription = incomeDescriptionCategoryController.text;

              // if (englishLanguageBoolean == true) {
                if (incomeCategoryController.text == "income") {
                  incomeModel.incomeIconType = "assets/icons/income_category_icons/income.svg";
                } else if (incomeCategoryController.text == "gift") {
                  incomeModel.incomeIconType = "assets/icons/income_category_icons/gift.svg";
                } else if (incomeCategoryController.text == "reward") {
                  incomeModel.incomeIconType = "assets/icons/income_category_icons/reward.svg";
                } else if (incomeCategoryController.text == "sale") {
                  incomeModel.incomeIconType = "assets/icons/income_category_icons/sale.svg";
                } else if (incomeCategoryController.text == "yarane") {
                  incomeModel.incomeIconType = "assets/icons/income_category_icons/yarane.svg";
                } else if (incomeCategoryController.text == "other") {
                  incomeModel.incomeIconType = "assets/icons/income_category_icons/other.svg";
                }

              setDateBloc.add(
                  AddIncomeEvent(incomeModel: incomeModel, month: incomeModel.incomeMonth!));

              Navigator.of(context).popUntil((route) => route.isFirst);
            }
          },
          child: Padding(
            padding: EdgeInsets.only(bottom: width / 30),
            child: Container(
              width: width,
              margin: EdgeInsets.only(
                left: width / 10,
                right: width / 10,),
              height: height / 20,
              decoration: BoxDecoration(
                color: AppColors.buttonColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(AppLocalizations.of(context)!.addExpense,
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
