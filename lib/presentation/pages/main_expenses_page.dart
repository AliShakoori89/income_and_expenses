import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/logic/bloc/them_bloc/bloc.dart';
import 'package:income_and_expenses/logic/bloc/them_bloc/state.dart';
import 'package:income_and_expenses/presentation/const/app_colors.dart';
import 'package:income_and_expenses/presentation/utils/cash_container.dart';
import 'package:income_and_expenses/presentation/utils/date_picker_calendar.dart';
import '../utils/cash_container_per_date.dart';

class MainExpensesPage extends StatefulWidget {

  GlobalKey? keyBottomNavigation1;
  GlobalKey? keyBottomNavigation2;
  GlobalKey? keyBottomNavigation3;
  GlobalKey? keyBottomNavigation4;

  MainExpensesPage({Key? key,
    this.keyBottomNavigation1,
    this.keyBottomNavigation2,
    this.keyBottomNavigation3,
   this.keyBottomNavigation4}) : super(key: key);

  @override
  State<MainExpensesPage> createState() => _MainExpensesPageState(
    keyBottomNavigation1,
    keyBottomNavigation2,
    keyBottomNavigation3,
    keyBottomNavigation4
  );
}

class _MainExpensesPageState extends State<MainExpensesPage> {

  GlobalKey? keyBottomNavigation1;
  GlobalKey? keyBottomNavigation2;
  GlobalKey? keyBottomNavigation3;
  GlobalKey? keyBottomNavigation4;

  _MainExpensesPageState(this.keyBottomNavigation1,
      this.keyBottomNavigation2,
      this.keyBottomNavigation3,
      this.keyBottomNavigation4);

  String date = "";

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
      return Scaffold(
          extendBody: true,
          resizeToAvoidBottomInset: false,
          backgroundColor: state.darkThemeBoolean == "false"
              ? Colors.white
              : AppColors.darkThemeColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 5,
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
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/20),
                      child: DatePickerCalendar(
                          keyBottomNavigation2: keyBottomNavigation2,
                          keyBottomNavigation3: keyBottomNavigation3,
                          keyBottomNavigation4: keyBottomNavigation4
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/7),
                      child: CashContainer(keyBottomNavigation1: keyBottomNavigation1),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height/100,),
                  child: const SingleChildScrollView(
                      child: CashContainerPerDate()),
                ),
              ],
            ),
          )
      );
    });
  }
}
