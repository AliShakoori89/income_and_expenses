import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/event.dart';
import 'package:income_and_expenses/model/income_model.dart';
import 'package:income_and_expenses/utils/date_picker_calendar.dart';
import '../bloc/change_language_bloc/bloc.dart';
import '../bloc/change_language_bloc/state.dart';
import '../bloc/set_date_bloc/bloc.dart';
import '../bloc/set_date_bloc/state.dart';
import '../bloc/them_bloc/bloc.dart';
import '../bloc/them_bloc/state.dart';
import '../const/app_colors.dart';
import '../const/language.dart';
import '../utils/app_text_field.dart';
import '../utils/arrow_back_icon.dart';
import 'home_page.dart';

class AddIncomePage extends StatefulWidget {
  const AddIncomePage({Key? key}) : super(key: key);

  @override
  State<AddIncomePage> createState() => _AddIncomePageState();
}

class _AddIncomePageState extends State<AddIncomePage> {

  late TextEditingController incomeCategoryController = TextEditingController();
  late TextEditingController incomeController = TextEditingController();
  late TextEditingController incomeDescriptionCategoryController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void initState() {
    BlocProvider.of<SetDateBloc>(context).add(InitialDateEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              fontSize: MediaQuery.of(context).size.width / 25,
              fontWeight: FontWeight.w400),
          title: Align(
              alignment: Alignment.centerRight,
              child: Text(AppLocale.addIncome.getString(context))),
          leading: ArrowBackIcon(themeBoolean: darkThemeBoolean),
        ),
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
              bottom: MediaQuery.of(context).size.height / 80,
              top: MediaQuery.of(context).size.height / 100),
          child: Container(
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 20,
                right: MediaQuery.of(context).size.width / 20),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 15,),
                    DatePickerCalendar(),
                    SizedBox(height: MediaQuery.of(context).size.height / 15,),
                    AppTextField(
                      labelText: AppLocale.grouping.getString(context),
                      controller: incomeCategoryController,
                      clickable: true,
                      themeBoolean: darkThemeBoolean,
                      addExpenses: false,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                    AppTextField(
                      labelText: AppLocale.income.getString(context),
                      controller: incomeController,
                      clickable: false,
                      themeBoolean: darkThemeBoolean,
                      addExpenses: false,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 30,),
                    AppTextField(
                      labelText: AppLocale.description.getString(context),
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

  BlocBuilder<SetDateBloc, SetDateState> appButton(String themeBoolean) {
    return BlocBuilder<SetDateBloc, SetDateState>(builder: (context, state) {
      var date = state.date;

      return BlocBuilder<ChangeLanguageBloc, ChangeLanguageState>(
          builder: (context, state) {
            var englishLanguageBoolean = state.englishLanguageBoolean;

            return Container(
              width: double.infinity,
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

                    if (englishLanguageBoolean == true) {
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
                    } else {
                      if (incomeCategoryController.text == "حقوق") {
                        incomeModel.incomeIconType = "assets/icons/income_category_icons/income.svg";
                      } else if (incomeCategoryController.text == "هدیه") {
                        incomeModel.incomeIconType = "assets/icons/income_category_icons/gift.svg";
                      } else if (incomeCategoryController.text == "جایزه") {
                        incomeModel.incomeIconType = "assets/icons/income_category_icons/reward.svg";
                      } else if (incomeCategoryController.text == "فروش") {
                        incomeModel.incomeIconType = "assets/icons/income_category_icons/sale.svg";
                      } else if (incomeCategoryController.text == "یارانه") {
                        incomeModel.incomeIconType = "assets/icons/income_category_icons/yarane.svg";
                      } else if (incomeCategoryController.text == "سایر") {
                        incomeModel.incomeIconType = "assets/icons/income_category_icons/other.svg";
                      }
                    }

                    setDateBloc.add(
                        AddIncomeEvent(incomeModel: incomeModel, month: incomeModel.incomeMonth!));

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyHomePage()),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Container(
                    margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 10,
                      right: MediaQuery.of(context).size.width / 10,),
                    height: MediaQuery.of(context).size.height / 20,
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
            );
          });
    });
  }
}
