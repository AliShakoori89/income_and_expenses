import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_linear_datepicker/flutter_datepicker.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../bloc/calculate_sf_cartesian_chart/bloc.dart';
import '../bloc/calculate_sf_cartesian_chart/event.dart';
import '../bloc/calculate_sf_cartesian_chart/state.dart';
import '../bloc/change_language_bloc/bloc.dart';
import '../bloc/change_language_bloc/state.dart';
import '../bloc/them_bloc/bloc.dart';
import '../bloc/them_bloc/state.dart';
import '../const/app_colors.dart';
import '../const/language.dart';
import  'package:persian_number_utility/persian_number_utility.dart';


class YearChartPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  const YearChartPage({Key? key}) : super(key: key);
  @override
  _YearChartPageState createState() => _YearChartPageState();
}

class _YearChartPageState extends State<YearChartPage> {

  late List<_ChartData> data;
  late TooltipBehavior _tooltip;
  final List<String> items = [
    'فروردین',
    'اردیبهشت',
    'خرداد',
    'تیر',
    'مرداد',
    'شهریور',
    'مهر',
    'آبان',
    'آذر',
    'دی',
    'بهمن',
    'اسفند',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<ChangeLanguageBloc, ChangeLanguageState>(
        builder: (context, state) {

      bool englishLanguageBoolean = state.englishLanguageBoolean;

      return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {

      var darkThemeBoolean = state.darkThemeBoolean;

      return BlocBuilder<CalculateSFCartesianChartBloc, CalculateSFCartesianChartState>(builder: (context, state) {

        data = [
          _ChartData(AppLocale.buyItems.getString(context), double.parse(state.buyItemsExpenses)/100000),
          _ChartData(AppLocale.comestible.getString(context), double.parse(state.comestibleExpenses)/100000),
          _ChartData(AppLocale.transportation.getString(context), double.parse(state.transportationExpenses)/100000),
          _ChartData(AppLocale.installmentsAndDebt.getString(context), double.parse(state.installmentsAndDebtExpenses)/100000),
          _ChartData(AppLocale.treatment.getString(context), double.parse(state.treatmentExpenses)/100000),
          _ChartData(AppLocale.gifts.getString(context), double.parse(state.giftsExpenses)/100000),
          _ChartData(AppLocale.comestible.getString(context), double.parse(state.renovationExpenses)/100000),
          _ChartData(AppLocale.comestible.getString(context), double.parse(state.pastimeExpenses)/100000),
          _ChartData(AppLocale.comestible.getString(context), double.parse(state.etceteraExpenses)/100000),
        ];
        _tooltip = TooltipBehavior(enable: true);

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
                  SizedBox(height: MediaQuery.of(context).size.height / 50),
                  Expanded(
                    flex: 7,
                    child: LinearDatePicker(
                      startDate: "1396/01",
                      endDate: "1499/12",
                      dateChangeListener: (String selectedDate) {

                        selectedValue = selectedDate;

                        BlocProvider.of<CalculateSFCartesianChartBloc>(context).add(
                            SumExpensesByGroupingTypePerMonthForSFCartesianChartEvent(
                                year: selectedValue!.split("/").first,
                                month: selectedValue!.split("/").last));
                      },
                      showDay: false,
                      selectedRowStyle: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.double,
                        decorationColor: darkThemeBoolean == "false" ? AppColors.mainColor : Colors.white,
                        fontStyle: FontStyle.italic,

                        fontFamily: 'iran',
                        fontSize: MediaQuery.of(context).size.width / 20,
                        color: darkThemeBoolean == "false" ? AppColors.mainColor : Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                      yearText: "سال | year",
                      monthText: "ماه | month",
                      labelStyle: TextStyle(
                        color: darkThemeBoolean == "false" ? Colors.black : Colors.white,
                      ),
                      unselectedRowStyle: TextStyle(
                        color: darkThemeBoolean == "false" ? Colors.black : Colors.white,
                      ),
                      showLabels: true,
                      columnWidth: MediaQuery.of(context).size.width / 4,
                      showMonthName: true,
                      isJalaali: true,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 100),
                  Expanded(
                    flex: 8,
                    child: SfCartesianChart(
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 30,
                          bottom: MediaQuery.of(context).size.height / 30
                        ),
                        title: ChartTitle(
                            text: AppLocale.expensePerYear.getString(context),
                            textStyle: darkThemeBoolean == "false"
                                ? const TextStyle(
                                color: AppColors.appBarTitleColor)
                                : const TextStyle(
                                color: Colors.white
                            )),
                        primaryXAxis: CategoryAxis(
                        ),
                        primaryYAxis: NumericAxis(minimum: 0, maximum: 100, interval: 10),
                        tooltipBehavior: _tooltip,
                        series: <ChartSeries<_ChartData, String>>[
                          ColumnSeries<_ChartData, String>(
                            dataSource: data,
                            xValueMapper: (_ChartData data, _) => data.x,
                            yValueMapper: (_ChartData data, _) => data.y,
                            name: 'Gold',
                            dataLabelSettings: DataLabelSettings(
                                isVisible: true,
                                labelAlignment: ChartDataLabelAlignment.middle,
                                textStyle: TextStyle(
                                  color: darkThemeBoolean == "false"
                                      ? AppColors.appBarTitleColor
                                      : Colors.white,
                                )),
                            onCreateRenderer: (ChartSeries<_ChartData, String> series) =>
                                _CustomColumnSeriesRenderer(),
                            color: AppColors.chartColor,),
                        ]
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 100),
                  Expanded(
                    flex: 1,
                    child: englishLanguageBoolean == false
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                englishLanguageBoolean == false
                                    ? "1/100000".toPersianDigit()
                                    : "1/100000",
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width / 25,
                                  color: darkThemeBoolean == "false"
                                      ? AppColors.appBarTitleColor
                                      : Colors.white,
                                ),
                              ),
                              Text(
                                " : ${AppLocale.mapScale.getString(context)}",
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width / 25,
                                  color: darkThemeBoolean == "false"
                                      ? AppColors.appBarTitleColor
                                      : Colors.white,
                                ),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${AppLocale.mapScale.getString(context)} : ",
                                style: TextStyle(
                                  fontSize:
                                  MediaQuery.of(context).size.width / 25,
                                  color: darkThemeBoolean == "false"
                                      ? AppColors.appBarTitleColor
                                      : Colors.white,
                                ),
                              ),
                              Text(
                                englishLanguageBoolean == false
                                    ? "1/100000".toPersianDigit()
                                    : "1/100000",
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width / 25,
                                  color: darkThemeBoolean == "false"
                                      ? AppColors.appBarTitleColor
                                      : Colors.white,
                                ),
                              ),
                            ],
                          ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 15),
                ],
              ),
            ),
          ));
    });});});
  }
}

class _ChartData {
  _ChartData(this.x, this.y);
  final String x;
  final double y;
}

class _CustomColumnSeriesRenderer extends ColumnSeriesRenderer {
  _CustomColumnSeriesRenderer();

  @override
  ColumnSegment createSegment() {
    return _ColumnCustomPainter();
  }
}

class _ColumnCustomPainter extends ColumnSegment {
  final colorList = [
    const Color.fromRGBO(200, 230, 201, 1),
    const Color.fromRGBO(225, 190, 231, 1),
    const Color.fromRGBO(255, 236, 179, 1),
    const Color.fromRGBO(248, 187, 208, 1),
    const Color.fromRGBO(178, 235, 242, 1),
    const Color.fromRGBO(255, 205, 210, 1),
    const Color.fromRGBO(197, 202, 233, 1),
    const Color.fromRGBO(222, 178, 138, 1),
    const Color.fromRGBO(141, 174, 184, 1),
    const Color.fromRGBO(255, 207, 134, 1),
    const Color.fromRGBO(165, 222, 138, 1),
    const Color.fromRGBO(152, 148, 202, 1),
  ];

  @override
  Paint getFillPaint() {
    final Paint customerFillPaint = Paint();
    customerFillPaint.isAntiAlias = false;
    customerFillPaint.color = colorList[currentSegmentIndex!];
    customerFillPaint.style = PaintingStyle.fill;
    return customerFillPaint;
  }
}