import 'package:flutter/material.dart';
import 'package:income_and_expenses/const/app_colors.dart';

class ArrowBackIcon extends StatelessWidget {
  final String themeBoolean;
  const ArrowBackIcon({Key? key , required this.themeBoolean}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: (){
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back,
          size: MediaQuery.of(context).size.width / 25,
          color: themeBoolean == "false"
              ? AppColors.appBarTitleColor
              : Colors.white,));
  }
}
