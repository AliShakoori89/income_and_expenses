import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:income_and_expenses/bloc/change_language_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/change_language_bloc/event.dart';
import 'package:income_and_expenses/bloc/change_language_bloc/state.dart';
import 'package:income_and_expenses/const/app_colors.dart';
import '../bloc/change_currency_bloc/bloc.dart';
import '../bloc/change_currency_bloc/event.dart';
import '../bloc/change_currency_bloc/state.dart';
import '../bloc/them_bloc/bloc.dart';
import '../bloc/them_bloc/event.dart';
import '../bloc/them_bloc/state.dart';
import '../const/language.dart';
import '../pages/frequently_asked_questions_page.dart';
import 'setting_items.dart';

class SettingItemList extends StatefulWidget {
  const SettingItemList({Key? key}) : super(key: key);

  @override
  State<SettingItemList> createState() => _SettingItemListState();
}

class _SettingItemListState extends State<SettingItemList> {

  final FlutterLocalization _localization = FlutterLocalization.instance;
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {

      var darkThemeBoolean = state.darkThemeBoolean;

      return BlocBuilder<ChangeLanguageBloc, ChangeLanguageState>(builder: (context, state){

        var englishLanguageBoolean = state.englishLanguageBoolean;

        return Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 50,
              right: MediaQuery.of(context).size.width / 50,
              left: MediaQuery.of(context).size.width / 50,
            ),
            child: Column(
              children: [
                // export pdf
                GestureDetector(
                  onTap: () async {},
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 20,
                    child: SettingItems(
                      imagePath: darkThemeBoolean == "false"
                          ? "assets/profile_icons/export_to_pdf.png"
                          : "assets/profile_icons/dark_export_to_pdf.png",
                      itemName: AppLocale.export,
                    ),
                  ),
                ),
                Divider(
                  color:
                      darkThemeBoolean == "false" ? Colors.grey : Colors.white,
                ),
                // choose currency
                chooseCurrencyAlertDialog(context, englishLanguageBoolean, darkThemeBoolean),
                Divider(
                  color:
                      darkThemeBoolean == "false" ? Colors.grey : Colors.white,
                ),
                // choose language
                chooseLanguageAlertDialog(context, englishLanguageBoolean, darkThemeBoolean),
                Divider(
                  color:
                      darkThemeBoolean == "false" ? Colors.grey : Colors.white,
                ),
                // frequently asked question
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const FrequentlyAskedQuestions()),
                    );
                  },
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 20,
                    child: SettingItems(
                      imagePath: darkThemeBoolean == "false"
                          ? "assets/profile_icons/frequently_asked_questions.png"
                          : "assets/profile_icons/dark_frequently_asked_questions.png",
                      itemName: AppLocale.frequentlyAskedQuestions,
                    ),
                  ),
                ),
                Divider(
                  color:
                      darkThemeBoolean == "false" ? Colors.grey : Colors.white,
                ),
                // choose Theme
                chooseThemeAlertDialog(context, englishLanguageBoolean, darkThemeBoolean),
                Divider(
                  color:
                      darkThemeBoolean == "false" ? Colors.grey : Colors.white,
                ),
                // logout
                GestureDetector(
                  onTap: () {
                    exit(0);
                  },
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 20,
                    child: SettingItems(
                      imagePath: darkThemeBoolean == "false"
                          ? "assets/profile_icons/logout.png"
                          : "assets/profile_icons/dark_logout.png",
                      itemName: AppLocale.exit,
                    ),
                  ),
                ),
              ],
            ));
      });});
  }

  GestureDetector chooseCurrencyAlertDialog(BuildContext context, bool englishLanguageBoolean, String darkThemeBoolean) {
    return GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      backgroundColor: darkThemeBoolean == "false"
                          ? Colors.white : AppColors.themContainer,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      title: Text(AppLocale.chooseCurrency.getString(context),
                          textDirection: englishLanguageBoolean == false ? TextDirection.rtl : TextDirection.ltr,
                          style: TextStyle(
                              fontSize:
                              MediaQuery.of(context).size.width / 30,
                              fontWeight: FontWeight.w900,
                              color: darkThemeBoolean == "false"
                                  ? Colors.black : Colors.white)),
                      content: Text(
                          AppLocale.chooseCurrencyQuestion.getString(context),
                          textDirection: englishLanguageBoolean == false
                              ? TextDirection.rtl
                              : TextDirection.ltr,
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width / 30,
                          color: darkThemeBoolean == "false"
                              ? Colors.black : Colors.white,)),
                      actions: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 10,
                              right: MediaQuery.of(context).size.width / 10,
                              bottom: MediaQuery.of(context).size.height / 100
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BlocBuilder<ChangeCurrencyBloc,
                                      ChangeCurrencyState>(
                                  builder: (context, state) {
                                return TextButton(
                                    style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(5), //Defines Elevation
                                      shadowColor: MaterialStateProperty.all(
                                          darkThemeBoolean == "false"
                                              ? Colors.black : Colors.white
                                      ), //Defines shadowColor
                                      backgroundColor: MaterialStateProperty.all(Colors.white),
                                    ),
                                    onPressed: () {
                                      BlocProvider.of<ChangeCurrencyBloc>(
                                              context)
                                          .add(WriteCurrencyBooleanEvent(
                                        rialCurrencyBoolean: true,
                                      ));
                                      Navigator.of(ctx).pop();
                                    },
                                    child: Text(
                                        AppLocale.rial.getString(context),
                                    style: const TextStyle(color: Colors.black),));
                              }),
                              BlocBuilder<ChangeCurrencyBloc,
                                      ChangeCurrencyState>(
                                  builder: (context, state) {
                                return TextButton(
                                    style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(5), //Defines Elevation
                                      shadowColor: MaterialStateProperty.all(
                                          darkThemeBoolean == "false"
                                              ? Colors.black : Colors.white
                                      ), //Defines shadowColor
                                      backgroundColor: MaterialStateProperty.all(Colors.white),
                                    ),
                                    onPressed: () {
                                      BlocProvider.of<ChangeCurrencyBloc>(
                                              context)
                                          .add(WriteCurrencyBooleanEvent(
                                        rialCurrencyBoolean: false,
                                      ));
                                      Navigator.of(ctx).pop();
                                    },
                                    child: Text(
                                        AppLocale.toman.getString(context),
                                        style: const TextStyle(color: Colors.black)));
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                  child: SettingItems(
                    imagePath: darkThemeBoolean == "false"
                        ? "assets/profile_icons/choose_currency.png"
                        : "assets/profile_icons/dark_choose_currency.png",
                    itemName: AppLocale.chooseCurrency,
                  ),
                ),
              );
  }

  GestureDetector chooseThemeAlertDialog(BuildContext context, bool englishLanguageBoolean, String darkThemeBoolean) {
    return GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      backgroundColor: darkThemeBoolean == "false"
                          ? Colors.white : AppColors.themContainer,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      title: englishLanguageBoolean == false
                          ? Text(AppLocale.chooseTheme.getString(context),
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: darkThemeBoolean == "false"
                              ? Colors.black : Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: MediaQuery.of(context).size.width / 25,
                        ),
                      )
                          : Text("${AppLocale.chooseTheme.getString(context)} :",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: MediaQuery.of(context).size.width / 25,
                          color: darkThemeBoolean == "false"
                              ? Colors.black : Colors.white,
                        ),
                      ),
                      content: englishLanguageBoolean == false
                          ? Text(AppLocale.pleaseChooseYourTheme.getString(context),
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 30,
                            color: darkThemeBoolean == "false"
                                ? Colors.black : Colors.white,
                          ))
                          : Text(AppLocale.pleaseChooseYourTheme.getString(context),
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              fontSize:
                              MediaQuery.of(context).size.width / 30,
                            color: darkThemeBoolean == "false"
                                ? Colors.black : Colors.white,)),
                      actions: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 10,
                              right: MediaQuery.of(context).size.width / 10,
                              bottom:
                                  MediaQuery.of(context).size.height / 100),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.white),
                                    elevation: MaterialStateProperty.all(3), //Defines Elevation
                                    shadowColor: MaterialStateProperty.all(
                                        darkThemeBoolean == "false"
                                            ? Colors.black : Colors.white
                                    ), //Defines shadowColor
                                  ),
                                  child: const Icon(Icons.dark_mode),
                                  onPressed: () {
                                    BlocProvider.of<ThemeBloc>(context).add(
                                        WriteThemeBooleanEvent(
                                            darkThemeBoolean: true));
                                    BlocProvider.of<ThemeBloc>(context)
                                        .add(ReadThemeBooleanEvent());
                                    Navigator.of(ctx).pop();
                                  }),
                              TextButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.white),
                                    elevation: MaterialStateProperty.all(3), //Defines Elevation
                                    shadowColor: MaterialStateProperty.all(
                                        darkThemeBoolean == "false"
                                            ? Colors.black : Colors.white
                                    ), //Defines shadowColor
                                  ),
                                  child: const Icon(
                                    Icons.light_mode,
                                    color: AppColors.lightColor,
                                  ),
                                  onPressed: () {
                                    BlocProvider.of<ThemeBloc>(context).add(
                                        WriteThemeBooleanEvent(
                                            darkThemeBoolean: false));
                                    BlocProvider.of<ThemeBloc>(context)
                                        .add(ReadThemeBooleanEvent());
                                    Navigator.of(ctx).pop();
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                  child: SettingItems(
                    imagePath: darkThemeBoolean == "false"
                        ? "assets/profile_icons/theme.png"
                        : "assets/profile_icons/dark_theme.png",
                    itemName: AppLocale.theme,
                  ),
                ),
              );
  }

  GestureDetector chooseLanguageAlertDialog(BuildContext context, bool englishLanguageBoolean, String darkThemeBoolean) {
    return GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      backgroundColor: darkThemeBoolean == "false"
                          ? Colors.white : AppColors.themContainer,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      title: englishLanguageBoolean == false
                          ? Text(AppLocale.chooseLanguage.getString(context),
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            color: darkThemeBoolean == "false"
                                ? Colors.black : Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: MediaQuery.of(context).size.width / 25),
                      )
                          : Text(AppLocale.chooseLanguage.getString(context),
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            color: darkThemeBoolean == "false"
                                ? Colors.black : Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: MediaQuery.of(context).size.width / 25),
                      ),
                      content: englishLanguageBoolean == false
                          ? Text(
                          AppLocale.pleaseChooseYourLanguage
                              .getString(context),
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              color: darkThemeBoolean == "false"
                                  ? Colors.black : Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.width / 30))
                          : Text(
                          AppLocale.pleaseChooseYourLanguage
                              .getString(context),
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              color: darkThemeBoolean == "false"
                                  ? Colors.black : Colors.white,
                              fontSize:
                              MediaQuery.of(context).size.width / 30)),
                      actions: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 10,
                              right: MediaQuery.of(context).size.width / 10,
                              bottom:
                              MediaQuery.of(context).size.height / 100
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(5), //Defines Elevation
                                  shadowColor: MaterialStateProperty.all(
                                      darkThemeBoolean == "false"
                                          ? Colors.black : Colors.white
                                  ), //Defines shadowColor
                                  backgroundColor: MaterialStateProperty.all(Colors.white),
                                ),
                                onPressed: () {
                                  BlocProvider.of<ChangeLanguageBloc>(context)
                                      .add(WriteLanguageBooleanEvent(
                                          englishLanguageBoolean: true));
                                  _localization.translate('en');
                                  isSwitched = false;
                                  BlocProvider.of<ChangeLanguageBloc>(context)
                                      .add(ReadLanguageBooleanEvent());
                                  Navigator.of(ctx).pop();
                                },
                                child:
                                    Text(AppLocale.english.getString(context),
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),),
                              ),
                              TextButton(
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(5), //Defines Elevation
                                  shadowColor: MaterialStateProperty.all(
                                      darkThemeBoolean == "false"
                                          ? Colors.black : Colors.white
                                  ), //Defines shadowColor
                                  backgroundColor: MaterialStateProperty.all(Colors.white),
                                ),
                                onPressed: () {
                                  BlocProvider.of<ChangeLanguageBloc>(context)
                                      .add(WriteLanguageBooleanEvent(
                                          englishLanguageBoolean: false));
                                  _localization.translate('fa');
                                  isSwitched = true;
                                  BlocProvider.of<ChangeLanguageBloc>(context)
                                      .add(ReadLanguageBooleanEvent());
                                  Navigator.of(ctx).pop();
                                },
                                child:
                                    Text(AppLocale.persian.getString(context),
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                  child: SettingItems(
                    imagePath: darkThemeBoolean == "false"
                        ? "assets/profile_icons/choose_language.png"
                        : "assets/profile_icons/dark_choose_language.png",
                    itemName: AppLocale.chooseLanguage,
                  ),
                ),
              );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.red;
    }
    return AppColors.mainColor;
  }
}
