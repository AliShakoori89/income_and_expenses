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
import '../bloc/change_language_bloc/bloc.dart';
import '../bloc/change_language_bloc/event.dart';
import '../utils/cash_container_per_date.dart';

class MainExpensesPage extends StatefulWidget {

  GlobalKey keyButton;
  GlobalKey keyButton1;
  GlobalKey keyButton2;
  GlobalKey keyButton3;

  MainExpensesPage({Key? key, required this.keyButton, required this.keyButton1,
  required this.keyButton2, required this.keyButton3}) : super(key: key);

  @override
  State<MainExpensesPage> createState() => _MainExpensesPageState(keyButton, keyButton1, keyButton2, keyButton3);
}

class _MainExpensesPageState extends State<MainExpensesPage> {

  String date = "";
  GlobalKey keyButton;
  GlobalKey keyButton1;
  GlobalKey keyButton2;
  GlobalKey keyButton3;

  _MainExpensesPageState(this.keyButton, this.keyButton1, this.keyButton2, this.keyButton3);

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
        resizeToAvoidBottomInset: false,
        backgroundColor: state.darkThemeBoolean == "false"
            ? Colors.white
            : AppColors.darkThemeColor,
        body: Stack(
          children: [
            Container(
              height: Dimensions.height45*5,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(0.8, 1),
                  colors: <Color>[
                    Color.fromRGBO(248, 187, 208, 1),
                    Color.fromRGBO(212, 200, 235, 1),
                    Color.fromRGBO(179, 229, 252, 1),
                  ], // Gradient from https://learnui.design/tools/gradient-generator.html
                  tileMode: TileMode.mirror,
                ),
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(
                        MediaQuery.of(context).size.width, 200)),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: Dimensions.height45,
                ),
                Stack(
                  children: [
                    SizedBox(
                        height: Dimensions.height45,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Positioned(
                                  left: 0,
                                  child: SizedBox(
                                    key: keyButton1,
                                    height: Dimensions.height20*9,
                                    width: Dimensions.width20*2,
                                  ),
                                )),
                            Expanded(
                                child: Center(
                                  child: SizedBox(
                                    key: keyButton2,
                                    height: Dimensions.height20*2,
                                    width: Dimensions.width20*2,
                                  ),
                                )),
                            SizedBox(width: Dimensions.width25*3,),
                            Expanded(
                              child: Positioned(
                                right: 0,
                                child: SizedBox(
                                  key: keyButton3,
                                  height: Dimensions.height20*2,
                                  width: Dimensions.width20*2,
                                ),
                              ),
                            ),
                          ],
                        )
                    ),
                    DatePickerCalendar(),
                  ],
                ),
                SizedBox(
                  height: Dimensions.height30,
                ),
                Column(
                  children: [
                    CashContainer(keyButton: keyButton),
                    const CashContainerPerDate(),
                  ],
                ),
              ],
            )
          ],
        ),
      );});
  }
}
