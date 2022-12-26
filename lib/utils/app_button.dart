import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'dimensions.dart';

class AppButton extends StatelessWidget {

  final String category;
  final String expense;
  final String description;
  // final String date;

  const AppButton({Key? key,
    required this.category,
    required this.expense,
    required this.description,
    // required this.date
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
      },
      child: Container(
        margin: EdgeInsets.only(
            left: Dimensions.width30,
            right: Dimensions.width30,
            bottom: Dimensions.height10
        ),
        // width: Dimensions.buttonWidth,
        height: Dimensions.buttonHeight,
        decoration: BoxDecoration(
          color: AppColors.buttonColor,
          borderRadius: BorderRadius.circular(Dimensions.radius20),
        ),
        child: const Center(
          child: Text("اضافه کردن هزینه",
              style: TextStyle(
                  color: AppColors.backGroundColor
              )),
        ),
      ),
    );
  }
}
