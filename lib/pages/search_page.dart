import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:income_and_expenses/const/app_colors.dart';
import 'package:income_and_expenses/const/app_const.dart';
import 'package:income_and_expenses/const/dimensions.dart';
import 'package:income_and_expenses/utils/search_text_field.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    late TextEditingController searchController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(
            left: Dimensions.width10,
            right: Dimensions.width10,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ArrowBackIcon(),
                  SearchTextField(searchController: searchController)
                ],
              ),
              Divider(
                color: AppColors.labelColor,
              ),
              SizedBox(height: Dimensions.height10,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(AppConst.iconsPersianName.length, (index){
                    return Container(
                      margin: EdgeInsets.all(Dimensions.width10),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.iconUnSelectedBackGroundMainColor)
                      ),
                      child: Container(
                          margin: EdgeInsets.only(
                              left: Dimensions.width10,
                              right: Dimensions.width10),
                          child: Row(
                            children: [
                              SizedBox(
                                width: Dimensions.width20/1.5,
                                height: Dimensions.width20/1.5,
                                child: SvgPicture.asset(
                                    "assets/logos/${AppConst.iconsImage[index]}",
                                color: AppColors.labelColor,),
                              ),
                              SizedBox(width: Dimensions.width10 / 2,),
                              Text("${AppConst.iconsPersianName[index]}"),
                            ],
                          )),
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

