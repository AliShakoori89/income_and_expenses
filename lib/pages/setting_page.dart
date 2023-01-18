import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get/get.dart';
import 'package:income_and_expenses/bloc/change_language_bloc/bloc.dart';
import 'package:income_and_expenses/bloc/change_language_bloc/event.dart';
import 'package:income_and_expenses/bloc/change_language_bloc/state.dart';
import 'package:income_and_expenses/routes/route_helper.dart';
import 'package:income_and_expenses/const/app_colors.dart';
import 'package:income_and_expenses/const/dimensions.dart';
import '../const/language.dart';
import '../utils/setting_items.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  late TextEditingController languageController = TextEditingController();
  final FlutterLocalization _localization = FlutterLocalization.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: Dimensions.height30,
          right: Dimensions.width20,
          left: Dimensions.width20
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
            },
            child: const SettingItems(
              imagePath: "assets/profile_icons/export_to_pdf.png",
              itemName: AppLocale.export,
            ),
          ),
          SizedBox(
            height: Dimensions.height30,
          ),
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
                        Text(AppLocale.toman.getString(context)),
                        BlocBuilder<ChangeLanguageBloc, ChangeLanguageState>(
                          builder: (context, state) {
                            return Checkbox(
                              checkColor: Colors.white,
                              fillColor: MaterialStateProperty.resolveWith(getColor),
                              value: state.persianCheckBox,
                              onChanged: (bool? value) {
                                Navigator.of(ctx).pop();
                              });
                          })
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(AppLocale.rial.getString(context)),
                        BlocBuilder<ChangeLanguageBloc, ChangeLanguageState>(
                            builder: (context, state) {
                              return
                                Checkbox(
                                    checkColor: Colors.white,
                                    fillColor:
                                    MaterialStateProperty.resolveWith(getColor),
                                    value: state.englishCheckBox,
                                    onChanged: (bool? value) {
                                      Navigator.of(ctx).pop();
                                    });
                            }),
                      ],
                    ),
                  ],
                ),
              );
            },
            child: const SettingItems(
              imagePath: "assets/profile_icons/choose_currency.png",
              itemName: AppLocale.chooseCurrency,
            ),
          ),
          SizedBox(
            height: Dimensions.height30,
          ),
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
                        Text(AppLocale.persian.getString(context)),
                        BlocBuilder<ChangeLanguageBloc, ChangeLanguageState>(
                            builder: (context, state) {
                          return
                            Checkbox(
                              checkColor: Colors.white,
                              fillColor:
                                  MaterialStateProperty.resolveWith(getColor),
                              value: state.persianCheckBox,
                              onChanged: (bool? value) {
                                BlocProvider.of<ChangeLanguageBloc>(context)
                                    .add(ChangeToPersianLanguageTypeEvent(
                                  value: true,
                                ));
                                BlocProvider.of<ChangeLanguageBloc>(context)
                                    .add(ChangeToEnglishLanguageTypeEvent(
                                    value: false));
                                print("persian");
                                _localization.translate('fa');
                                Navigator.of(ctx).pop();
                              });
                        })
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(AppLocale.english.getString(context)),
                        BlocBuilder<ChangeLanguageBloc, ChangeLanguageState>(
                            builder: (context, state) {
                          return
                            Checkbox(
                              checkColor: Colors.white,
                              fillColor:
                                  MaterialStateProperty.resolveWith(getColor),
                              value: state.englishCheckBox,
                              onChanged: (bool? value) {
                                BlocProvider.of<ChangeLanguageBloc>(context)
                                    .add(ChangeToEnglishLanguageTypeEvent(
                                    value: true));
                                BlocProvider.of<ChangeLanguageBloc>(context)
                                    .add(ChangeToPersianLanguageTypeEvent(
                                  value: false,
                                ));
                                print("english");
                                _localization.translate('en');
                                Navigator.of(ctx).pop();
                              });
                        }),
                      ],
                    ),
                  ],
                ),
              );
            },
            child: const SettingItems(
              imagePath: "assets/profile_icons/choose_language.png",
              itemName: AppLocale.chooseLanguage,
            ),
          ),
          SizedBox(
            height: Dimensions.height30,
          ),
          GestureDetector(
            onTap: (){
              Get.toNamed(RouteHelper.getFrequentlyAskedQuestions());
            },
            child: const Center(
              child: SettingItems(
                imagePath: "assets/profile_icons/frequently_asked_questions.png",
                itemName: AppLocale.frequentlyAskedQuestions,
              ),
            ),
          ),
          SizedBox(
            height: Dimensions.height30,
          ),
          GestureDetector(
            onTap: (){
              exit(0);
            },
            child: const SettingItems(
              imagePath: "assets/profile_icons/logout.png",
              itemName: AppLocale.exit,
            ),
          ),
        ],
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
