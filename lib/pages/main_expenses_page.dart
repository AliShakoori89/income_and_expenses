import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/event.dart';
import 'package:income_and_expenses/bloc/them_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/them_bloc/state.dart';
import 'package:income_and_expenses/const/app_colors.dart';
import 'package:income_and_expenses/utils/cash_container.dart';
import 'package:income_and_expenses/utils/date_picker_calendar.dart';
import 'package:income_and_expenses/const/dimensions.dart';
import '../utils/cash_container_per_date.dart';

class MainExpensesPage extends StatefulWidget {

  MainExpensesPage({Key? key}) : super(key: key);

  @override
  State<MainExpensesPage> createState() => _MainExpensesPageState();
}

class _MainExpensesPageState extends State<MainExpensesPage> {

  String date = "";

  @override
  void initState() {

    BlocProvider.of<SetDateBloc>(context)
        .add(InitialDateEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
      return Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        backgroundColor: state.darkThemeBoolean == "false"
            ? Colors.white
            : AppColors.darkThemeColor,
        body:
        // Stack(
        //   fit: StackFit.expand,
        //   children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 4,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment(0.8, 1),
                            colors: <Color>[
                              Color.fromRGBO(248, 187, 208, 1),
                              Color.fromRGBO(212, 200, 235, 1),
                              Color.fromRGBO(179, 229, 252, 1),
                            ],
                            // Gradient from https://learnui.design/tools/gradient-generator.html
                            tileMode: TileMode.mirror,
                          ),
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.elliptical(
                                  MediaQuery.of(context).size.width, 200)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/15),
                        child: DatePickerCalendar(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/6),
                        child: CashContainer(),
                      ),

                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/100),
                    child: SingleChildScrollView(
                        child: CashContainerPerDate()),
                  )
                ],
              ),
            ),

            // Column(
            //   children: [
            //     Expanded(
            //       child: SizedBox(
            //         height: MediaQuery.of(context).size.height / 30,
            //       ),
            //     ),
            //     Expanded(
            //         flex: 1,
            //         child: const DatePickerCalendar()),
            //     SizedBox(
            //       height: MediaQuery.of(context).size.height / 30,
            //     ),
            //     Expanded(
            //         flex: 5,
            //         child: CashContainer()),
            //     Expanded(
            //       child: const SingleChildScrollView(
            //         child: CashContainerPerDate(),
            //       ),
            //     )
            //   ],
            // )
        //   ],
        // )
      );
    });
  }
}
