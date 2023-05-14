import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:income_and_expenses/const/app_colors.dart';
import 'package:income_and_expenses/utils/setting_item_list.dart';
import '../bloc/them_bloc/bloc.dart';
import '../bloc/them_bloc/state.dart';
import '../const/language.dart';


class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {

      var darkThemeBoolean = state.darkThemeBoolean;

      return Scaffold(
        backgroundColor: darkThemeBoolean == "false"
            ? Colors.white
            : AppColors.darkThemeColor,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height / 30,
        backgroundColor: darkThemeBoolean == "false"
            ? AppColors.profileAppBarColor
            : AppColors.darkThemeColor,
        elevation: 1,
        shadowColor: darkThemeBoolean == "false"
            ? AppColors.darkThemeColor
            : Colors.white,
        titleTextStyle: TextStyle(
          color: darkThemeBoolean == "false"
              ? AppColors.appBarTitleColor
              : Colors.white,
          fontSize: MediaQuery.of(context).size.width / 20,
          fontWeight: FontWeight.w700,),
        title: Align(
            alignment: Alignment.centerRight,
            child: Text(AppLocale.setting.getString(context))),
      ),
      body: SafeArea(
        child: Container(
            decoration: BoxDecoration(
                color: AppColors.themContainer,
                borderRadius: BorderRadius.circular(25)
            ),
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 30,
              right: MediaQuery.of(context).size.width / 30,
              top: MediaQuery.of(context).size.height / 60,
              bottom: MediaQuery.of(context).size.height / 30,
            ),
            child: const SettingItemList()),
      ),
    );});
  }
}
