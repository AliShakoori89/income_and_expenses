import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:income_and_expenses/utils/app_colors.dart';
import 'package:income_and_expenses/utils/app_const.dart';
import 'package:income_and_expenses/utils/dimensions.dart';

class CategoryIconList extends StatefulWidget {
  CategoryIconList({Key? key}) : super(key: key);

  @override
  State<CategoryIconList> createState() => _CategoryIconListState();
}

class _CategoryIconListState extends State<CategoryIconList> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.linear_scale,
        color: AppColors.appBarTitleColor,),
        const Text("دسته بندی ها",
          style: TextStyle(
              color: AppColors.appBarTitleColor,
              fontWeight: FontWeight.w500
          ),),
        Expanded(
          child: SizedBox(
            // width: Dimensions.width45*5,
            // height: Dimensions.height45*5,
            child: GridView.count(
              padding: EdgeInsets.all(Dimensions.width30),
              scrollDirection: Axis.vertical,
              crossAxisCount: 3,
              shrinkWrap: true,
              children: List.generate(7, (index) {
                return GestureDetector(
                  onTap: (){

                  },
                  child: Column(
                    children: [
                      Container(
                        width: Dimensions.width45,
                        height: Dimensions.width45,
                        margin: EdgeInsets.all(Dimensions.width10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.colorList[index]
                        ),
                        child: Container(
                          margin: EdgeInsets.all(Dimensions.width10 / 1.4),
                          child: SvgPicture.asset(
                              "assets/logos/${AppConst.iconsImage[index]}"),
                        ),
                      ),
                      Text(AppConst.iconsName[index])
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
