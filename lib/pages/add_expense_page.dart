import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:income_and_expenses/bloc/expense_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/expense_bloc/event.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/event.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/state.dart';
import 'package:income_and_expenses/model/expense_model.dart';
import 'package:income_and_expenses/routes/route_helper.dart';
import 'package:income_and_expenses/utils/app_colors.dart';
import 'package:income_and_expenses/utils/app_text_field.dart';
import 'package:income_and_expenses/utils/arrow_back_icon.dart';
import 'package:income_and_expenses/utils/date_picker_calendar.dart';
import 'package:income_and_expenses/utils/dimensions.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({Key? key}) : super(key: key);

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
    BlocProvider.of<SetDateBloc>(context).add(ReadDateEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.appBarColor,
        titleTextStyle: TextStyle(
            color: AppColors.appBarTitleColor,
          fontSize: Dimensions.font24,
          fontWeight: FontWeight.w400
        ),
        title: const Align(
            alignment: Alignment.centerRight,
            child: Text("هزینه جدید")),
        leading: const ArrowBackIcon(),
      ),
      resizeToAvoidBottomInset: false,
      bottomSheet: appButton(),
      body: Container(
        margin: EdgeInsets.only(
          left: Dimensions.width30,
          right: Dimensions.width30
        ),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: Dimensions.height20,),
              DatePickerCalendar(),
              SizedBox(height: Dimensions.height20,),
              AppTextField(
                labelText: "دسته بندی",
                controller: categoryController,
                clickable: true
              ),
              SizedBox(height: Dimensions.height30,),
              AppTextField(
                labelText: "هزینه",
                controller: expensesController,
                clickable: false
              ),
              SizedBox(height: Dimensions.height30,),
              AppTextField(
                labelText: "توضیحات",
                controller: descriptionController,
                clickable: false
              ),
            ],
          ),
        ),
      ),
    );
  }

  BlocBuilder<SetDateBloc, SetDateState> appButton() {
    return BlocBuilder<SetDateBloc, SetDateState>(builder: (context, state) {
      return GestureDetector(
        onTap: () {
          if (formKey.currentState!.validate()) {
            late ExpenseModel expense = ExpenseModel();
            final expenseBloc = BlocProvider.of<ExpenseBloc>(context);

            expense.expenseDate = state.date;
            expense.expenseCategory = categoryController.text;
            expense.expense = expensesController.text;
            expense.description = descriptionController.text;
            if(categoryController.text == "خرید اقلام"){
              expense.iconType = "assets/logos/card-pos.svg";
            }else if(categoryController.text == "خوزاکی"){
              expense.iconType = "assets/logos/burger and cola.svg";
            }else if(categoryController.text == "حمل و نقل"){
              expense.iconType = "assets/logos/driving.svg";
            }else if(categoryController.text == "هدایا"){
              expense.iconType = "assets/logos/gift.svg";
            }else if(categoryController.text == "درمانی"){
              expense.iconType = "assets/logos/health.svg";
            }else if(categoryController.text == "اقساط و بدهی"){
              expense.iconType = "assets/logos/receipt-item.svg";
            }else if(categoryController.text == "تعمیرات"){
              expense.iconType = "assets/logos/repairs.svg";
            }else if(categoryController.text == "تفریح"){
              expense.iconType = "assets/logos/games and multimedia.svg";
            }else if(categoryController.text == "سایر"){
              expense.iconType = "assets/logos/group 30.svg";
            }

            expenseBloc.add(AddExpenseEvent(expenseModel: expense));

            Get.toNamed(RouteHelper.getInitial());
          }
        },
        child: Container(
          margin: EdgeInsets.only(
              left: Dimensions.width30,
              right: Dimensions.width30,
              bottom: Dimensions.height10),
          // width: Dimensions.buttonWidth,
          height: Dimensions.buttonHeight,
          decoration: BoxDecoration(
            color: AppColors.buttonColor,
            borderRadius: BorderRadius.circular(Dimensions.radius20),
          ),
          child: const Center(
            child: Text("اضافه کردن هزینه",
                style: TextStyle(color: AppColors.backGroundColor)),
          ),
        ),
      );
    });
  }
}
