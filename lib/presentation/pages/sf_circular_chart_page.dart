import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:income_and_expenses/logic/bloc/calculate_sf_circular_chart/bloc.dart';
import 'package:income_and_expenses/logic/bloc/calculate_sf_circular_chart/event.dart';
import 'package:income_and_expenses/logic/bloc/calculate_sf_circular_chart/state.dart';
import 'package:income_and_expenses/logic/bloc/them_bloc/bloc.dart';
import 'package:income_and_expenses/logic/bloc/them_bloc/state.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../const/app_colors.dart';
import '../utils/no_data.dart';

class SfCircularChartPage extends StatefulWidget {
  const SfCircularChartPage({Key? key}) : super(key: key);

  @override
  State<SfCircularChartPage> createState() => _SfCircularChartPageState();
}

class _SfCircularChartPageState extends State<SfCircularChartPage> {

  List<_PieData> pieData= [];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {

    return  BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {

      var darkThemeBoolean = state.darkThemeBoolean;

      return BlocBuilder<CalculateSFCircularChartBloc, CalculateSFCircularChartState>(
          builder: (context, state) {

            // if(englishLanguageBoolean == true){
              pieData = [
                _PieData("فروردین",int.parse(state.farvardinExpenses),"${int.parse(state.farvardinExpenses)}"),
                _PieData("اردیبهشت",int.parse(state.ordibeheshtExpenses),"${int.parse(state.ordibeheshtExpenses)}"),
                _PieData("خرداد",int.parse(state.khordadExpenses),"${int.parse(state.khordadExpenses)}"),
                _PieData("تیر",int.parse(state.tirExpenses),"${int.parse(state.tirExpenses)}"),
                _PieData("مرداد",int.parse(state.mordadExpenses),"${int.parse(state.mordadExpenses)}"),
                _PieData("شهریور",int.parse(state.shahrivarExpenses),"${int.parse(state.shahrivarExpenses)}"),
                _PieData("مهر",int.parse(state.mehrExpenses),"${int.parse(state.mehrExpenses)}"),
                _PieData("آبان",int.parse(state.abanExpenses),"${int.parse(state.abanExpenses)}"),
                _PieData("آذر",int.parse(state.azarExpenses),"${int.parse(state.azarExpenses)}"),
                _PieData("دی",int.parse(state.deyExpenses),"${int.parse(state.deyExpenses)}"),
                _PieData("بهمن",int.parse(state.bahmanExpenses),"${int.parse(state.bahmanExpenses)}"),
                _PieData("اسفند",int.parse(state.esfandExpenses),"${int.parse(state.esfandExpenses)}"),
              ];

              var height = MediaQuery.of(context).size.height;
              var width = MediaQuery.of(context).size.width;

            return Scaffold(
                backgroundColor: darkThemeBoolean == "false"
                    ? Colors.white
                    : AppColors.darkThemeColor,
                body: SafeArea(
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.themContainer,
                        borderRadius: BorderRadius.circular(25)
                    ),
                    margin: EdgeInsets.only(
                      left: width / 30,
                      right: width / 30,
                      top: height / 60,
                      bottom: height / 200,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: height / 20),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                alignment: Alignment.center,
                                isExpanded: true,
                                hint: Text(
                                  AppLocalizations.of(context)!.selectYear,
                                  style: TextStyle(
                                      fontSize: width / 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                items: List<String>.generate(200, (i) => '${i+1400}')
                                    .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                        fontSize: width / 30,
                                        fontWeight: FontWeight.bold,
                                        color: darkThemeBoolean == "false"
                                            ? Colors.black
                                            : Colors.white
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )).toList(),
                                value: selectedValue,
                                onChanged: (value) {
                                  setState(() {

                                    selectedValue = value as String;
                                    BlocProvider.of<CalculateSFCircularChartBloc>(context).add(
                                        SumExpensesPerMonthForCircularChartEvent(selectedValue!));
                                  });
                                },
                                buttonHeight: height / 22,
                                buttonWidth: width / 3,
                                buttonPadding: EdgeInsets.only(
                                    left: width / 70,
                                    right: width / 70),
                                buttonDecoration: BoxDecoration(
                                  color: darkThemeBoolean == "false"
                                      ? AppColors.backGroundColor
                                      : AppColors.darkArrowButtonColor,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Colors.black26,
                                  ),
                                ),
                                buttonElevation: 0,
                                itemHeight: height / 25,
                                itemPadding: EdgeInsets.only(
                                    left: width / 70,
                                    right: width / 70),
                                dropdownMaxHeight: height / 10,
                                dropdownWidth: width / 3,
                                dropdownPadding: null,
                                dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: Colors.black26,
                                    ),
                                    color: darkThemeBoolean == "false"
                                        ? AppColors.backGroundColor
                                        : AppColors.darkArrowButtonColor
                                ),
                                dropdownElevation: 0,
                                scrollbarRadius:  const Radius.circular(15),
                                scrollbarThickness: width / 80,
                                scrollbarAlwaysShow: true,
                                offset: const Offset(-20, 0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height / 40),
                        state.farvardinExpenses == '0' &&
                            state.ordibeheshtExpenses == '0' &&
                            state.khordadExpenses == '0' &&
                            state.tirExpenses == '0' &&
                            state.mordadExpenses == '0' &&
                            state.mehrExpenses == '0' &&
                            state.abanExpenses == '0' &&
                            state.azarExpenses == '0' &&
                            state.deyExpenses == '0' &&
                            state.bahmanExpenses == '0' &&
                            state.esfandExpenses == '0'
                            ? const Expanded(
                            flex: 10,
                            child: NoDataPage())
                            : Expanded(
                          flex: 10,
                          child: SafeArea(
                              child: SfCircularChart(
                                  palette: const [
                                    Color.fromRGBO(200, 230, 201, 1),
                                    Color.fromRGBO(225, 190, 231, 1),
                                    Color.fromRGBO(255, 236, 179, 1),
                                    Color.fromRGBO(248, 187, 208, 1),
                                    Color.fromRGBO(178, 235, 242, 1),
                                    Color.fromRGBO(255, 205, 210, 1),
                                    Color.fromRGBO(197, 202, 233, 1),
                                    Color.fromRGBO(222, 178, 138, 1),
                                    Color.fromRGBO(141, 174, 184, 1),
                                    Color.fromRGBO(255, 207, 134, 1),
                                    Color.fromRGBO(165, 222, 138, 1),
                                    Color.fromRGBO(152, 148, 202, 1),
                                  ],
                                  title: ChartTitle(
                                      text: AppLocalizations.of(context)!.expenseTypePerYear,
                                      textStyle: darkThemeBoolean == "false"
                                          ? TextStyle(
                                        color: AppColors.appBarTitleColor,
                                        fontSize: width / 30,)
                                          : TextStyle(
                                        color: Colors.white,
                                        fontSize: width / 30,
                                      )),
                                  legend: Legend(
                                    isVisible: true,
                                    shouldAlwaysShowScrollbar: true,
                                    overflowMode: LegendItemOverflowMode.scroll,
                                    textStyle: darkThemeBoolean == "false"
                                        ? TextStyle(
                                      color: Colors.black,
                                      fontSize: width / 30,)
                                        : TextStyle(
                                      color: Colors.white,
                                      fontSize: width / 30,
                                    ),),
                                  series: <PieSeries<_PieData, String>>[
                                    PieSeries<_PieData, String>(
                                        explode: true,
                                        explodeIndex: 0,
                                        dataSource: pieData,
                                        xValueMapper: (_PieData data, _) => data.xData,
                                        yValueMapper: (_PieData data, _) => data.yData,
                                        dataLabelMapper: (_PieData data, _) => data.text,
                                        dataLabelSettings: DataLabelSettings(
                                          textStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: width / 30),
                                          isVisible: true,
                                        )),
                                  ]
                              )),
                        )
                      ],
                    ),
                  ),
                ));
          });});
  }
}

class _PieData {
  _PieData(this.xData, this.yData, [this.text]);
  final String xData;
  final num yData;
  final String? text;
}
