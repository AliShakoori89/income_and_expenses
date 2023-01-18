import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/event.dart';
import 'package:income_and_expenses/bloc/them_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/them_bloc/event.dart';
import 'package:income_and_expenses/bloc/them_bloc/state.dart';
import 'package:income_and_expenses/const/app_colors.dart';
import 'package:income_and_expenses/utils/cash_container.dart';
import 'package:income_and_expenses/utils/date_picker_calendar.dart';
import 'package:income_and_expenses/const/dimensions.dart';
import '../utils/cash_container_per_date.dart';

class MainExpensesPage extends StatefulWidget {
  const MainExpensesPage({Key? key}) : super(key: key);

  @override
  State<MainExpensesPage> createState() => _MainExpensesPageState();
}

class _MainExpensesPageState extends State<MainExpensesPage> {

  @override
  void initState() {

    BlocProvider.of<SetDateBloc>(context)
        .add(WriteDateEvent(date: DateTime.now()));
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    BlocProvider.of<ThemeBloc>(context)
        .add(ReadThemeBooleanEvent());

    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: state.themeBoolean == "true"
            ? Colors.white
            : AppColors.darkThemeColor,
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.only(
              left: Dimensions.width25,
              right: Dimensions.width25,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // SizedBox(
                  //   height: Dimensions.height10,
                  // ),
                  // const MainExpensesPageHeader(),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  DatePickerCalendar(),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  Column(
                    children: [
                      CashContainer(),
                      SizedBox(
                        height: Dimensions.width20,
                      ),
                      const CashContainerPerDate(),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );});
  }
}
