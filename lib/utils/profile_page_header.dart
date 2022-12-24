import 'package:flutter/material.dart';
import 'package:income_and_expenses/utils/app_colors.dart';
import 'package:income_and_expenses/utils/dimensions.dart';

class ProfilePageHeader extends StatelessWidget {
  const ProfilePageHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.profileAppBarColor,
      width: Dimensions.screenWidth,
      height: Dimensions.profileHeaderHeight,
      child: Container(
        margin: EdgeInsets.only(
          left: Dimensions.width20,
          top: Dimensions.height20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Settings",
              style: TextStyle(
                  fontSize: Dimensions.font20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.appBarTitleColor

              ),),
            SizedBox(height: Dimensions.height20,),
            Row(
              children: [
                Container(
                  width: Dimensions.profileCircle,
                  height: Dimensions.profileCircle,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text("M",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: Dimensions.font26
                        )),
                  ),
                ),
                SizedBox(width: Dimensions.width10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("John Doe",
                      style: TextStyle(
                          fontSize: Dimensions.font16,
                          color: AppColors.appBarProfileName
                      ),),
                    Text("john.doe@gmail.com",
                      style: TextStyle(
                          fontSize: Dimensions.font12,
                          color: AppColors.appBarTitleColor,
                          fontWeight: FontWeight.w400
                      ),),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
