import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/logic/bloc/them_bloc/bloc.dart';
import 'package:income_and_expenses/logic/bloc/them_bloc/state.dart';
import 'package:income_and_expenses/presentation/const/app_colors.dart';
import 'package:income_and_expenses/presentation/utils/cash_container.dart';
import 'package:income_and_expenses/presentation/utils/date_picker_calendar.dart';
import '../utils/cash_container_per_date.dart';

class MainExpensesPage extends StatelessWidget {

  GlobalKey? keyBottomNavigation1;
  GlobalKey? keyBottomNavigation2;
  GlobalKey? keyBottomNavigation3;
  GlobalKey? keyBottomNavigation4;

  MainExpensesPage({Key? key,
    this.keyBottomNavigation1,
    this.keyBottomNavigation2,
    this.keyBottomNavigation3,
   this.keyBottomNavigation4}) : super(key: key);

  String date = "";

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

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
                      height: height / 5,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment(0.8, 1),
                          colors: <Color>[
                            Color.fromRGBO(248, 187, 208, 1),
                            Color.fromRGBO(212, 200, 235, 1),
                            Color.fromRGBO(179, 229, 252, 1),
                          ],
                          tileMode: TileMode.mirror,
                        ),
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.elliptical(width, 200)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height/20),
                      child: DatePickerCalendar(
                          keyBottomNavigation2: keyBottomNavigation2,
                          keyBottomNavigation3: keyBottomNavigation3,
                          keyBottomNavigation4: keyBottomNavigation4
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height/7),
                      child: CashContainer(keyBottomNavigation1: keyBottomNavigation1),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: height/100,),
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
