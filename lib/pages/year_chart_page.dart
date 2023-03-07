import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {

      var darkThemeBoolean = state.darkThemeBoolean;

      return BlocBuilder<CalculateSFCartesianChartBloc, CalculateSFCartesianChartState>(builder: (context, state) {

        data = [
          _ChartData('خرید اقلام', double.parse(state.buyItemsExpenses)/1000000),
          _ChartData('خوراکی', double.parse(state.comestibleExpenses)/1000000),
          _ChartData('حمل و نقل', double.parse(state.transportationExpenses)/1000000),
          _ChartData('اقساط', double.parse(state.installmentsAndDebtExpenses)/1000000),
          _ChartData('درمانی', double.parse(state.treatmentExpenses)/1000000),
          _ChartData('هدایا', double.parse(state.giftsExpenses)/1000000),
          _ChartData('تعمیرات', double.parse(state.renovationExpenses)/1000000),
          _ChartData('تفریح', double.parse(state.pastimeExpenses)/1000000),
          _ChartData('سایر', double.parse(state.etceteraExpenses)/1000000),
        ];
        _tooltip = TooltipBehavior(enable: true);

      return Scaffold(
          backgroundColor: darkThemeBoolean == "false"
              ? AppColors.mainPageCardBorderColor
              : AppColors.darkThemeColor,
          body: SafeArea(
            child: Column(
              children: [
                SizedBox(height: Dimensions.height20,),
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Text(
                      AppLocale.selectMonth.getString(context),
                      style: TextStyle(
                          fontSize: Dimensions.font14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    items: items
                        .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            fontSize: Dimensions.font14,
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
                        print("selectedValue        $selectedValue");
                        BlocProvider.of<CalculateSFCartesianChartBloc>(context).add(SumExpensesByGroupingTypePerMonthForSFCartesianChartEvent(month: selectedValue!));
                      });
                    },
                    buttonHeight: Dimensions.bottomHeightBar/3,
                    buttonWidth: Dimensions.width45*3,
                    buttonPadding: EdgeInsets.only(left: Dimensions.width30, right: Dimensions.width10),
                    buttonDecoration: BoxDecoration(
                        color: darkThemeBoolean == "false"
                            ? AppColors.backGroundColor
                            : AppColors.darkArrowButtonColor,
                        borderRadius: BorderRadius.circular(Dimensions.radius5),
                        border: Border.all(
                          color: Colors.black26,
                        ),
                    ),
                    buttonElevation: 0,
                    itemHeight: Dimensions.height45,
                    itemPadding: EdgeInsets.only(left: Dimensions.width30, right: Dimensions.width30),
                    dropdownMaxHeight: Dimensions.height45*4,
                    dropdownWidth: Dimensions.height45*3,
                    dropdownPadding: null,
                    dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius5),
                        border: Border.all(
                          color: Colors.black26,
                        ),
                        color: darkThemeBoolean == "false"
                            ? AppColors.backGroundColor
                            : AppColors.darkArrowButtonColor
                    ),
                    dropdownElevation: 0,
                    scrollbarRadius:  Radius.circular(Dimensions.radius5),
                    scrollbarThickness: Dimensions.width10/3,
                    scrollbarAlwaysShow: true,
                    offset: const Offset(-20, 0),
                  ),
                ),
                SizedBox(height: Dimensions.height45*5,),
                SfCartesianChart(
                    margin: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height30,
                      // left: Dimensions.width10,
                      // right: Dimensions.width10,
                    ),
                    title: ChartTitle(
                        text: AppLocale.expensePerYear.getString(context),
                        textStyle: darkThemeBoolean == "false"
                            ? const TextStyle(
                            color: AppColors.appBarTitleColor)
                            : const TextStyle(
                            color: Colors.white
                        )),
                    primaryXAxis: CategoryAxis(),
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
                          color: AppColors.chartColor),
                    ]
                ),
                SizedBox(height: Dimensions.height20,),
                Text("مقیاس : 1/1000000",
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