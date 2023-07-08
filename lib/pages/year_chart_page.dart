import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_linear_datepicker/flutter_datepicker.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
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
  void initState() {
    String selectedValue = "${Jalali.now().year}/${Jalali.now().month}";
    BlocProvider.of<CalculateSFCartesianChartBloc>(context).add(
        SumExpensesByGroupingTypePerMonthForSFCartesianChartEvent(
            year: selectedValue.split("/").first,
            month: selectedValue.split("/").last));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<ChangeLanguageBloc, ChangeLanguageState>(
        builder: (context, state) {

      bool englishLanguageBoolean = state.englishLanguageBoolean;

      return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {

      var darkThemeBoolean = state.darkThemeBoolean;

      return BlocBuilder<CalculateSFCartesianChartBloc, CalculateSFCartesianChartState>(builder: (context, state) {

        data = [
          _ChartData((AppLocale.buyItems.getString(context)).substring(0,6), double.parse(state.buyItemsExpenses)/100000),
          _ChartData((AppLocale.comestible.getString(context)).substring(0,6), double.parse(state.comestibleExpenses)/100000),
          _ChartData((AppLocale.transportation.getString(context)).substring(0,6), double.parse(state.transportationExpenses)/100000),
          _ChartData((AppLocale.installmentsAndDebt.getString(context)).substring(0,6), double.parse(state.installmentsAndDebtExpenses)/100000),
          _ChartData((AppLocale.treatment.getString(context)).substring(0,6), double.parse(state.treatmentExpenses)/100000),
          _ChartData((AppLocale.gifts.getString(context)).substring(0,3), double.parse(state.giftsExpenses)/100000),
          _ChartData((AppLocale.subsidy.getString(context)).substring(0,6), double.parse(state.renovationExpenses)/100000),
          _ChartData((AppLocale.treatment.getString(context)).substring(0,6), double.parse(state.pastimeExpenses)/100000),
          _ChartData((AppLocale.other.getString(context)).substring(0,4), double.parse(state.etceteraExpenses)/100000),
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
                    child: Container(
                      margin: EdgeInsets.all(
                        MediaQuery.of(context).size.width / 10
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white12,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            spreadRadius: 25,
                            blurStyle: BlurStyle.normal,
                              color: darkThemeBoolean == "false" ? Colors.black12 : Colors.white12,
                              blurRadius: 25.0,
                          )
                        ],
                      ),
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
                          decorationStyle: TextDecorationStyle.double,
                          decorationColor: darkThemeBoolean == "false" ? Colors.black : Colors.white,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'iran',
                          fontSize: MediaQuery.of(context).size.width / 20,
                          color: darkThemeBoolean == "false" ? Colors.black : Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                        yearText: "سال | year",
                        monthText: "ماه | month",
                        labelStyle: TextStyle(
                          color: darkThemeBoolean == "false" ? Colors.black : Colors.white,
                          fontWeight: FontWeight.w700
                        ),
                        unselectedRowStyle: TextStyle(
                          color: darkThemeBoolean == "false" ? Colors.black45 : Colors.white54,
                        ),
                        showLabels: true,
                        columnWidth: MediaQuery.of(context).size.width / 4,
                        showMonthName: true,
                        isJalaali: true,
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 100),
                  Expanded(
                    flex: 8,
                    child: Container(
                      margin: EdgeInsets.all(
                          MediaQuery.of(context).size.width / 10
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white12,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            spreadRadius: 25,
                            blurStyle: BlurStyle.normal,
                            color: darkThemeBoolean == "false" ? Colors.black12 : Colors.white12,
                            blurRadius: 25.0,
                          )
                        ],
                      ),
                      child: SfCartesianChart(
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 30,
                            bottom: MediaQuery.of(context).size.height / 30
                          ),
                          title: ChartTitle(
                              text: AppLocale.expensePerYear.getString(context),
                              textStyle: darkThemeBoolean == "false"
                                  ? const TextStyle(
                                  color: Colors.black)
                                  : const TextStyle(
                                  color: Colors.white
                              )),
                          primaryXAxis: CategoryAxis(
                              labelRotation: 90,
                              labelStyle: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: MediaQuery.of(context).size.width / 30,
                                  fontWeight: FontWeight.w500,
                                color: darkThemeBoolean == "false"
                                    ? Colors.black
                                    : Colors.white
                              )
                          ),
                          primaryYAxis: NumericAxis(minimum: 0, maximum: 100, interval: 10,
                              labelStyle: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: MediaQuery.of(context).size.width / 30,
                                  fontWeight: FontWeight.w300,
                                  color: darkThemeBoolean == "false"
                                      ? Colors.black
                                      : Colors.white
                              )),
                          tooltipBehavior: _tooltip,
                          plotAreaBorderWidth: 0,
                          borderWidth: 0,
                          series: <ChartSeries<_ChartData, String>>[
                            ColumnSeries<_ChartData, String>(
                              borderWidth: 0,
                              dataSource: data,
                              xValueMapper: (_ChartData data, _) => data.x,
                              yValueMapper: (_ChartData data, _) => data.y,
                              name: 'Gold',
                              dataLabelSettings: DataLabelSettings(
                                  isVisible: true,
                                  labelAlignment: ChartDataLabelAlignment.middle,
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: MediaQuery.of(context).size.width / 30
                                  )),
                              onCreateRenderer: (ChartSeries<_ChartData, String> series) =>
                                  _CustomColumnSeriesRenderer(),
                              color: AppColors.chartColor),
                          ]
                      ),
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
                                      ? Colors.black
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
    const Color.fromRGBO(102, 210, 106, 1.0),
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