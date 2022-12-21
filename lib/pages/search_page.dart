import 'package:flutter/material.dart';
import 'package:income_and_expenses/utils/app_colors.dart';
import 'package:income_and_expenses/utils/app_const.dart';
import 'package:income_and_expenses/utils/arrow_back_icon.dart';
import 'package:income_and_expenses/utils/dimensions.dart';
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
                  ArrowBackIcon(),
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
                  children: List.generate(AppConst.iconsName.length, (index){
                    return Container(
                      margin: EdgeInsets.all(Dimensions.width10),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.appBarTitleColor)
                      ),
                      child: Container(
                          margin: EdgeInsets.only(
                              left: Dimensions.width10,
                              right: Dimensions.width10),
                          child: Text("${AppConst.iconsName[index]}")),
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

