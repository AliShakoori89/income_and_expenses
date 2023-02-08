import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:income_and_expenses/routes/route_helper.dart';
import 'package:income_and_expenses/const/app_colors.dart';
import 'package:income_and_expenses/const/dimensions.dart';

class MainExpensesPageHeader extends StatelessWidget {
  const MainExpensesPageHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Icons.add_chart),
            SizedBox(width: Dimensions.width10,),
            Text("Kitty", style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: Dimensions.font26
            ),)
          ],
        ),
        Row(
          children: [
            GestureDetector(
              onTap: (){
                Get.toNamed(RouteHelper.getSearchPage());
              },
              child: Icon(Icons.search,
                size: Dimensions.iconSize24,
                color: AppColors.appBarTitleColor,),
            ),
            SizedBox(width: Dimensions.width20,),
            Container(
              width: Dimensions.width30,
              height: Dimensions.height30,
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage("assets/images/userProfileImage.png"),
                  )
              ),
            ),
          ],
        )
      ],
    );
  }
}
