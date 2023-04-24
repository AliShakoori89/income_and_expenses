import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_linear_datepicker/flutter_datepicker.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:income_and_expenses/const/dimensions.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../bloc/calculate_sf_cartesian_chart/bloc.dart';
import '../bloc/calculate_sf_cartesian_chart/event.dart';
import '../bloc/calculate_sf_cartesian_chart/state.dart';
import '../bloc/them_bloc/bloc.dart';
import '../bloc/them_bloc/state.dart';
import '../const/app_colors.dart';
import '../const/language.dart';

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
    
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {

      var darkThemeBoolean = state.darkThemeBoolean;

      return BlocBuilder<CalculateSFCartesianChartBloc, CalculateSFCartesianChartState>(builder: (context, state) {

        data = [
          _ChartData('خرید اقلام', double.parse(state.buyItemsExpenses)/100000),
          _ChartData('خوراکی', double.parse(state.comestibleExpenses)/100000),
          _ChartData('حمل و نقل', double.parse(state.transportationExpenses)/100000),
          _ChartData('اقساط', double.parse(state.installmentsAndDebtExpenses)/100000),
          _ChartData('درمانی', double.parse(state.treatmentExpenses)/100000),
          _ChartData('هدایا', double.parse(state.giftsExpenses)/100000),
          _ChartData('تعمیرات', double.parse(state.renovationExpenses)/100000),
          _ChartData('تفریح', double.parse(state.pastimeExpenses)/100000),
          _ChartData('سایر', double.parse(state.etceteraExpenses)/100000),
        ];
        _tooltip = TooltipBehavior(enable: true);

      return Scaffold(
          backgroundColor: darkThemeBoolean == "false"
              ? AppColors.mainPageCardBorderColor
              : AppColors.darkThemeColor,
          body: SafeArea(
            child: Column(
              children: [
                SizedBox(height: Dimensions.height45,),
                LinearDatePicker(
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
                    fontFamily: 'iran',
                    fontSize: Dimensions.font20,
                    color: darkThemeBoolean == "false" ? AppColors.mainColor : Colors.white,
                    fontWeight: FontWeight.bold,
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
                  columnWidth: Dimensions.width45*2,
                  showMonthName: true,
                  isJalaali: true,
                ),
                SizedBox(height: Dimensions.height45*3,),
                SfCartesianChart(
                    margin: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height30,
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
                SizedBox(height: Dimensions.height20,),
                Text("مقیاس : 1/100000",
                style: TextStyle(
                  fontSize: Dimensions.font12,
                  color: darkThemeBoolean == "false"
                      ? AppColors.appBarTitleColor
                      : Colors.white,
                ),)
              ],
            ),
          ));
    });});
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