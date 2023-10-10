import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_and_expenses/bloc/calculate_sf_circular_chart/bloc.dart';
import 'package:income_and_expenses/bloc/set_date_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/them_bloc/bloc.dart';
import 'package:income_and_expenses/pages/home_page.dart';
import 'package:income_and_expenses/providers/language_provider.dart';
import 'package:income_and_expenses/repository/calculate_repository.dart';
import 'package:income_and_expenses/repository/calculate_sf_cartesian_chart_repository.dart';
import 'package:income_and_expenses/repository/calculate_sf_circular_chart_repository.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:income_and_expenses/repository/change_currency_repository.dart';
import 'package:income_and_expenses/repository/date_time_repository.dart';
import 'package:income_and_expenses/repository/theme_repository.dart';
import 'package:provider/provider.dart';
import 'bloc/calculate_sf_cartesian_chart/bloc.dart';
import 'bloc/change_currency_bloc/bloc.dart';
import 'const/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  LanguageProvider appLanguage = LanguageProvider();
  await appLanguage.fetchLocale();
  runApp(
    // DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (context) =>
    MyApp(
      appLanguage: appLanguage,
    ), // Wrap your app
    // ),
  );
}

class MyApp extends StatelessWidget {
  final LanguageProvider appLanguage;

  MyApp({required this.appLanguage});


  @override
  Widget build(BuildContext context) {

    LanguageProvider language = LanguageProvider();
    language.fetchLocale();
    
    return ChangeNotifierProvider<LanguageProvider>(
      create: (_) => appLanguage,
      child: Consumer<LanguageProvider>(builder: (context, model, child) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                    create: (BuildContext context) =>
                        SetDateBloc(SetDateRepository(), CalculateRepository())),
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
              child: MaterialApp(
                locale: model.appLocal,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en'), // English
                  Locale('fa'), // Spanish
                ],
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mainColor),
                  useMaterial3: true,
                ),
                routes: {
                  '/home_page': (context) => const MyHomePage()
                },
                debugShowCheckedModeBanner: false,
                title: 'Income and Expenses',
                home: const MyHomePage(),
              ),
            );
          }
      ),
    );
  }
}