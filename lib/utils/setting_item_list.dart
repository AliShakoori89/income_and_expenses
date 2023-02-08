import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get/get.dart';
import 'package:income_and_expenses/bloc/change_language_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/change_language_bloc/event.dart';
import 'package:income_and_expenses/routes/route_helper.dart';
import 'package:income_and_expenses/const/app_colors.dart';
import 'package:income_and_expenses/const/dimensions.dart';
import '../bloc/change_currency_bloc/bloc.dart';
import '../bloc/change_currency_bloc/event.dart';
import '../bloc/change_currency_bloc/state.dart';
import '../bloc/them_bloc/bloc.dart';
import '../bloc/them_bloc/event.dart';
import '../bloc/them_bloc/state.dart';
import '../const/language.dart';
import 'setting_items.dart';

class SettingItemList extends StatefulWidget {
  const SettingItemList({Key? key}) : super(key: key);

  @override
  State<SettingItemList> createState() => _SettingItemListState();
}

class _SettingItemListState extends State<SettingItemList> {

  final FlutterLocalization _localization = FlutterLocalization.instance;

  @override
  Widget build(BuildContext context) {

    // BlocProvider.of<ThemeBloc>(context).add(ReadThemeBooleanEvent());

    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {

      var darkThemeBoolean = state.darkThemeBoolean;

      return Container(
      margin: EdgeInsets.only(
          top: Dimensions.height30,
          right: Dimensions.width20,
          left: Dimensions.width20
      ),
      child: Column(
        children: [
          // export pdf
          GestureDetector(
            onTap: () async {
            },
            child: SettingItems(
              imagePath: darkThemeBoolean == "false"
                  ? "assets/profile_icons/export_to_pdf.png"
                  : "assets/profile_icons/dark_export_to_pdf.png",
              itemName: AppLocale.export,
            ),
          ),
          Divider(
            color: darkThemeBoolean == "false"
                ? Colors.grey
                : Colors.white,
          ),
          SizedBox(
            height: Dimensions.height30,
          ),
          // choose currency
          GestureDetector(
            onTap: (){
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text(
                    AppLocale.chooseCurrency.getString(context),
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontSize: Dimensions.font16),
                  ),
                  content: Text(AppLocale.chooseCurrencyQuestion.getString(context),
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontSize: Dimensions.font14)),
                  actions: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BlocBuilder<ChangeCurrencyBloc, ChangeCurrencyState>(
                          builder: (context, state) {
                            return TextButton(onPressed: (){
                              BlocProvider.of<ChangeCurrencyBloc>(context)
                                  .add(WriteCurrencyBooleanEvent(
                                rialCurrencyBoolean: true,
                              ));
                              Navigator.of(ctx).pop();
                            },
                                child: Text(AppLocale.rial.getString(context)));
                          })
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BlocBuilder<ChangeCurrencyBloc, ChangeCurrencyState>(
                            builder: (context, state) {
                              return TextButton(
                                  onPressed: (){
                                    BlocProvider.of<ChangeCurrencyBloc>(context)
                                        .add(WriteCurrencyBooleanEvent(
                                      rialCurrencyBoolean: false,
                                    ));
                                    Navigator.of(ctx).pop();
                                  },
                                  child: Text(AppLocale.toman.getString(context)));
                            }),
                      ],
                    ),
                  ],
                ),
              );
            },
            child: SettingItems(
              imagePath: darkThemeBoolean == "false"
                  ? "assets/profile_icons/choose_currency.png"
                  : "assets/profile_icons/dark_choose_currency.png",
              itemName: AppLocale.chooseCurrency,
            ),
          ),
          Divider(
            color: darkThemeBoolean == "false"
                ? Colors.grey
                : Colors.white,
          ),
          SizedBox(
            height: Dimensions.height30,
          ),
          // choose language
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text(
                    AppLocale.chooseLanguage.getString(context),
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontSize: Dimensions.font16),
                  ),
                  content: Text(AppLocale.pleaseChooseYourLanguage.getString(context),
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontSize: Dimensions.font14)),
                  actions: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: (){
                            BlocProvider.of<ChangeLanguageBloc>(context)
                                .add(WriteLanguageBooleanEvent(englishLanguageBoolean: true));
                            _localization.translate('en');
                            Navigator.of(ctx).pop();
                          },
                          child: Text(AppLocale.english.getString(context)),),
                        TextButton(
                            onPressed: (){
                              BlocProvider.of<ChangeLanguageBloc>(context)
                                  .add(WriteLanguageBooleanEvent(englishLanguageBoolean: false));
                              _localization.translate('fa');
                              Navigator.of(ctx).pop();
                            },
                            child: Text(AppLocale.persian.getString(context)),),
                      ],
                    ),
                  ],
                ),
              );
            },
            child: SettingItems(
              imagePath: darkThemeBoolean == "false"
                  ? "assets/profile_icons/choose_language.png"
                  : "assets/profile_icons/dark_choose_language.png",
              itemName: AppLocale.chooseLanguage,
            ),
          ),
          Divider(
            color: darkThemeBoolean == "false"
                ? Colors.grey
                : Colors.white,
          ),
          SizedBox(
            height: Dimensions.height30,
          ),
          // frequently asked question
          GestureDetector(
            onTap: (){
              Get.toNamed(RouteHelper.getFrequentlyAskedQuestions());
            },
            child: Center(
              child: SettingItems(
                imagePath: darkThemeBoolean == "false"
                    ? "assets/profile_icons/frequently_asked_questions.png"
                    : "assets/profile_icons/dark_frequently_asked_questions.png",
                itemName: AppLocale.frequentlyAskedQuestions,
              ),
            ),
          ),
          Divider(
            color: darkThemeBoolean == "false"
                ? Colors.grey
                : Colors.white,
          ),
          SizedBox(
            height: Dimensions.height30,
          ),
          // choose Theme
          GestureDetector(
            onTap: (){
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text(
                    AppLocale.chooseTheme.getString(context),
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontSize: Dimensions.font16),
                  ),
                  content: Text(AppLocale.pleaseChooseYourTheme.getString(context),
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontSize: Dimensions.font14)),
                  actions: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                        left: Dimensions.width45,
                        right: Dimensions.width45,
                        bottom: Dimensions.height15
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            child: const Icon(Icons.dark_mode),
                            onTap: (){
                            BlocProvider.of<ThemeBloc>(context)
                                .add(WriteThemeBooleanEvent(darkThemeBoolean: true));
                            BlocProvider.of<ThemeBloc>(context)
                                .add(ReadThemeBooleanEvent());
                            Navigator.of(ctx).pop();
                            }
                          ),
                          GestureDetector(
                              child: const Icon(Icons.light_mode ,
                              color: AppColors.lightColor,),
                          onTap: (){
                            BlocProvider.of<ThemeBloc>(context)
                                .add(WriteThemeBooleanEvent(darkThemeBoolean: false));
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
            child: SettingItems(
              imagePath: darkThemeBoolean == "false"
                  ? "assets/profile_icons/theme.png"
                  : "assets/profile_icons/dark_theme.png",
              itemName: AppLocale.theme,
            ),
          ),
          Divider(
            color: darkThemeBoolean == "false"
                ? Colors.grey
                : Colors.white,
          ),
          SizedBox(
            height: Dimensions.height30,
          ),
          // logout
          GestureDetector(
            onTap: (){
              exit(0);
            },
            child: SettingItems(
              imagePath: darkThemeBoolean == "false"
                  ? "assets/profile_icons/logout.png"
                  : "assets/profile_icons/dark_logout.png",
              itemName: AppLocale.exit,
            ),
          ),
        ],
      ),
    );});
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
