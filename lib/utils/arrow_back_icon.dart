import 'package:flutter/material.dart';
import 'package:income_and_expenses/const/app_colors.dart';
import 'package:income_and_expenses/pages/home_page.dart';

import '../pages/main_expenses_page.dart';

class ArrowBackIcon extends StatelessWidget {
  final String themeBoolean;
  const ArrowBackIcon({Key? key , required this.themeBoolean}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyHomePage()));
        },
        icon: Icon(Icons.arrow_back,
          color: themeBoolean == "false"
              ? AppColors.appBarTitleColor
              : Colors.white,));
  }
}
