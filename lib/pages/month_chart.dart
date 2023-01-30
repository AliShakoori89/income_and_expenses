import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
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

  List<_PieData> pieData = [
    _PieData("فروردین",8,'8'),
    _PieData("اردیبهشت",8,'8'),
    _PieData("خرداد",8,'8'),
    _PieData("تیر",8,'8'),
    _PieData("مرداد",8,'8'),
    _PieData("شهریور",8,'8'),
    _PieData("مهر",8,'8'),
    _PieData("آبان",8,'8'),
    _PieData("آذر",8,'8'),
    _PieData("دی",2,'2'),
    _PieData("بهمن",16,'16'),
    _PieData("اسفند",10,'10'),
  ];

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {

      var darkThemeBoolean = state.darkThemeBoolean;

      return Scaffold(
        backgroundColor: darkThemeBoolean == "false"
            ? AppColors.mainPageCardBorderColor
            : AppColors.darkThemeBorderColor,
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
              title: ChartTitle(text: AppLocale.expensePerYear.getString(context)),
              legend: Legend(isVisible: true),
              series: <PieSeries<_PieData, String>>[
                PieSeries<_PieData, String>(
                    explode: true,
                    explodeIndex: 0,
                    dataSource: pieData,
                    xValueMapper: (_PieData data, _) => data.xData,
                    yValueMapper: (_PieData data, _) => data.yData,
                    dataLabelMapper: (_PieData data, _) => data.text,
                    dataLabelSettings: const DataLabelSettings(isVisible: true,)),
              ]
          )

        ));});
  }
}

class _PieData {
  _PieData(this.xData, this.yData, [this.text]);
  final String xData;
  final num yData;
  final String? text;
}
