import 'package:flutter/material.dart';
import 'package:income_and_expenses/utils/dimensions.dart';

import 'setting_items.dart';

class SettingItemList extends StatelessWidget {
  const SettingItemList({Key? key}) : super(key: key);

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
          SettingItems(
            imagePath: "assets/profile_icons/export_to_pdf.png",
            itemName: "خروجی PDF",),
          SizedBox(height: Dimensions.height30,),
          SettingItems(
            imagePath: "assets/profile_icons/choose_currency.png",
            itemName: "انتخاب واحد پول",),
          SizedBox(height: Dimensions.height30,),
          SettingItems(
            imagePath: "assets/profile_icons/choose_language.png",
            itemName: "انتخاب زبان",),
          SizedBox(height: Dimensions.height30,),
          SettingItems(
            imagePath: "assets/profile_icons/frequently_asked_questions.png",
            itemName: "سوالات متداول",),
          SizedBox(height: Dimensions.height30,),
          SettingItems(
            imagePath: "assets/profile_icons/logout.png",
            itemName: "خروج",),
        ],
      ),
    );
  }
}
