import 'package:flutter/material.dart';
import 'package:income_and_expenses/utils/dimensions.dart';

class MainExpensesPageHeader extends StatelessWidget {
  const MainExpensesPageHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.add_chart),
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
            Icon(Icons.search,
              size: Dimensions.iconSize24,
              color: Color.fromRGBO(66,66,66,1.00),),
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
