import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/event.dart';
import 'package:income_and_expenses/utils/cash_container.dart';
import 'package:income_and_expenses/utils/date_picker_calendar.dart';
import 'package:income_and_expenses/utils/dimensions.dart';
import 'package:income_and_expenses/utils/main_expenses_page_header.dart';
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

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(
            left: Dimensions.width25,
            right: Dimensions.width25,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: Dimensions.height10,
                ),
                const MainExpensesPageHeader(),
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
    );
  }
}
