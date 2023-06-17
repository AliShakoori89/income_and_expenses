import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../bloc/calculate_sf_circular_chart/bloc.dart';
import '../bloc/calculate_sf_circular_chart/event.dart';
import '../bloc/calculate_sf_circular_chart/state.dart';
import '../bloc/change_language_bloc/bloc.dart';
import '../bloc/change_language_bloc/state.dart';
import '../bloc/them_bloc/bloc.dart';
import '../bloc/them_bloc/state.dart';
import '../const/app_colors.dart';
import '../const/language.dart';
import '../utils/no_data.dart';

class MonthChart extends StatefulWidget {
  const MonthChart({Key? key}) : super(key: key);

  @override
  State<MonthChart> createState() => _MonthChartState();
}

class _MonthChartState extends State<MonthChart> {

  List<_PieData> pieData= [];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {

    return  BlocBuilder<ChangeLanguageBloc, ChangeLanguageState>(
        builder: (context, state) {

      var englishLanguageBoolean = state.englishLanguageBoolean;

      return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {

      var darkThemeBoolean = state.darkThemeBoolean;

      return BlocBuilder<CalculateSFCircularChartBloc, CalculateSFCircularChartState>(
          builder: (context, state) {

            if(englishLanguageBoolean == true){
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
            }else{
              pieData = [
                _PieData("فروردین",int.parse(state.farvardinExpenses),"${int.parse(state.farvardinExpenses)}".toPersianDigit().seRagham()),
                _PieData("اردیبهشت",int.parse(state.ordibeheshtExpenses),"${int.parse(state.ordibeheshtExpenses)}".toPersianDigit().seRagham()),
                _PieData("خرداد",int.parse(state.khordadExpenses),"${int.parse(state.khordadExpenses)}".toPersianDigit().seRagham()),
                _PieData("تیر",int.parse(state.tirExpenses),"${int.parse(state.tirExpenses)}".toPersianDigit().seRagham()),
                _PieData("مرداد",int.parse(state.mordadExpenses),"${int.parse(state.mordadExpenses)}".toPersianDigit().seRagham()),
                _PieData("شهریور",int.parse(state.shahrivarExpenses),"${int.parse(state.shahrivarExpenses)}".toPersianDigit().seRagham()),
                _PieData("مهر",int.parse(state.mehrExpenses),"${int.parse(state.mehrExpenses)}".toPersianDigit().seRagham()),
                _PieData("آبان",int.parse(state.abanExpenses),"${int.parse(state.abanExpenses)}".toPersianDigit().seRagham()),
                _PieData("آذر",int.parse(state.azarExpenses),"${int.parse(state.azarExpenses)}".toPersianDigit().seRagham()),
                _PieData("دی",int.parse(state.deyExpenses),"${int.parse(state.deyExpenses)}".toPersianDigit().seRagham()),
                _PieData("بهمن",int.parse(state.bahmanExpenses),"${int.parse(state.bahmanExpenses)}".toPersianDigit().seRagham()),
                _PieData("اسفند",int.parse(state.esfandExpenses),"${int.parse(state.esfandExpenses)}".toPersianDigit().seRagham()),
              ];
            }

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
                  left: MediaQuery.of(context).size.width / 30,
                  right: MediaQuery.of(context).size.width / 30,
                  top: MediaQuery.of(context).size.height / 60,
                  bottom: MediaQuery.of(context).size.height / 30,
                ),
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Center(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          alignment: Alignment.center,
                          isExpanded: true,
                          hint: Text(
                            AppLocale.selectYear.getString(context),
                            style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width / 30,
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
                                  fontSize: MediaQuery.of(context).size.width / 30,
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
                              BlocProvider.of<CalculateSFCircularChartBloc>(context).add(SumExpensesPerMonthForCircularChartEvent(selectedValue!));
                            });
                          },
                          buttonHeight: MediaQuery.of(context).size.height / 22,
                          buttonWidth: MediaQuery.of(context).size.width / 3,
                          buttonPadding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 70,
                              right: MediaQuery.of(context).size.width / 70),
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
                          itemHeight: MediaQuery.of(context).size.height / 25,
                          itemPadding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 70,
                              right: MediaQuery.of(context).size.width / 70),
                          dropdownMaxHeight: MediaQuery.of(context).size.height / 10,
                          dropdownWidth: MediaQuery.of(context).size.width / 3,
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
                          scrollbarThickness: MediaQuery.of(context).size.width / 80,
                          scrollbarAlwaysShow: true,
                          offset: const Offset(-20, 0),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 10),
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
                        ? const NoDataPage()
                        :SafeArea(
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
                                text: AppLocale.expenseTypePerYear.getString(context),
                                textStyle: darkThemeBoolean == "false"
                                    ? const TextStyle(
                                    color: AppColors.appBarTitleColor)
                                    : const TextStyle(
                                    color: Colors.white
                                )),
                            legend: Legend(
                              isVisible: true,
                              shouldAlwaysShowScrollbar: true,
                              overflowMode: LegendItemOverflowMode.scroll,
                              textStyle: darkThemeBoolean == "false"
                                  ? const TextStyle(
                                  color: Colors.black)
                                  : const TextStyle(
                                  color: Colors.white
                              ),),
                            series: <PieSeries<_PieData, String>>[
                              PieSeries<_PieData, String>(
                                  explode: true,
                                  explodeIndex: 0,
                                  dataSource: pieData,
                                  xValueMapper: (_PieData data, _) => data.xData,
                                  yValueMapper: (_PieData data, _) => data.yData,
                                  dataLabelMapper: (_PieData data, _) => data.text,
                                  dataLabelSettings: const DataLabelSettings(
                                    textStyle: TextStyle(
                                        color: Colors.black),
                                    isVisible: true,
                                  )),
                            ]))
                  ],
                ),
              ),
            ));
      });});});
  }
}

class _PieData {
  _PieData(this.xData, this.yData, [this.text]);
  final String xData;
  final num yData;
  final String? text;
}
