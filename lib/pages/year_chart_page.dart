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
          _ChartData('خرید اقلام', double.parse(state.buyItemsExpenses)),
          _ChartData('خوراکی', double.parse(state.buyItemsExpenses)),
          _ChartData('حمل و نقل', double.parse(state.buyItemsExpenses)),
          _ChartData('اقساط', double.parse(state.buyItemsExpenses)),
          _ChartData('درمانی', double.parse(state.buyItemsExpenses)),
          _ChartData('هدایا', double.parse(state.buyItemsExpenses)),
          _ChartData('تعمیرات', double.parse(state.buyItemsExpenses)),
          _ChartData('تفریح', double.parse(state.buyItemsExpenses)),
          _ChartData('سایر', double.parse(state.buyItemsExpenses)),
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
                          color: darkThemeBoolean == "false"
                              ? Colors.black
                              : Colors.white
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
                    ))
                        .toList(),
                    value: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value as String;
                        BlocProvider.of<CalculateSFCartesianChartBloc>(context).add(SumExpensesByGroupingTypePerMonthForSFCartesianChartEvent(month: selectedValue!));
                      });
                    },
                    buttonHeight: Dimensions.bottomHeightBar/2,
                    buttonWidth: Dimensions.width45*3,
                    buttonPadding: EdgeInsets.only(left: Dimensions.width30, right: Dimensions.width10),
                    buttonDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius5),
                        border: Border.all(
                          color: Colors.black26,
                        ),
                        color: darkThemeBoolean == "false"
                            ? AppColors.snackBarColor
                            : AppColors.darkArrowButtonColor
                    ),
                    buttonElevation: 0,
                    itemHeight: Dimensions.height45,
                    itemPadding: EdgeInsets.only(left: Dimensions.width30, right: Dimensions.width30),
                    dropdownMaxHeight: Dimensions.height45*4,
                    dropdownWidth: Dimensions.height45*3,
                    dropdownPadding: null,
                    dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius5),
                        color: darkThemeBoolean == "false"
                            ? AppColors.snackBarColor
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
                    primaryYAxis: NumericAxis(minimum: 0, maximum: 15, interval: 10),
                    tooltipBehavior: _tooltip,
                    series: <ChartSeries<_ChartData, String>>[
                      ColumnSeries<_ChartData, String>(
                          dataSource: data,
                          xValueMapper: (_ChartData data, _) => data.x,
                          yValueMapper: (_ChartData data, _) => data.y,
                          name: 'Gold',
                          color: AppColors.chartColor)
                    ]),
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