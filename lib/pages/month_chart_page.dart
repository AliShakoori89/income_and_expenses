import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:income_and_expenses/const/dimensions.dart';
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

class MonthChart extends StatefulWidget {
  const MonthChart({Key? key}) : super(key: key);

  @override
  State<MonthChart> createState() => _MonthChartState();
}

class _MonthChartState extends State<MonthChart> {

  List<_PieData> pieData= [];

  @override
  Widget build(BuildContext context) {

    BlocProvider.of<CalculateSFCircularChartBloc>(context).add(SumExpensesPerMonthForCircularChartEvent());

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
                ? AppColors.mainPageCardBorderColor
                : AppColors.darkThemeColor,
            body: SafeArea(
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
                          dataLabelSettings: DataLabelSettings(
                            textStyle: darkThemeBoolean == "false"
                                ? const TextStyle(
                                color: Colors.black)
                                : const TextStyle(
                                color: Colors.white
                            ),
                            isVisible: true,
                          )),
                    ])));
      });});});
  }
}

class _PieData {
  _PieData(this.xData, this.yData, [this.text]);
  final String xData;
  final num yData;
  final String? text;
}
