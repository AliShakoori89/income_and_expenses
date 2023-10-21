import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:income_and_expenses/logic/bloc/change_currency_bloc/bloc.dart';
import 'package:income_and_expenses/logic/bloc/change_currency_bloc/event.dart';
import 'package:income_and_expenses/logic/bloc/change_currency_bloc/state.dart';
import 'package:income_and_expenses/logic/bloc/them_bloc/bloc.dart';
import 'package:income_and_expenses/logic/bloc/them_bloc/event.dart';
import 'package:income_and_expenses/logic/bloc/them_bloc/state.dart';
import 'package:income_and_expenses/logic/providers/language_provider.dart';
import 'package:income_and_expenses/presentation/const/app_colors.dart';
import 'package:income_and_expenses/presentation/pages/frequently_asked_questions_page.dart';
import 'package:provider/provider.dart';
import 'setting_items.dart';

class SettingItemList extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    final appLanguage = Provider.of<LanguageProvider>(context);

    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {

      var darkThemeBoolean = state.darkThemeBoolean;

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
                    itemName: AppLocalizations.of(context)!.export,
                  ),
                ),
              ),
              Divider(
                color:
                darkThemeBoolean == "false" ? Colors.grey : Colors.white,
              ),
              // choose currency
              chooseCurrencyAlertDialog(context, darkThemeBoolean),
              Divider(
                color:
                darkThemeBoolean == "false" ? Colors.grey : Colors.white,
              ),
              // choose language
              chooseLanguageAlertDialog(context, darkThemeBoolean, appLanguage),
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
                    itemName: AppLocalizations.of(context)!.frequentlyAskedQuestions,
                  ),
                ),
              ),
              Divider(
                color:
                darkThemeBoolean == "false" ? Colors.grey : Colors.white,
              ),
              // choose Theme
              chooseThemeAlertDialog(context, darkThemeBoolean),
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
                    itemName: AppLocalizations.of(context)!.exit,
                  ),
                ),
              ),
            ],
          ));});
  }

  GestureDetector chooseCurrencyAlertDialog(BuildContext context, String darkThemeBoolean) {
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
                      title: Text(AppLocalizations.of(context)!.chooseCurrency,
                          textDirection: AppLocalizations.of(context)!.language == "زبان"
                              ? TextDirection.rtl
                              : TextDirection.ltr,
                          style: TextStyle(
                              fontSize:
                              MediaQuery.of(context).size.width / 30,
                              fontWeight: FontWeight.w900,
                              color: darkThemeBoolean == "false"
                                  ? Colors.black : Colors.white)),
                      content: Text(
                          AppLocalizations.of(context)!.chooseCurrencyQuestion,
                          textDirection: AppLocalizations.of(context)!.language == "زبان"
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
                                      AppLocalizations.of(context)!.rial,
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
                                        AppLocalizations.of(context)!.toman,
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
                    itemName: AppLocalizations.of(context)!.chooseCurrency,
                  ),
                ),
              );
  }

  GestureDetector chooseThemeAlertDialog(BuildContext context, String darkThemeBoolean) {

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
                      title: Text(AppLocalizations.of(context)!.chooseTheme,
                        textDirection: AppLocalizations.of(context)!.language == "زبان"
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        style: TextStyle(
                          color: darkThemeBoolean == "false"
                              ? Colors.black : Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: MediaQuery.of(context).size.width / 25,
                        ),
                      ),
                      content:Text(AppLocalizations.of(context)!.pleaseChooseYourTheme,
                          textDirection: AppLocalizations.of(context)!.language == "زبان"
                              ? TextDirection.rtl
                              : TextDirection.ltr,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 30,
                            color: darkThemeBoolean == "false"
                                ? Colors.black : Colors.white,
                          )),
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
                    itemName: AppLocalizations.of(context)!.theme,
                  ),
                ),
              );
  }

  GestureDetector chooseLanguageAlertDialog(BuildContext context, String darkThemeBoolean, LanguageProvider appLanguage) {

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
                      title: Text(AppLocalizations.of(context)!.chooseLanguage,
                        textDirection: AppLocalizations.of(context)!.language == "زبان"
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        style: TextStyle(
                            color: darkThemeBoolean == "false"
                                ? Colors.black : Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: MediaQuery.of(context).size.width / 25),
                      ),
                      content: Text(
                          AppLocalizations.of(context)!.pleaseChooseYourLanguage,
                          textDirection: AppLocalizations.of(context)!.language == "زبان"
                              ? TextDirection.rtl
                              : TextDirection.ltr,
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
                                  appLanguage.changeLanguage(const Locale('en'));
                                  Navigator.of(ctx).pop();
                                },
                                child:
                                    Text(AppLocalizations.of(context)!.english,
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
                                  appLanguage.changeLanguage(const Locale('fa'));
                                  print("121111212121211112112");
                                  Navigator.of(ctx).pop();
                                },
                                child:
                                    Text(AppLocalizations.of(context)!.persian,
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
                    itemName: AppLocalizations.of(context)!.chooseLanguage,
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
