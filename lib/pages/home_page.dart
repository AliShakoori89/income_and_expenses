import 'package:flutter/material.dart';
import 'package:income_and_expenses/utils/app_colors.dart';
import 'package:income_and_expenses/utils/dimensions.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                right: Dimensions.width20,
                left: Dimensions.width20
              ),
              height: Dimensions.screenHeight / 8,
              decoration: const BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    image: AssetImage(
                      "assets/images/mainPic.png"
                    ))
              ),
            ),
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: Dimensions.width20,
                      right: Dimensions.width10,
                      left: Dimensions.width10
                  ),
                  height: Dimensions.pageViewTextContainer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(Dimensions.radius1)),
                    color: Colors.yellow,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(
                        right: Dimensions.width15*2,
                        left: Dimensions.width15*2
                    ),
                    height: Dimensions.screenHeight / 20,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(
                            Radius.circular(Dimensions.radius5))
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}