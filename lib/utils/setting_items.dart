import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:income_and_expenses/utils/app_colors.dart';
import 'package:income_and_expenses/utils/dimensions.dart';

class SettingItems extends StatelessWidget {

  final String imagePath;
  final String itemName;
  const SettingItems({Key? key,
    required this.imagePath,
  required this.itemName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [

        Container(
          width: Dimensions.screenWidth/1.35,
          margin: EdgeInsets.only(
            right: Dimensions.width20,
            left: Dimensions.width10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.arrow_back_ios,
                  color: AppColors.settingMenuItem,
                  size: Dimensions.iconSize16),
              Text(itemName.getString(context),
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: Dimensions.font16,
                    color: AppColors.appBarProfileName,
                ),),

            ],
          ),
        ),
        SizedBox(width: Dimensions.width10,),
        Container(
            width: Dimensions.width20,
            child: Image.asset(imagePath)),

      ],
    );
  }
}
