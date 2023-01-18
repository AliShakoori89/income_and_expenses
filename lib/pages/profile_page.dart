import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:income_and_expenses/const/app_colors.dart';
import 'package:income_and_expenses/const/dimensions.dart';
import 'package:income_and_expenses/utils/setting_item_list.dart';

import '../const/language.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.profileAppBarColor,
        elevation: 0,
        titleTextStyle: TextStyle(color: AppColors.appBarTitleColor,
          fontSize: Dimensions.font20,
          fontWeight: FontWeight.w700,),
        title: Align(
            alignment: Alignment.centerRight,
            child: Text(AppLocale.setting.getString(context))),
      ),
      body: SafeArea(
        child: SettingItemList(),
      ),
    );
  }
}
