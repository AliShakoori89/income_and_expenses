import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:income_and_expenses/routes/route_helper.dart';
import 'package:income_and_expenses/const/app_colors.dart';

class ArrowBackIcon extends StatelessWidget {
  final String themeBoolean;
  const ArrowBackIcon({Key? key , required this.themeBoolean}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: (){
          Get.toNamed(RouteHelper.getInitial());
        },
        icon: Icon(Icons.arrow_back,
          color: themeBoolean == "false"
              ? Colors.white
              : AppColors.appBarTitleColor,));
  }
}
