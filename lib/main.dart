import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get/get.dart';
import 'package:income_and_expenses/bloc/calculate_sf_circular_chart/bloc.dart';
import 'package:income_and_expenses/bloc/change_language_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/them_bloc/bloc.dart';
import 'package:income_and_expenses/repository/calculate_repository.dart';
import 'package:income_and_expenses/repository/calculate_sf_cartesian_chart_repository.dart';
import 'package:income_and_expenses/repository/calculate_sf_circular_chart_repository.dart';
import 'package:income_and_expenses/repository/income_repository.dart';
import 'package:income_and_expenses/repository/change_currecy_repository.dart';
import 'package:income_and_expenses/repository/change_language_repository.dart';
import 'package:income_and_expenses/repository/date_time_repository.dart';
import 'package:income_and_expenses/repository/theme_repository.dart';
import 'package:income_and_expenses/routes/route_helper.dart';
import 'bloc/calculate_sf_cartesian_chart/bloc.dart';
import 'bloc/change_currency_bloc/bloc.dart';
import 'const/language.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(
    // DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (context) =>
    MyApp(), // Wrap your app
    // ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final FlutterLocalization _localization = FlutterLocalization.instance;

  @override
  void initState() {
    _localization.init(
      mapLocales: [
        const MapLocale('en', AppLocale.EN),
        const MapLocale('fa', AppLocale.FA),
      ],
      initLanguageCode: 'fa',
    );
    _localization.onTranslatedLanguage = _onTranslatedLanguage;
    super.initState();
  }

  void _onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) =>
                SetDateBloc(SetDateRepository(), CalculateRepository(), IncomeRepository())),
        BlocProvider(
            create: (BuildContext context) =>
                ChangeLanguageBloc(ChangeLanguageRepository())),
        BlocProvider(
            create: (BuildContext context) =>
                ThemeBloc(ChangeThemeRepository())),
        BlocProvider(
            create: (BuildContext context) =>
                ChangeCurrencyBloc(ChangeCurrencyRepository())),
        BlocProvider(
            create: (BuildContext context) =>
                CalculateSFCircularChartBloc(CalculateSFCircularChartRepository())),
        BlocProvider(
            create: (BuildContext context) =>
                CalculateSFCartesianChartBloc(CalculateSFCartesianChartRepository())),
      ],
      child: GetMaterialApp(
        supportedLocales: _localization.supportedLocales,
        localizationsDelegates: _localization.localizationsDelegates,
        debugShowCheckedModeBanner: false,
        title: 'Income and Expenses',
        initialRoute: RouteHelper.getInitial(),
        getPages: RouteHelper.routes,
      ),
    );
  }
}