import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/logic/bloc/calculate_sf_circular_chart/bloc.dart';
import 'package:income_and_expenses/logic/bloc/calculate_sf_circular_chart/event.dart';
import 'package:income_and_expenses/logic/bloc/calculate_sf_circular_chart/state.dart';
import 'package:income_and_expenses/logic/bloc/them_bloc/bloc.dart';
import 'package:income_and_expenses/logic/bloc/them_bloc/state.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../l10n/app_localizations.dart';
import '../const/app_colors.dart';
import '../utils/no_data.dart';

class SfCircularChartPage extends StatefulWidget {
  const SfCircularChartPage({Key? key}) : super(key: key);

  @override
  State<SfCircularChartPage> createState() => _SfCircularChartPageState();
}

class _SfCircularChartPageState extends State<SfCircularChartPage> {
  List<_PieData> pieData = [];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      var darkThemeBoolean = themeState.darkThemeBoolean;

      return BlocBuilder<CalculateSFCircularChartBloc, CalculateSFCircularChartState>(
          builder: (context, state) {
            pieData = [
              _PieData("فروردین", int.parse(state.farvardinExpenses), "${state.farvardinExpenses}"),
              _PieData("اردیبهشت", int.parse(state.ordibeheshtExpenses), "${state.ordibeheshtExpenses}"),
              _PieData("خرداد", int.parse(state.khordadExpenses), "${state.khordadExpenses}"),
              _PieData("تیر", int.parse(state.tirExpenses), "${state.tirExpenses}"),
              _PieData("مرداد", int.parse(state.mordadExpenses), "${state.mordadExpenses}"),
              _PieData("شهریور", int.parse(state.shahrivarExpenses), "${state.shahrivarExpenses}"),
              _PieData("مهر", int.parse(state.mehrExpenses), "${state.mehrExpenses}"),
              _PieData("آبان", int.parse(state.abanExpenses), "${state.abanExpenses}"),
              _PieData("آذر", int.parse(state.azarExpenses), "${state.azarExpenses}"),
              _PieData("دی", int.parse(state.deyExpenses), "${state.deyExpenses}"),
              _PieData("بهمن", int.parse(state.bahmanExpenses), "${state.bahmanExpenses}"),
              _PieData("اسفند", int.parse(state.esfandExpenses), "${state.esfandExpenses}"),
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
                    borderRadius: BorderRadius.circular(25),
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20),

                      // --- Dropdown ---
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              alignment: Alignment.center,
                              isExpanded: true,
                              hint: Text(
                                AppLocalizations.of(context)!.selectYear,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              items: List<String>.generate(200, (i) => '${i + 1400}')
                                  .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: darkThemeBoolean == "false"
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                                  .toList(),
                              value: selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value!;
                                  context.read<CalculateSFCircularChartBloc>().add(
                                      SumExpensesPerMonthForCircularChartEvent(
                                          selectedValue!));
                                });
                              },

                              // 🎨 New style API (modern)
                              buttonStyleData: ButtonStyleData(
                                height: 50,
                                width: 150,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: darkThemeBoolean == "false"
                                      ? AppColors.backGroundColor
                                      : AppColors.darkArrowButtonColor,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.black26),
                                ),
                                elevation: 0,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: 200,
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.black26),
                                  color: darkThemeBoolean == "false"
                                      ? AppColors.backGroundColor
                                      : AppColors.darkArrowButtonColor,
                                ),
                                elevation: 0,
                                offset: const Offset(0, 0),
                                scrollbarTheme: ScrollbarThemeData(
                                  thumbVisibility: MaterialStateProperty.all(true),
                                  thickness: MaterialStateProperty.all(5),
                                  radius: const Radius.circular(15),
                                ),
                              ),
                              menuItemStyleData: MenuItemStyleData(
                                height: 40,
                                padding: EdgeInsets.symmetric(horizontal: 5),
                              ),
                              iconStyleData: IconStyleData(
                                icon: const Icon(Icons.arrow_drop_down),
                                iconEnabledColor: darkThemeBoolean == "false"
                                    ? Colors.black
                                    : Colors.white,
                                iconSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),

                      // --- Chart or NoData ---
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
                          ? const Expanded(flex: 10, child: NoDataPage())
                          : Expanded(
                        flex: 10,
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
                            textStyle: TextStyle(
                              color: darkThemeBoolean == "false"
                                  ? AppColors.appBarTitleColor
                                  : Colors.white,
                              fontSize: 10,
                            ),
                          ),
                          legend: Legend(
                            isVisible: true,
                            shouldAlwaysShowScrollbar: true,
                            overflowMode: LegendItemOverflowMode.scroll,
                            textStyle: TextStyle(
                              color: darkThemeBoolean == "false"
                                  ? Colors.black
                                  : Colors.white,
                              fontSize: width / 30,
                            ),
                          ),
                          series: <PieSeries<_PieData, String>>[
                            PieSeries<_PieData, String>(
                              explode: true,
                              explodeIndex: 0,
                              dataSource: pieData,
                              xValueMapper: (_PieData data, _) => data.xData,
                              yValueMapper: (_PieData data, _) => data.yData,
                              dataLabelMapper: (_PieData data, _) => data.text,
                              dataLabelSettings: DataLabelSettings(
                                isVisible: true,
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: width / 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    });
  }
}

class _PieData {
  _PieData(this.xData, this.yData, [this.text]);
  final String xData;
  final num yData;
  final String? text;
}
